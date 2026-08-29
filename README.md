# FChroma

An interactive lab for Flutter's `ThemeData` — a sample app that walks through, property by
property, how the visual style of a Flutter application is actually defined.

Every control in the side panel rebuilds the theme live, and every source file is commented to
explain **what** each property is and **why** you would reach for it. When you like what you see,
the last section hands you the equivalent Dart to paste into your own project.

Built with **zero external dependencies** — nothing but the Flutter SDK.

> **Note on language:** the app is localized with `flutter_localizations` and ships **English and
> Spanish**, switchable at runtime from the control panel. Source code, comments and documentation
> are in English. See [Localization](#localization) for the details.

---

## Why this exists

`ThemeData` has roughly 150 properties, `ColorScheme` has about 45 color roles, `TextTheme` has 15
named styles, and there are 40+ component sub-themes. The official docs describe each one in
isolation, but they rarely answer the questions you actually have:

- Which of these does a given widget really read?
- Why did I change the theme and this one screen stayed the same?
- What does `useMaterial3: false` actually change?
- Where do I put a `success` color, since Material only ships `error`?

FChroma answers those by letting you toggle each property and watch the whole app react, with the
reasoning written down next to the code that does it.

## Quick start

```bash
flutter run
```

If you use [FVM](https://fvm.app/) (this repo pins a version in `.fvmrc`):

```bash
fvm flutter run
```

Android, iOS and web targets are configured. The layout is responsive, so it is worth trying on a
wide window: above 1300 px the control panel docks permanently to the right.

## What's inside

Eleven sections, each built from schematic property cards — property name, Dart type, default
value, current value, a live demo, and a practical caveat.

| Section | What it covers |
|---|---|
| **Fundamentals** | What `ThemeData` is, the four-step priority order Flutter uses to resolve a color, nested `Theme`, common mistakes |
| **Material 2 vs 3** | `useMaterial3`, with the same widget showcase rendered under both themes side by side, a difference table, and a migration guide |
| **ColorScheme** | All the color roles with swatches and real usage notes; `fromSeed`, `DynamicSchemeVariant`, `contrastLevel`, and the color + `on` pairing rule |
| **Legacy colors** | `scaffoldBackgroundColor`, `canvasColor`, `dividerColor`, `hintColor`, `primarySwatch`… and why they still beat the `ColorScheme` |
| **TextTheme** | The 15 styles rendered live with their metrics, `apply()` vs `copyWith()`, and the M2 → M3 name migration table |
| **Typography** | `Typography.material2021/2018/2014`, `black` vs `white` sets, `fontFamily`, a full `TextStyle` anatomy, `DefaultTextStyle`, icon themes |
| **Component themes** | The pattern behind the 40+ sub-themes, plus an interactive `WidgetStateProperty` demo that prints the states a widget currently has |
| **Shape & density** | `VisualDensity`, `materialTapTargetSize`, global shape, M2 vs M3 elevation, `splashFactory`, `platform`, `adaptations` |
| **ThemeExtension** | How to add your own properties to the theme: `copyWith`, `lerp`, registration, lookup, and per-branch overrides |
| **Transitions** | `PageTransitionsTheme` with real navigation, `themeAnimationDuration`, and the `lerp` methods that make theme animation possible |
| **Export** | The `ThemeData` you just built, generated as copy-pasteable Dart |

## Project structure

```
lib/
  main.dart                        MaterialApp: theme, darkTheme, themeMode, animation
  state/
    theme_lab_state.dart           ChangeNotifier holding every option (what the user wants)
  theme/
    app_theme_builder.dart         The core: state + brightness -> ThemeData, heavily commented
    text_theme_presets.dart        The 15 roles and their transformations
    brand_theme_extension.dart     A sample ThemeExtension (success, warning, spacing, gradient)
    theme_code_generator.dart      Serializes the current theme back to Dart source
  ui/
    home_shell.dart                Responsive navigation (rail / drawer)
    control_panel.dart             The controls that rebuild the theme
    pages/                         One page per topic
    widgets/
      lab_widgets.dart             PropertyCard, CodeBlock, ColorRoleSwatch…
      widget_gallery.dart          A showcase with no hardcoded colors, reusable under any Theme
```

## How it's meant to be used

1. **Read the code alongside the running app.** `app_theme_builder.dart` is the central file: it
   walks the `ThemeData` constructor section by section with a comment per property.
2. **Toggle things and watch.** The control panel deliberately lives *inside* the themed tree, so
   it restyles itself with every change.
3. **Export.** Once the result convinces you, the last section gives you the equivalent Dart.

## Implementation notes

A few decisions that may be worth borrowing:

- **One builder function, two themes.** `AppThemeBuilder.build(state, brightness)` is called for
  `theme`, `darkTheme` and both high-contrast variants. Light and dark can never drift apart, and
  the interpolation between them stays clean.
- **State separated from construction.** `ThemeLabState` records *what* was chosen;
  `AppThemeBuilder` is a pure function turning that into a `ThemeData`. In a real app the state
  would come from stored preferences or a state manager, and the builder would not change.
- **No packages.** State propagation uses `InheritedNotifier` + `ChangeNotifier`, which ship with
  Flutter.
- **Overrides instead of temporary mutation.** The comparison page needs the same theme built as
  both M2 and M3. It passes `materialVersionOverride` rather than mutating the shared state
  mid-build, which only works by accident and breaks the moment anything becomes async.
- **The `ColorScheme` is cached.** `ColorScheme.fromSeed` converts the seed into HCT space,
  generates five tonal palettes and resolves every role — and it runs four times per change. The
  cache is keyed on the color-affecting inputs only, so dragging the typography or corner-radius
  sliders recomputes no palette at all.
- **A real high-contrast theme.** `highContrastTheme` is not a copy of the light theme; it is the
  same theme rebuilt at `contrastLevel: 1.0`.
- **Nothing in the UI hardcodes a color or a size.** That is what lets `WidgetGallery` be dropped
  under any `Theme` and used as a test specimen.

## The app icon

A chromatic wheel with the Flutter mark in front. It is not a hand-drawn asset: it is **painted by
Flutter's own canvas** in `tool/generate_app_icon.dart`, so the icon is versioned as code and
changing it means editing numbers rather than opening a design tool.

```bash
flutter test tool/generate_app_icon.dart   # repaint the 1024x1024 sources
dart run flutter_launcher_icons            # resize them into every platform
```

It is written as a test for a practical reason: encoding a picture to PNG needs a live Flutter
engine, and `flutter test` is the cheapest way to get one headless. A plain `dart run` has no
engine and fails.

Four sources come out of it, because the platforms disagree about what an icon is:

| File | Used by | Why it differs |
|---|---|---|
| `app_icon.png` | web, default | Rounded corners, transparent outside them |
| `app_icon_ios.png` | iOS | Square, full bleed, opaque — iOS masks with a superellipse that reaches further into the corners than a rounded rectangle, so rounded artwork shows white slivers |
| `app_icon_background.png` | Android adaptive | The wheel alone, square — the launcher applies its own mask |
| `app_icon_foreground.png` | Android adaptive + monochrome | The logo alone, on transparency |

The generated per-platform assets are committed, so a fresh clone builds without running either
step.

> The Flutter logo is a Google trademark. It is used here because this is a Flutter teaching
> project; if you fork this into a product, replace the mark.

## Localization

English and Spanish, switchable at runtime from the control panel. There are **two** string
mechanisms, and the split is deliberate:

```
l10n.yaml                       gen-l10n config
lib/l10n/app_en.arb             short chrome labels — English, the template
lib/l10n/app_es.arb             short chrome labels — Spanish
lib/l10n/generated/             produced by `flutter gen-l10n`, committed on purpose
lib/l10n/enum_labels.dart       display names for the lab's own enums
lib/l10n/lab_strings.dart       delegate + root class for the page copy
lib/l10n/strings/*_strings.dart one file per page, both languages side by side
```

Roughly 400 messages, all of them translated.

**ARB for the chrome.** Navigation labels, buttons, tooltips — short strings, and the canonical
Flutter approach. `flutter_localizations` also comes along for free, which is what translates
Material's own strings (dialog buttons, the date picker, semantic labels).

**A hand-written class for the page copy.** The eleven content pages are article-length prose, and
ARB is a poor fit for that:

- ARB is JSON. Every message is one long line and every double quote needs escaping — and this copy
  is full of quoted phrases. In Dart it stays as adjacent string literals, exactly as it reads.
- A missing translation becomes a **compile error**: add a getter to the abstract class and the
  analyzer refuses to build until every locale implements it. ARB writes the same information to a
  report file you have to remember to open.

What that gives up is ICU — plurals, genders, number and date formatting. No copy on these pages
depends on a variable quantity, so there is nothing to lose. Anything that ever does belongs back
in ARB.

Adding a language: drop an `app_<code>.arb` beside the others, run `flutter gen-l10n`, then add a
subclass per file in `lib/l10n/strings/` and a branch in `LabStringsDelegate.load`.

Two more rules the codebase sticks to:

- **The generated files are committed.** A fresh clone analyzes without a build step.
- **API identifiers are never translated.** `tonalSpot`, `inkSparkle`, `material2021`, the property
  name on every card and the comments inside the displayed Dart snippets all stay verbatim in every
  language — being able to search for them in the Flutter source is the point. Only prose is
  translated, and code comments are English throughout, UI language notwithstanding.

The one thing that is not translated, besides API identifiers, is the Dart snippets the pages
display as teaching material. Their comments are English in both languages, which matches the rule
above: code comments are English throughout.

## SDK version

Written against **Flutter 3.47 / Dart 3.13**. Theme APIs move faster than most of the framework,
and several that still show up in tutorials no longer exist. The app documents them explicitly
rather than quietly avoiding them:

- The Material 2 `TextTheme` names (`headline6`, `bodyText2`, `subtitle1`…) were removed.
- `Radio.groupValue` / `onChanged` are deprecated in favour of a `RadioGroup` ancestor.
- `FontWeight.index` is deprecated in favour of `FontWeight.value`.
- `ColorScheme.background`, `onBackground` and `surfaceVariant` are deprecated.
- `accentColor`, `backgroundColor`, `toggleableActiveColor` and friends were removed from
  `ThemeData` entirely.
- `FadeUpwardsPageTransitionsBuilder` and `OpenUpwardsPageTransitionsBuilder` are gone;
  `FadeForwardsPageTransitionsBuilder` and `PredictiveBackPageTransitionsBuilder` replaced them.

On an older SDK some of this will not compile. The fix is usually the reverse of the notes above.

## Contributing

Issues and pull requests are welcome — particularly corrections, since the whole point is that the
explanations are accurate. `flutter analyze` should stay clean and `dart format` should be applied
before submitting.
