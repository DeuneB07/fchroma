import '../state/theme_lab_state.dart';
import 'generated/app_localizations.dart';

/// Display names for the lab's enums.
///
/// These live outside `ThemeLabState` on purpose: the state should not know
/// about translations, and the same enum is labelled from more than one place
/// (the control panel and the pages), so the mapping belongs in exactly one
/// file rather than being copy-pasted into each `switch`.
extension FontChoiceL10n on FontChoice {
  String label(AppLocalizations l) => displayName ?? l.fontDefault;
}

extension TextThemePresetL10n on TextThemePreset {
  String label(AppLocalizations l) => switch (this) {
    TextThemePreset.framework => l.presetFramework,
    TextThemePreset.compact => l.presetCompact,
    TextThemePreset.editorial => l.presetEditorial,
    TextThemePreset.mono => l.presetMono,
  };
}

extension ColorSchemeSourceL10n on ColorSchemeSource {
  String label(AppLocalizations l) => switch (this) {
    ColorSchemeSource.seed => l.sourceSeed,
    ColorSchemeSource.swatch => l.sourceSwatch,
    ColorSchemeSource.baseline => l.sourceBaseline,
    ColorSchemeSource.manual => l.sourceManual,
  };
}

extension PageTransitionKindL10n on PageTransitionKind {
  String label(AppLocalizations l) => switch (this) {
    PageTransitionKind.defaults => l.transitionPerPlatform,
    PageTransitionKind.zoom => l.transitionZoom,
    PageTransitionKind.fadeForwards => l.transitionFadeForwards,
    PageTransitionKind.cupertino => l.transitionCupertino,
    PageTransitionKind.predictiveBack => l.transitionPredictiveBack,
  };
}

// `DynamicSchemeVariant`, `SplashKind` and `TypographyKind` are deliberately
// NOT listed here. Their values are API identifiers — `tonalSpot`,
// `inkSparkle`, `material2021` — and the whole point of showing them is that
// you can find them in the Flutter source. Translating those would make the
// app less useful, not more.
