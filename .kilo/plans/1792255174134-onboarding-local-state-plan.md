# Local state for onboarding goal/availability sections

## Goal

Move onboarding selection state out of `OnboardingScreen`/`OnboardingContent` and into the two sections themselves using `setState`, and show `RecommendationCard` only when 3 days is selected.

## Decisions

- `GoalOptionsSection` owns the selected goal id locally (default `'get_strong'`, matching current behavior).
- `WeeklyAvailabilitySection` owns the selected day count locally (default `3`, matching current behavior).
- `RecommendationCard` is rendered inside `WeeklyAvailabilitySection` when `_selectedDays == 3` (confirmed with user). It is no longer rendered by `OnboardingContent`.
- Parent widgets stop passing selection values/callbacks. No external state management package is introduced.

## Tasks

1. `lib/feature/onboarding/ui/widgets/goal_options_section.dart`
   - Convert `GoalOptionsSection` to a `StatefulWidget`.
   - Remove `selectedGoalId` and `onGoalSelected` constructor params; keep `goals`.
   - Add `String _selectedGoalId = 'get_strong';` state and an `_selectGoal(String id)` method using `setState`.
   - In `build`, compare each goal against `_selectedGoalId` and call `_selectGoal` on tap.

2. `lib/feature/onboarding/ui/widgets/weekly_availability_section.dart`
   - Convert `WeeklyAvailabilitySection` to a `StatefulWidget`.
   - Remove `selectedDays` and `onSelected` constructor params; keep `options`.
   - Add `int _selectedDays = 3;` state and an `_selectDays(int days)` method using `setState`.
   - Pass `isSelected: option.days == _selectedDays` and `onSelected: _selectDays` to each `AvailabilityOptionTile`.
   - Import `recommendation_card.dart`; after the selector container, when `_selectedDays == 3`, render:
     ```dart
     const SizedBox(height: 32),
     const RecommendationCard(),
     ```
     Use a conditional spread or conditional child collection inside the existing `Column` so nothing renders otherwise.

3. `lib/feature/onboarding/ui/onboarding_content.dart`
   - Remove the `selectedGoalId`, `onGoalSelected`, `selectedDays`, and `onDaysSelected` fields and constructor params.
   - Remove the `recommendation_card.dart` import and the `RecommendationCard` usage plus its bottom `SizedBox` from the `Column`.
   - Pass only `goals` to `GoalOptionsSection` and only `options` to `WeeklyAvailabilitySection`.

4. `lib/feature/onboarding/ui/onboarding_screen.dart`
   - Remove `_selectedGoalId`, `_selectedDays`, `_selectGoal`, and `_selectDays`.
   - Convert to a `StatelessWidget` (or keep Stateful only if a later need appears; recommended: Stateless) and pass only `goals`/`availabilityOptions` to `OnboardingContent`.
   - Drop now-unused imports.

## Risks / notes

- Local state means the parent cannot read the selections (e.g. for `OnboardingBottomBar` "Continue"). If that is needed later, lift state or add callbacks; it is out of scope for this request.
- Default values keep the current initial UI identical, including the card being visible at start because the default is 3 days.
- `RecommendationCard` stays a `StatelessWidget`; no changes needed inside it.

## Validation

- `flutter analyze` passes with no unused imports/params.
- App run: tapping a goal changes the selected card only; tapping 2/4/5+ days hides `RecommendationCard`; tapping 3 days shows it below the selector; selection styling stays correct.
