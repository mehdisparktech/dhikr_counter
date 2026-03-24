# Dhikr Counter — Flutter + Riverpod

A polished **Dhikr Counter** app built with Flutter and Riverpod. The app lets users perform and track daily Islamic remembrance (dhikr) through an elegant dark-gold interface featuring a live global count simulation, circular progress tracking, tap/voice mode toggle, and session goal management.

---

## Preview

> Dark background, gold Arabic calligraphy inside a glowing progress circle, live global count ticker, tap-to-recite interaction, voice mode toggle, animated session goal bar, and a completion dialog that offers "Next" / "Again" options.

---

## Setup Instructions

### Prerequisites

- Flutter SDK `>=3.0.0` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK `>=3.0.0` (bundled with Flutter)
- Android emulator, iOS Simulator, or a physical device

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/dhikr_counter.git
cd dhikr_counter

# 2. Install dependencies
flutter pub get

# 3. Run on a connected device / emulator
flutter run

# 4. Build a release APK (Android)
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

> **Font note:** The `Amiri` Arabic font is bundled in `assets/fonts/`. The Latin fonts (Playfair Display, Rajdhani) are loaded at runtime via the `google_fonts` package.

---

## Project Structure

```
dhikr_counter/
├── lib/
│   ├── main.dart                           # Entry point — ProviderScope, orientation lock, system UI
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart             # Centralized color palette (30+ semantic tokens)
│   │   │   └── app_strings.dart            # All user-visible copy
│   │   └── theme/
│   │       └── app_theme.dart              # Responsive helpers, AppTextStyles, ThemeData
│   └── src/
│       ├── app.dart                        # MaterialApp root
│       └── dhikr/
│           ├── models/
│           │   └── dhikr_item.dart         # Immutable DhikrItem data class
│           ├── providers/
│           │   ├── dhikr_state.dart        # Immutable state snapshot with computed getters
│           │   ├── dhikr_notifier.dart     # StateNotifier — business logic & timer
│           │   └── dhikr_provider.dart     # Riverpod provider definitions + derived providers
│           ├── screens/
│           │   └── dhikr_screen.dart       # Main screen — layout, animations, dialog listener
│           └── widgets/
│               ├── dhikr_circle.dart       # Tap circle with pulse + scale animations
│               ├── circular_progress_painter.dart  # CustomPainter for arc + glow dot
│               ├── global_live_count.dart  # Animated live count + pulsing green dot
│               ├── session_goal_bar.dart   # Progress bar with animated percentage
│               ├── completion_dialog.dart  # Goal-reached dialog with elastic animations
│               ├── app_bar_row.dart        # Title row with back/reset circle buttons
│               └── voice_toggle_button.dart # Tap ↔ Voice mode toggle
├── assets/
│   └── fonts/
│       ├── Amiri-Regular.ttf
│       └── Amiri-Bold.ttf
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

### Architecture at a Glance

| Layer | Folder | Responsibility |
|---|---|---|
| **Core** | `lib/core/` | Colors, strings, responsive utilities, theme |
| **Models** | `lib/src/dhikr/models/` | Immutable data classes (`DhikrItem`) |
| **State** | `lib/src/dhikr/providers/` | Riverpod providers, `StateNotifier`, state snapshot |
| **Screens** | `lib/src/dhikr/screens/` | Top-level screen widgets (layout + wiring) |
| **Widgets** | `lib/src/dhikr/widgets/` | Reusable, stateless/stateful UI components |

---

## State Management — Riverpod

All state is managed via **Riverpod** following a unidirectional data flow.

### `DhikrItem` (model)

Immutable value object holding the dhikr text variants and session goal:

```dart
@immutable
class DhikrItem {
  final String arabicText;
  final String transliteration;
  final String translation;
  final int sessionGoal;
}
```

### `DhikrState` (state snapshot)

Immutable snapshot of the entire screen state with computed getters:

| Field | Type | Description |
|---|---|---|
| `dhikr` | `DhikrItem` | Current dhikr (Arabic, transliteration, translation, goal) |
| `currentCount` | `int` | User's tap count this session |
| `globalCount` | `int` | Simulated global live count |
| `isVoiceMode` | `bool` | Voice / tap mode toggle |
| `pendingCompletionDialog` | `bool` | Flags the UI to show the completion dialog |

Computed: `progressPercent`, `progressPercentInt`, `isCompleted`.

Proper `==` and `hashCode` overrides ensure correct change detection.

### `DhikrNotifier` (StateNotifier)

Owns all business logic:

- `increment()` — increases local + global count; triggers completion flag at goal
- `nextDhikr()` — cycles through the 3-dhikr list, resets counter
- `reset()` — resets the local counter without changing the current dhikr
- `toggleVoiceMode()` — flips voice/tap state
- Internal `Timer` simulates the global count ticking every 3 seconds

### Provider Definitions

```dart
// Primary state provider — widgets watch this for reactive rebuilds
final dhikrProvider = StateNotifierProvider<DhikrNotifier, DhikrState>(...);

