# Figma MCP Authorization + FitFlow Onboarding UI

## Goal

1. Connect Kilo to Figma's remote MCP server and authorize it with the user's Figma account.
2. Pull frame `280-542` from `Fit_Flow` and build the onboarding UI with 1:1 visual fidelity.
3. Keep the screen stateless (no state management) and put the onboarding model in the feature data layer.

Figma target:

- File key: `rXjpN296OzLQnYzdVQbBu1`
- Node ID: `280:542` (URL value `280-542`)
- URL: `https://www.figma.com/design/rXjpN296OzLQnYzdVQbBu1/Fit_Flow?node-id=280-542&m=dev`

## Decisions

- Use the **remote** Figma MCP server (`https://mcp.figma.com/mcp`). No Figma desktop app required.
- Add the server to the **global** config so it is not committed to this repo: `C:\Users\Legion\.config\kilo\kilo.jsonc`.
- Model lives in `lib/feature/onboarding/data/models/` (feature data layer), not a global `lib/data/`.
- Static feature list lives in `lib/feature/onboarding/data/`; no repository, provider, bloc, or controller.
- CTA navigation is out of scope; the button is UI-only.
- Keep using `flutter_svg` and the existing raw asset path convention (the project has no asset code generator; `splash_logo.dart` already uses raw paths).

## Phase 1 — Enable Figma MCP

1. Edit `C:\Users\Legion\.config\kilo\kilo.jsonc` and add this top-level `mcp` block (merge with existing keys, do not replace the file):

```jsonc
"mcp": {
  "figma": {
    "type": "remote",
    "url": "https://mcp.figma.com/mcp",
    "enabled": true
  }
}
```

2. Add read-only Figma tool permissions inside the existing `permission` object. Order matters (last match wins):

```jsonc
"figma_*": "ask",
"figma_get_*": "allow",
"figma_whoami": "allow"
```

3. Restart Kilo so it loads the new MCP server. Verify with the TUI `/mcps` screen or `kilo mcp list`.
4. Authenticate the server:
   - Preferred: `/mcps` -> select `figma` -> Authenticate. This opens the browser.
   - Fallback: run `kilo mcp auth figma` in a terminal.
5. User completes Figma OAuth in the browser and grants access to the `Fit_Flow` file.
6. Confirm auth and connectivity with `kilo mcp list`, then call `whoami` / `get_metadata` once.

Notes:

- The user's Figma plan/seat must allow MCP access; the file must be accessible to the authorizing account.
- Do not paste or commit OAuth tokens; Kilo stores them outside the repo.
- If OAuth succeeds but `get_design_context` returns 403, the account lacks file access or the org blocks the MCP app.

## Phase 2 — Extract the Design

Use the `figma-implement-design` skill after MCP auth.

1. Call `get_metadata(fileKey="rXjpN296OzLQnYzdVQbBu1", nodeId="280:542")` to map the frame.
2. Call `get_design_context` for the frame, then per child section if the response is truncated.
3. Call `get_screenshot` for the frame; keep it as the visual source of truth.
4. Call `get_variable_defs` if the design uses Figma variables/color styles.
5. Record exact values needed for implementation: frame size, padding, gaps, radii, colors, font family/sizes/weights/line heights, text copy, asset placement, and shadow usage.

Do not guess copy or measurements. The MCP payload overrides assumptions.

## Phase 3 — Implement

### Data layer

Create `lib/feature/onboarding/data/models/onboarding_feature.dart`:

- Immutable class with fields derived from the design, likely `title`, `description`, `iconAsset`.
- `const` constructor.
- No JSON, no state management.

Create `lib/feature/onboarding/data/onboarding_features.dart`:

- `const List<OnboardingFeature> onboardingFeatures = [...]` matching the three Figma items.
- Icons map to `assets/images/fitness.svg`, `assets/images/bag.svg`, `assets/images/muscles.svg`.

### Theme

Update only what the screen needs:

- `lib/core/theme/app_colors.dart`: add design colors not already present.
- `lib/core/theme/app_styles.dart`: add the text styles used by the screen (Lexend is already loaded via `google_fonts`).
- Do not duplicate one-off styles inside widgets.

### UI

Rewrite `lib/feature/onboarding/ui/onboarding_screen.dart` as a `StatelessWidget` composition. Extract each distinct section into its own file under `lib/feature/onboarding/ui/widgets/`, for example:

- `onboarding_hero.dart` — `onboarding_image.png` with `on_boarding_shadow.png` layered/positioned as in Figma.
- `onboarding_feature_card.dart` — one reusable item driven by `OnboardingFeature`.
- `onboarding_cta.dart` — primary button from the design.

Rules:

- Reuse `OnboardingFeature` as the single input to the card; do not unpack primitives.
- Use `const` constructors and `const` children wherever possible.
- Use `SvgPicture.asset` for the three SVGs and `Image.asset` for the PNGs.
- Use `SafeArea`, `LayoutBuilder`/`Flexible` so the layout does not overflow at 360x640.
- Match Figma constraints; keep the hero image non-distorted (`BoxFit.cover`/`contain` as the design dictates).
- No comments unless explicitly requested.
- No `setState`, controllers, or state packages.

### Files expected

- `lib/feature/onboarding/data/models/onboarding_feature.dart` (new)
- `lib/feature/onboarding/data/onboarding_features.dart` (new)
- `lib/feature/onboarding/ui/onboarding_screen.dart` (replace)
- `lib/feature/onboarding/ui/widgets/*.dart` (new, one widget per file)
- `lib/core/theme/app_colors.dart` / `app_styles.dart` (only if the design needs new tokens)
- `pubspec.yaml` only if a new dependency is genuinely required (none expected)

## Validation

1. `flutter analyze` passes with no new issues.
2. Run on a phone-sized viewport (Figma frame size, e.g. 390x844) and compare against the MCP `get_screenshot` output.
3. Check: spacing, radii, typography, colors, hero/shadow alignment, SVG rendering, no overflow, safe areas.
4. Verify the screen renders with no state management and the three features come from the model/list.
5. `flutter test` if any tests exist after the change.

## Risks / Open Questions

- Figma OAuth cannot be completed by the agent alone; the user must approve access in the browser.
- Remote MCP access depends on the Figma plan/seat and org permissions.
- The Figma payload may return React/Tailwind code; translate it to Flutter conventions instead of copying it.
- No asset generator is configured; raw paths are used for consistency with the existing splash screen. Adding `flutter_gen` is out of scope.

## Out of Scope

- State management, onboarding completion persistence, and routing after the CTA.
- New screens beyond onboarding.
- Figma writes (canvas changes).
- Asset code generation.
