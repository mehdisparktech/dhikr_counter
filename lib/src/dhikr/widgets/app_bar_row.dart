import 'package:dhikr_counter/core/constants/app_colors.dart';
import 'package:dhikr_counter/core/constants/app_strings.dart';
import 'package:dhikr_counter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Top row containing screen title and quick reset action.
class AppBarRow extends StatelessWidget {
  final VoidCallback onReset;

  const AppBarRow({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    final btnSize = Responsive.scale(context, 40);

    return Row(
      children: [
        _CircleIconButton(
          icon: Icons.chevron_left,
          size: btnSize,
          onTap: () {},
        ),
        SizedBox(width: Responsive.scale(context, 14)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.screenTitleDhikr,
              style: AppTextStyles.appBarTitle(context),
            ),
            const SizedBox(height: 1),
            Text(
              AppStrings.subtitleJoined,
              style: AppTextStyles.appBarSubtitle(context),
            ),
          ],
        ),

        const Spacer(),

        _CircleIconButton(
          icon: Icons.refresh,
          size: btnSize,
          onTap: onReset,
        ),
      ],
    );
  }
}

/// Reusable circular icon button used by the app bar row.
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surfaceElevated,
          border: Border.all(color: AppColors.circleBorder),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: size * 0.5),
      ),
    );
  }
}