// Derived provider — formatted global count (e.g. "2,841,093")
// Only rebuilds when globalCount changes (select-based optimization)
final globalCountFormattedProvider = Provider<String>(...);
```

The `GlobalLiveCount` widget watches only `globalCountFormattedProvider`, avoiding unnecessary rebuilds when only the local counter changes.

---

## Responsiveness

The app adapts to different screen sizes through multiple mechanisms:

| Technique | Where | How |
|---|---|---|
| **`Responsive.scale()`** | `AppTextStyles`, spacing values | Clamp-based multiplier: `(screenWidth / 375).clamp(0.85, 1.25)` |
| **`Responsive.circleSize()`** | `DhikrCircle` | Picks the smaller of width×0.72 and height×0.40, clamped 200–340 |
| **`Responsive.horizontalPadding()`** | `DhikrScreen` | 20px → 28px → 48px based on width breakpoints |
| **`LayoutBuilder`** | `DhikrScreen` | `ConstrainedBox` uses parent constraints for minimum height |
| **Compact mode** | `DhikrScreen` | Reduces spacing when `height < 640` |
| **`MediaQuery.sizeOf()`** | All responsive helpers | More efficient than `MediaQuery.of()` — only rebuilds on size change |

---

## Assumptions

1. **Global Count** — Simulated locally with a `Timer` (no real backend).
2. **Voice Mode** — Toggles a visual indicator only; actual speech recognition is out of scope.
3. **Three Dhikrs** — Cycles through SubhanAllah (33), Alhamdulillah (33), Allahu Akbar (34).
4. **No Persistence** — Counter resets on app restart. A production version would use SharedPreferences or Hive.
5. **Fonts** — `Amiri` is bundled for offline Arabic rendering; Latin fonts use `google_fonts` (requires network on first load, then cached).

---

## Creative Additions Beyond the Reference

| Feature | Description |
|---|---|
| **Staggered entry animations** | `flutter_animate` drives fade + slide entry for every section on first build |
| **Elastic completion dialog** | The star emoji scales in with `Curves.elasticOut`; dialog itself scales from 85% |
| **Animated dhikr cross-fade** | Arabic text, transliteration, and translation cross-fade with `AnimatedSwitcher` on dhikr change |
| **Custom arc painter** | `CircularProgressPainter` draws a sweep-gradient arc with a glowing tip dot and a breathing pulse ring |
| **Haptic feedback** | `HapticFeedback.mediumImpact()` on every tap |
| **Tap scale animation** | Circle scales to 94% on press and springs back |
| **Fluid font scaling** | `Responsive.scale()` adapts all text from 320px phones to 700px+ tablets |
| **Compact mode** | Spacing automatically tightens on short screens (< 640px height) |
| **Pulsing live dot** | Green dot pulses with opacity animation to indicate live status |
| **Proper immutability** | `DhikrState` and `DhikrItem` have `@immutable`, `==`, and `hashCode` |

---

## Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter_riverpod` | ^2.4.9 | State management |
| `riverpod_annotation` | ^2.3.3 | Code generation annotations |
| `google_fonts` | ^6.1.0 | Playfair Display & Rajdhani runtime fonts |
| `flutter_animate` | ^4.5.0 | Declarative entry and dialog animations |

---

## APK

Download the release APK: **[Google Drive Link]**

## Screen Recording

Watch the demo video: **[Google Drive Link]**

---

*Built with clean architecture, Riverpod state management, responsive design, and a polished dark-gold UI.*
