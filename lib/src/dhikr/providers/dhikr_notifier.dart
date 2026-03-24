// lib/src/features/dhikr/providers/dhikr_notifier.dart

import 'dart:async';

import 'package:dhikr_counter/src/dhikr/providers/dhikr_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Ordered dhikr sequence traditionally recited in one tasbih cycle.
const List<DhikrItem> kDhikrList = [
  DhikrItem(
    arabicText: 'سُبْحَانَ اللَّهِ',
    transliteration: 'SUBHANALLAH',
    translation: 'GLORY BE TO ALLAH',
    sessionGoal: 33,
  ),
  DhikrItem(
    arabicText: 'الْحَمْدُ لِلَّهِ',
    transliteration: 'ALHAMDULILLAH',
    translation: 'ALL PRAISE TO ALLAH',
    sessionGoal: 33,
  ),
  DhikrItem(
    arabicText: 'اللَّهُ أَكْبَرُ',
    transliteration: 'ALLAHU AKBAR',
    translation: 'ALLAH IS THE GREATEST',
    sessionGoal: 34,
  ),
];

/// State controller that owns dhikr business logic and side effects.
class DhikrNotifier extends StateNotifier<DhikrState> {
  DhikrNotifier()
      : super(
          DhikrState(
            dhikr: kDhikrList.first,
            currentCount: 0,
            globalCount: 2841092,
          ),
        ) {
    _startGlobalCountSimulation();
  }

  int _dhikrIndex = 0;
  Timer? _globalTimer;

  /// Simulates a live global recitation count ticking up every 3 seconds
  void _startGlobalCountSimulation() {
    _globalTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      state = state.copyWith(globalCount: state.globalCount + 1);
    });
  }

  /// Tap to recite — increments local + global count; flags completion dialog when goal is met.
  void increment() {
    final wasCompleted = state.isCompleted;
    state = state.copyWith(
      currentCount: state.currentCount + 1,
      globalCount: state.globalCount + 1,
    );
    if (!wasCompleted && state.isCompleted) {
      state = state.copyWith(pendingCompletionDialog: true);
    }
  }

  /// Advance to the next dhikr and reset counter
  void nextDhikr() {
    _dhikrIndex = (_dhikrIndex + 1) % kDhikrList.length;
    state = state.copyWith(
      dhikr: kDhikrList[_dhikrIndex],
      currentCount: 0,
      pendingCompletionDialog: false,
    );
  }

  /// Reset local counter only (dhikr stays the same)
  void reset() {
    state = state.copyWith(
      currentCount: 0,
      pendingCompletionDialog: false,
    );
  }

  /// After completion dialog: go to next dhikr (dialog should be popped by UI).
  void onCompletionDialogNext() {
    nextDhikr();
  }

  /// After completion dialog: reset count for same dhikr (dialog should be popped by UI).
  void onCompletionDialogReset() {
    reset();
  }

  /// Toggle between tap mode and voice mode
  void toggleVoiceMode() {
    state = state.copyWith(isVoiceMode: !state.isVoiceMode);
  }

  @override
  void dispose() {
    _globalTimer?.cancel();
    super.dispose();
  }
}
