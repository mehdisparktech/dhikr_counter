import 'package:flutter/foundation.dart';

import '../models/dhikr_item.dart';

export '../models/dhikr_item.dart';

/// Immutable UI state snapshot for the dhikr screen.
@immutable
class DhikrState {
  /// Current selected dhikr content.
  final DhikrItem dhikr;

  /// Number of recitations in the current session.
  final int currentCount;

  /// Simulated global live count shown at the top.
  final int globalCount;

  /// UI mode toggle; currently visual-only.
  final bool isVoiceMode;

  /// Flagged by notifier when session goal is met; UI shows dialog then clears.
  final bool pendingCompletionDialog;

  const DhikrState({
    required this.dhikr,
    required this.currentCount,
    required this.globalCount,
    this.isVoiceMode = false,
    this.pendingCompletionDialog = false,
  });

  /// Fraction between 0.0 and 1.0 representing goal completion.
  double get progressPercent =>
      dhikr.sessionGoal > 0
          ? (currentCount / dhikr.sessionGoal).clamp(0.0, 1.0)
          : 0.0;

  /// Rounded completion percentage for display.
  int get progressPercentInt => (progressPercent * 100).round();

  /// Whether the current dhikr goal has been reached.
  bool get isCompleted => currentCount >= dhikr.sessionGoal;

  DhikrState copyWith({
    DhikrItem? dhikr,
    int? currentCount,
    int? globalCount,
    bool? isVoiceMode,
    bool? pendingCompletionDialog,
  }) {
    return DhikrState(
      dhikr: dhikr ?? this.dhikr,
      currentCount: currentCount ?? this.currentCount,
      globalCount: globalCount ?? this.globalCount,
      isVoiceMode: isVoiceMode ?? this.isVoiceMode,
      pendingCompletionDialog:
          pendingCompletionDialog ?? this.pendingCompletionDialog,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DhikrState &&
          dhikr == other.dhikr &&
          currentCount == other.currentCount &&
          globalCount == other.globalCount &&
          isVoiceMode == other.isVoiceMode &&
          pendingCompletionDialog == other.pendingCompletionDialog;

  @override
  int get hashCode => Object.hash(
        dhikr,
        currentCount,
        globalCount,
        isVoiceMode,
        pendingCompletionDialog,
      );
}
