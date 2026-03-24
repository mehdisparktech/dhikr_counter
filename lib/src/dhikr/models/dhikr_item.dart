import 'package:flutter/foundation.dart';

/// Immutable value object representing one dhikr phrase and its target count.
@immutable
class DhikrItem {
  /// Arabic phrase shown in the center circle.
  final String arabicText;

  /// Latin-script pronunciation.
  final String transliteration;

  /// English meaning displayed below transliteration.
  final String translation;

  /// Target repetitions for completing the current dhikr cycle.
  final int sessionGoal;

  const DhikrItem({
    required this.arabicText,
    required this.transliteration,
    required this.translation,
    required this.sessionGoal,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DhikrItem &&
          arabicText == other.arabicText &&
          transliteration == other.transliteration;

  @override
  int get hashCode => Object.hash(arabicText, transliteration);
}
