// lib/src/features/dhikr/providers/dhikr_provider.dart

import 'package:dhikr_counter/src/dhikr/providers/dhikr_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dhikr_notifier.dart';

/// Primary state provider consumed by the feature UI.
final dhikrProvider = StateNotifierProvider<DhikrNotifier, DhikrState>(
  (ref) => DhikrNotifier(),
);

/// Derived provider that formats the live count with thousands separators.
/// Example: `2841093` -> `2,841,093`.
final globalCountFormattedProvider = Provider<String>((ref) {
  final count = ref.watch(
    dhikrProvider.select((s) => s.globalCount),
  );
  return _formatWithCommas(count);
});

/// Lightweight formatter to avoid bringing an intl dependency for one use case.
String _formatWithCommas(int number) {
  final str = number.toString();
  final buffer = StringBuffer();
  int counter = 0;
  for (int i = str.length - 1; i >= 0; i--) {
    if (counter > 0 && counter % 3 == 0) buffer.write(',');
    buffer.write(str[i]);
    counter++;
  }
  return buffer.toString().split('').reversed.join('');
}
