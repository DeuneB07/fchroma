import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'strings/color_scheme_strings.dart';
import 'strings/component_themes_strings.dart';
import 'strings/density_shape_strings.dart';
import 'strings/extensions_strings.dart';
import 'strings/gallery_strings.dart';
import 'strings/generated_code_strings.dart';
import 'strings/legacy_colors_strings.dart';
import 'strings/material_version_strings.dart';
import 'strings/overview_strings.dart';
import 'strings/text_theme_strings.dart';
import 'strings/transitions_strings.dart';
import 'strings/typography_strings.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  LAB STRINGS — the long-form copy, in Dart rather than ARB
// ───────────────────────────────────────────────────────────────────────────
//  The short chrome labels live in `app_en.arb` / `app_es.arb` and go through
//  `gen-l10n` like any Flutter app. This second mechanism exists for the other
//  kind of text: the article-length explanations inside the eleven content
//  pages. Two reasons it earns its place there and not in ARB:
//
//   1. ARB is JSON, so every message is one long line and every double quote
//      has to be escaped. This copy is full of quoted phrases; in JSON it
//      becomes unreadable, and unreadable text is text that rots.
//
//   2. A missing translation here is a COMPILE ERROR. Add a getter to the
//      abstract class and the analyzer refuses to build until every locale
//      implements it. ARB reports the same thing into a file you have to
//      remember to open.
//
//  What this deliberately gives up is ICU: plurals, genders, number and date
//  formatting. None of the copy depends on a variable quantity — the numbers
//  in it ("45 roles", "15 styles") are fixed — so there is nothing to lose.
//  If that ever changes, that particular message belongs back in ARB.
//
//  Adding a language means writing one subclass per page group and adding it
//  to the switch in [LabStringsDelegate.load].
// ═══════════════════════════════════════════════════════════════════════════

/// Root of the page copy. Each getter is one page's worth of strings, so the
/// call sites read as `LabStrings.of(context).overview.title` and no single
/// class ends up with several hundred members.
@immutable
abstract class LabStrings {
  const LabStrings();

  OverviewStrings get overview;
  MaterialVersionStrings get materialVersion;
  ColorSchemeStrings get colorScheme;
  LegacyColorsStrings get legacyColors;
  TextThemeStrings get textTheme;
  TypographyStrings get typography;
  ComponentThemesStrings get componentThemes;
  DensityShapeStrings get densityShape;
  ExtensionsStrings get extensions;
  TransitionsStrings get transitions;
  GeneratedCodeStrings get generatedCode;

  /// Shared by the component-themes page and the M2/M3 comparison.
  GalleryStrings get gallery;

  /// Reads the strings for the active locale.
  ///
  /// `Localizations.of` returns null when the delegate is not registered,
  /// which in practice means a test built a bare `MaterialApp`. The assert
  /// says so directly instead of letting a null dereference surface somewhere
  /// unrelated.
  static LabStrings of(BuildContext context) {
    final LabStrings? strings = Localizations.of<LabStrings>(
      context,
      LabStrings,
    );
    assert(
      strings != null,
      'No LabStrings found. Add LabStringsDelegate to the app\'s '
      'localizationsDelegates.',
    );
    return strings!;
  }
}

class LabStringsEn extends LabStrings {
  const LabStringsEn();

  @override
  OverviewStrings get overview => const OverviewStringsEn();

  @override
  MaterialVersionStrings get materialVersion =>
      const MaterialVersionStringsEn();

  @override
  ColorSchemeStrings get colorScheme => const ColorSchemeStringsEn();

  @override
  LegacyColorsStrings get legacyColors => const LegacyColorsStringsEn();

  @override
  TextThemeStrings get textTheme => const TextThemeStringsEn();

  @override
  TypographyStrings get typography => const TypographyStringsEn();

  @override
  ComponentThemesStrings get componentThemes =>
      const ComponentThemesStringsEn();

  @override
  DensityShapeStrings get densityShape => const DensityShapeStringsEn();

  @override
  ExtensionsStrings get extensions => const ExtensionsStringsEn();

  @override
  TransitionsStrings get transitions => const TransitionsStringsEn();

  @override
  GeneratedCodeStrings get generatedCode => const GeneratedCodeStringsEn();

  @override
  GalleryStrings get gallery => const GalleryStringsEn();
}

class LabStringsEs extends LabStrings {
  const LabStringsEs();

  @override
  OverviewStrings get overview => const OverviewStringsEs();

  @override
  MaterialVersionStrings get materialVersion =>
      const MaterialVersionStringsEs();

  @override
  ColorSchemeStrings get colorScheme => const ColorSchemeStringsEs();

  @override
  LegacyColorsStrings get legacyColors => const LegacyColorsStringsEs();

  @override
  TextThemeStrings get textTheme => const TextThemeStringsEs();

  @override
  TypographyStrings get typography => const TypographyStringsEs();

  @override
  ComponentThemesStrings get componentThemes =>
      const ComponentThemesStringsEs();

  @override
  DensityShapeStrings get densityShape => const DensityShapeStringsEs();

  @override
  ExtensionsStrings get extensions => const ExtensionsStringsEs();

  @override
  TransitionsStrings get transitions => const TransitionsStringsEs();

  @override
  GeneratedCodeStrings get generatedCode => const GeneratedCodeStringsEs();

  @override
  GalleryStrings get gallery => const GalleryStringsEs();
}

/// Plugs [LabStrings] into Flutter's own localization machinery.
///
/// Going through a delegate rather than, say, reading the locale from the app
/// state means this behaves like every other localization: it rebuilds
/// dependents when the locale changes, it works under `Localizations.override`
/// for a subtree, and widget tests can pin a locale the usual way.
class LabStringsDelegate extends LocalizationsDelegate<LabStrings> {
  const LabStringsDelegate();

  /// Must stay in step with `supportedLocales` in the generated
  /// AppLocalizations, or one mechanism will translate and the other will not.
  static const Set<String> supportedLanguageCodes = <String>{'en', 'es'};

  @override
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<LabStrings> load(Locale locale) {
    // The strings are compile-time constants, so there is nothing to await.
    // `SynchronousFuture` resolves in the same frame and avoids a flash of
    // unlocalized UI on startup.
    return SynchronousFuture<LabStrings>(switch (locale.languageCode) {
      'es' => const LabStringsEs(),
      _ => const LabStringsEn(),
    });
  }

  @override
  bool shouldReload(LabStringsDelegate old) => false;
}
