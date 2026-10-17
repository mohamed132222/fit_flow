# Onboarding — Select Your Goal UI

## Goal

Implement the Figma onboarding screen (node `280-542`) as a UI-only feature:

- Goal selection cards (Build Muscle / Get Strong / General Fitness)
- Weekly availability segmented control
- Recommendation image card using `onboarding_image.png` + `on_boarding_shadow.png`
- Fixed header and bottom Continue bar
- Local `setState` selection only — no state management package
- Models live in `lib/feature/onboarding/data/models/`
- Assets referenced through **flutter_gen** generated classes (user-chosen)

Out of scope: repository, controller/bloc/riverpod, API calls, navigation after Continue.

## Design reference summary

Frame: 390 × ~1000, background `#F9F9F9`.

| Area | Spec |
|---|---|
| Header | 64 h, bg `#FBFBFB`, border `#F2F2F7`; "FitFlow" 20 w700 Plus Jakarta Sans `#2563EB`; help icon 40×40 |
| Content padding | 20 horizontal, 32 top |
| Heading | "Select Your Goal", 34 w800 Plus Jakarta Sans, `#1A1C1C`, height 1.25, letter-spacing -0.85 |
| Subtitle | "Customize your journey for precision\nperformance.", 15 w400 Inter `#434655`, height 1.5 |
| Goal cards | White, radius 12, padding 16, gap 12; unselected border 1 `#F2F2F7`; selected border 2 `#2563EB` |
| Card icon | 48×48, radius 8, bg `#F8FAFC`, SVG centered |
| Card title | 16 w700 Plus Jakarta Sans `#1A1C1C`, height 1.5 |
| Card description | 13 w400 Inter `#434655`, height 1.5 |
| Radio | 20×20; unselected border `#C3C6D7`; selected filled `#2563EB` with 8 white dot |
| Weekly title | "Weekly Availability", 18 w700 Plus Jakarta Sans, letter-spacing -0.45 |
| Segmented control | White, border `#F2F2F7`, radius 12, padding 4; selected pill `#2563EB`, radius 8, white 13 w700; others `#94A3B8` 13 w600 |
| Recommendation card | 350×150, radius 12, border `#F2F2F7`; image at 60% opacity + shadow overlay; labels bottom |
| Labels | "RECOMMENDED" 10 w700 blue, tracking 1; "Optimal recovery cycle" 11 w500 `#64748B` |
| Bottom bar | White 80%, top border `#F2F2F7`, padding 24; button 56 h blue, stadium, 17 w700 white + arrow; caption 10 w700 `#94A3B8`, tracking 1 |
| Initial selection | Get Strong; 3 Days |

## 1. Asset generation setup

`pubspec.yaml`:

- Add dev dependencies (latest stable looked up on pub.dev):
  - `build_runner: ^2.17.1`
  - `flutter_gen_runner: ^5.15.0`
- Add config:

```yaml
flutter_gen:
  output: lib/gen/
  line_length: 80
  integrations:
    image: true
    flutter_svg: true
```

Commands:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Expected generated names:

- `Assets.images.onboardingImage` (`onboarding_image.png`)
- `Assets.images.onBoardingShadow` (`on_boarding_shadow.png`)
- `Assets.images.fitness`, `Assets.images.bag`, `Assets.images.muscles`
- `Assets.images.fitflowLogo`

Also update `lib/feature/splash/ui/widgets/splash_logo.dart` to use
`Assets.images.fitflowLogo.svg()` so no raw asset path remains.

Record the chosen generator in `C:\Users\Legion\.cursor\rules\assets-management.md`
under **Chosen generator** (`flutter_gen_runner ^5.15.0`, build command above).

## 2. Theme

`lib/core/theme/app_colors.dart` — add:

```dart
static const Color background = Color(0xFFF9F9F9);
static const Color headerBackground = Color(0xFFFBFBFB);
static const Color textPrimary = Color(0xFF1A1C1C);
static const Color textSecondary = Color(0xFF434655);
static const Color border = Color(0xFFF2F2F7);
static const Color iconTileBackground = Color(0xFFF8FAFC);
static const Color muted = Color(0xFF94A3B8);
static const Color radioBorder = Color(0xFFC3C6D7);
static const Color hint = Color(0xFF64748B);
```

`lib/core/theme/app_styles.dart` — add Plus Jakarta Sans / Inter styles:

- `font34ExtraBold` (heading)
- `font20Bold` (logo)
- `font18Bold` (section title)
- `font16Bold` (card title)
- `font15Regular` (subtitle), `font13Regular` (card body)
- `font13BoldWhite`, `font13SemiBoldMuted` (segments)
- `font17Bold` (button)
- `font11MediumHint` (recommendation caption)
- `font10BoldMuted`, `font10BoldPrimary` (bottom caption / recommended)

Colors that differ only by color reuse `copyWith` where sensible.

## 3. Data layer models

`lib/feature/onboarding/data/models/goal_option.dart`

```dart
import '../../../../gen/assets.gen.dart';

class GoalOption {
  const GoalOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String id;
  final String title;
  final String description;
  final SvgGenImage icon;
}
```

`lib/feature/onboarding/data/models/availability_option.dart`

