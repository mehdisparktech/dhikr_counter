import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:dhikr_counter/src/dhikr/providers/dhikr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/dhikr_provider.dart';
import '../widgets/app_bar_row.dart';
import '../widgets/completion_dialog.dart';
import '../widgets/dhikr_circle.dart';
import '../widgets/global_live_count.dart';
import '../widgets/session_goal_bar.dart';
import '../widgets/voice_toggle_button.dart';

/// Main screen that orchestrates dhikr UI, animations, and completion flow.
class DhikrScreen extends ConsumerWidget {
  const DhikrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dhikrProvider);

    // Listen for one-shot completion events and trigger dialog presentation.
    ref.listen<DhikrState>(dhikrProvider, (previous, next) {
      if (!next.pendingCompletionDialog) return;
      if (previous?.pendingCompletionDialog == true) return;

      Future.delayed(const Duration(milliseconds: 200), () {
        if (!context.mounted) return;
        final notifier = ref.read(dhikrProvider.notifier);
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          barrierColor: AppColors.barrierScrim,
          builder: (_) => CompletionDialog(
            dhikrName: next.dhikr.transliteration,
            onNext: () {
              Navigator.of(context).pop();
              notifier.onCompletionDialogNext();
            },
            onReset: () {
              Navigator.of(context).pop();
              notifier.onCompletionDialogReset();
            },
          ),
        );
      });
    });

    final size = MediaQuery.sizeOf(context);
    final hPad = Responsive.horizontalPadding(context);
    final isCompact = size.height < 640;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Radial gold glow behind circle
            Positioned(
              top: -80,
              left: size.width / 2 - 180,
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.gold.withAlpha(13),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                // Scroll wrapper keeps content usable on short-height devices.
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: Column(
                        children: [
                          SizedBox(height: isCompact ? 8 : 16),

                          AppBarRow(
                            onReset: () =>
                                ref.read(dhikrProvider.notifier).reset(),
                          ).animate().fadeIn(
                                duration: 400.ms,
                                curve: Curves.easeOut,
                              ),

                          SizedBox(height: isCompact ? 20 : 36),

                          const GlobalLiveCount()
                              .animate()
                              .fadeIn(delay: 100.ms, duration: 500.ms)
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                duration: 500.ms,
                                curve: Curves.easeOut,
                              ),

                          SizedBox(height: isCompact ? 24 : 40),

                          Center(
                            child: DhikrCircle(
                              dhikrState: state,
                              onTap: () =>
                                  ref.read(dhikrProvider.notifier).increment(),
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 200.ms, duration: 600.ms)
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1, 1),
                                delay: 200.ms,
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              ),

                          SizedBox(height: isCompact ? 20 : 32),

                          Text(
                            AppStrings.tapToRecite,
                            style: AppTextStyles.tapToRecite(context),
                          )
                              .animate()
                              .fadeIn(delay: 400.ms, duration: 400.ms),

                          SizedBox(height: isCompact ? 10 : 14),

                          VoiceToggleButton(
                            isVoiceMode: state.isVoiceMode,
                            onToggle: () => ref
                                .read(dhikrProvider.notifier)
                                .toggleVoiceMode(),
                          )
                              .animate()
                              .fadeIn(delay: 500.ms, duration: 400.ms),

                          SizedBox(height: isCompact ? 24 : 40),

                          SessionGoalBar(dhikrState: state)
                              .animate()
                              .fadeIn(delay: 600.ms, duration: 500.ms)
                              .slideY(
                                begin: 0.15,
                                end: 0,
                                delay: 600.ms,
                                duration: 500.ms,
                                curve: Curves.easeOut,
                              ),

                          SizedBox(height: isCompact ? 16 : 28),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
