/// User-visible copy for the Dhikr Counter app.
class AppStrings {
  AppStrings._();

  static const appTitle = 'Dhikr Counter';

  static const screenTitleDhikr = 'Dhikr';
  static const subtitleJoined = 'JOINED';

  static const tapToRecite = 'TAP TO RECITE';

  static const sessionGoal = 'SESSION GOAL';
  static String sessionCompletePercent(int percent) =>
      '$percent% COMPLETE';

  static const globalLiveCount = 'GLOBAL LIVE COUNT';
  static const totalRecitationsToday = 'TOTAL RECITATIONS TODAY';

  static const changeToTap = 'CHANGE TO TAP';
  static const changeToVoice = 'CHANGE TO VOICE';

  static const completionEmoji = '✨';
  static const mashallah = 'MASHALLAH!';
  static String youCompleted(String dhikrName) => 'You completed $dhikrName';

  static const again = 'AGAIN';
  static const next = 'NEXT';

  static const fontFamilyArabic = 'Amiri';
}