```dart
class AvailabilityOption {
  const AvailabilityOption({required this.days, required this.label});

  final int days;
  final String label;
}
```

Example data (`final`, not `const`, because generated asset getters are not const):

```dart
final _goals = [
  GoalOption(
    id: 'build_muscle',
    title: 'Build Muscle',
    description: 'Focus on hypertrophy and\nstrength.',
    icon: Assets.images.muscles,
  ),
  GoalOption(
    id: 'get_strong',
    title: 'Get Strong',
    description: 'Prioritize heavy lifting and power.',
    icon: Assets.images.bag,
  ),
  GoalOption(
    id: 'general_fitness',
    title: 'General Fitness',
    description: 'Balanced health and mobility.',
    icon: Assets.images.fitness,
  ),
];

const _availabilityOptions = [
  AvailabilityOption(days: 2, label: '2 Days'),
  AvailabilityOption(days: 3, label: '3 Days'),
  AvailabilityOption(days: 4, label: '4 Days'),
  AvailabilityOption(days: 5, label: '5+ Days'),
];
```

## 4. UI widgets

All under `lib/feature/onboarding/ui/widgets/`:

1. `onboarding_header.dart`
   - `OnboardingHeader({required VoidCallback onHelpPressed})`
   - Row: `Text('FitFlow', style: AppStyles.font20Bold)` / 40×40 help `IconButton` (`Icons.help_outline`).
   - Container 64 h, bg, bottom border.

2. `goal_option_card.dart`
   - `GoalOptionCard({required GoalOption goal, required bool isSelected, required VoidCallback onTap})`
   - `Material` + `RoundedRectangleBorder` (1px `border`, 2px `primary` when selected) + `InkWell` + 16 padding.
   - Row: 48×48 icon tile (`goal.icon.svg(width: 22, height: 22)`), 16 gap, `Expanded` title/description, `GoalRadioIndicator`.
   - Pass the whole `GoalOption` model, not unpacked strings.

3. `goal_radio_indicator.dart`
   - 20×20 circle; outlined when unselected; filled blue + 8×8 white dot when selected.

4. `availability_option_tile.dart`
   - `AvailabilityOptionTile({required AvailabilityOption option, required bool isSelected, required ValueChanged<int> onSelected})`
   - `Material` pill (radius 8, blue when selected, subtle shadow), `InkWell`, vertical padding 12, centered label.

5. `weekly_availability_section.dart`
   - `WeeklyAvailabilitySection({required List<AvailabilityOption> options, required int selectedDays, required ValueChanged<int> onSelected})`
   - Title + 16 gap + white bordered container (padding 4) with `Row` of `Expanded` tiles.

6. `recommendation_card.dart`
   - 150 h, white, radius 12, border, `clipBehavior: Clip.antiAlias`.
   - `Stack`:
     - `Opacity(0.6)` + `Assets.images.onboardingImage.image(fit: BoxFit.cover)`
     - `Assets.images.onBoardingShadow.image(fit: BoxFit.cover)` (bottom fade overlay)
     - Bottom row (left/right 16, bottom 18): `RECOMMENDED` + `Optimal recovery cycle`.

7. `onboarding_bottom_bar.dart`
   - `OnboardingBottomBar({required VoidCallback onContinue})`
   - Container white 80%, top border, padding 24.
   - 56 h `FilledButton` / stadium, blue, `Continue` + `Icons.arrow_forward_rounded` (8 gap).
   - 16 gap + uppercase caption.

No private helper widgets at the bottom of widget files; each widget in its own file.

## 5. Screen composition

`lib/feature/onboarding/ui/onboarding_screen.dart` — convert to `StatefulWidget`:

```dart
String _selectedGoalId = 'get_strong';
int _selectedDays = 3;
```

Structure:

```dart
AnnotatedRegion<SystemUiOverlayStyle>(
  value: SystemUiOverlayStyle.dark,
  child: Scaffold(
    backgroundColor: AppColors.background,
    body: Column(
      children: [
        ColoredBox(               // header colour behind status bar
          color: AppColors.headerBackground,
          child: SafeArea(bottom: false, child: OnboardingHeader(...)),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // heading + 8 gap + subtitle
                // 32 gap
                // goal cards (12 gap) with selection callbacks
                // 40 gap
                // WeeklyAvailabilitySection
                // 32 gap
                // RecommendationCard
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: OnboardingBottomBar(onContinue: () {}),
        ),
      ],
    ),
  ),
)
```

- Tapping a card updates `_selectedGoalId`.
- Tapping an availability tile updates `_selectedDays`.
- Continue is a no-op (UI-only).
- Use `const` wherever possible for static children.

## 6. Validation

- `flutter pub get`
- `dart run build_runner build --delete-conflicting-outputs`
- `flutter analyze` (no errors/warnings)
- Manual check at 390 width against the provided screenshot:
  - header/status bar colours, title wrap, card borders/radio, 3 Days pill, image overlay labels, fixed bottom bar.

## Notes / decisions

- `on_boarding_shadow.png` is treated as the image's white fade overlay, replacing the placeholder gradient in the supplied HTML-style code.
- Selection is local UI state (`setState`), not a state-management solution.
- No `build.yaml` needed; `pubspec.yaml` config is sufficient for flutter_gen.
