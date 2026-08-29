import 'package:flutter/material.dart';

import '../state/theme_lab_state.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  TEXT THEME — the app's type scale
// ───────────────────────────────────────────────────────────────────────────
//  A [TextTheme] is an object holding 15 named [TextStyle]s. Material widgets
//  do not pick sizes by hand: they read the role assigned to them. An [AppBar]
//  uses `titleLarge`, a [ListTile] uses `bodyLarge`/`bodyMedium`, an
//  [ElevatedButton] uses `labelLarge`... That is why changing the TextTheme
//  rewrites the typography of the WHOLE app without touching a single screen.
//
//  THE 15 ROLES (Material 3 names):
//    display  L/M/S  → huge single words and numerals. Covers, splash screens.
//    headline L/M/S  → section headlines. High hierarchy, little text.
//    title    L/M/S  → AppBar, Dialog, Card and ListTile titles.
//    body     L/M/S  → paragraphs and running text. 90 % of real text.
//    label    L/M/S  → text INSIDE components: buttons, chips, tabs.
//
//  OLD NAMES (Material 2) → NEW ONES (Material 3):
//    headline1 → displayLarge     headline5 → headlineSmall
//    headline2 → displayMedium    headline6 → titleLarge
//    headline3 → displaySmall     subtitle1 → titleMedium
//    headline4 → headlineMedium   subtitle2 → titleSmall
//    bodyText1 → bodyLarge        button    → labelLarge
//    bodyText2 → bodyMedium       caption   → bodySmall
//    overline  → labelSmall
//  The old names NO LONGER EXIST in current Flutter versions: if you are
//  migrating old code, this table is what you need.
// ═══════════════════════════════════════════════════════════════════════════

/// Weights available for headlines, indexed by
/// [ThemeLabState.titleFontWeightIndex].
const List<FontWeight> kFontWeights = <FontWeight>[
  FontWeight.w100,
  FontWeight.w200,
  FontWeight.w300,
  FontWeight.w400, // normal
  FontWeight.w500,
  FontWeight.w600,
  FontWeight.w700, // bold
  FontWeight.w800,
  FontWeight.w900,
];

/// The 15 roles, as an enum.
///
/// The enum member names are deliberately identical to the `TextTheme`
/// property names, so `id.name` prints the real API identifier and there is no
/// second list of strings to keep in step.
enum TextRoleId {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// Description of each role, so the lab UI can render it.
class TextRoleInfo {
  const TextRoleInfo(this.id, this.style);

  final TextRoleId id;

  /// The property name: `displayLarge`, `bodyMedium`...
  String get name => id.name;

  /// How to pull it out of a given [TextTheme].
  ///
  /// The note describing who uses the role is NOT here: it is prose, so it
  /// lives with the translations in `lib/l10n/strings/text_theme_strings.dart`.
  final TextStyle? Function(TextTheme theme) style;
}

/// Full catalogue of the 15 roles, in the order Material presents them.
const List<TextRoleInfo> kTextRoles = <TextRoleInfo>[
  TextRoleInfo(TextRoleId.displayLarge, _displayLarge),
  TextRoleInfo(TextRoleId.displayMedium, _displayMedium),
  TextRoleInfo(TextRoleId.displaySmall, _displaySmall),
  TextRoleInfo(TextRoleId.headlineLarge, _headlineLarge),
  TextRoleInfo(TextRoleId.headlineMedium, _headlineMedium),
  TextRoleInfo(TextRoleId.headlineSmall, _headlineSmall),
  TextRoleInfo(TextRoleId.titleLarge, _titleLarge),
  TextRoleInfo(TextRoleId.titleMedium, _titleMedium),
  TextRoleInfo(TextRoleId.titleSmall, _titleSmall),
  TextRoleInfo(TextRoleId.bodyLarge, _bodyLarge),
  TextRoleInfo(TextRoleId.bodyMedium, _bodyMedium),
  TextRoleInfo(TextRoleId.bodySmall, _bodySmall),
  TextRoleInfo(TextRoleId.labelLarge, _labelLarge),
  TextRoleInfo(TextRoleId.labelMedium, _labelMedium),
  TextRoleInfo(TextRoleId.labelSmall, _labelSmall),
];

// Top-level functions so the list above can be declared `const`.
TextStyle? _displayLarge(TextTheme t) => t.displayLarge;
TextStyle? _displayMedium(TextTheme t) => t.displayMedium;
TextStyle? _displaySmall(TextTheme t) => t.displaySmall;
TextStyle? _headlineLarge(TextTheme t) => t.headlineLarge;
TextStyle? _headlineMedium(TextTheme t) => t.headlineMedium;
TextStyle? _headlineSmall(TextTheme t) => t.headlineSmall;
TextStyle? _titleLarge(TextTheme t) => t.titleLarge;
TextStyle? _titleMedium(TextTheme t) => t.titleMedium;
TextStyle? _titleSmall(TextTheme t) => t.titleSmall;
TextStyle? _bodyLarge(TextTheme t) => t.bodyLarge;
TextStyle? _bodyMedium(TextTheme t) => t.bodyMedium;
TextStyle? _bodySmall(TextTheme t) => t.bodySmall;
TextStyle? _labelLarge(TextTheme t) => t.labelLarge;
TextStyle? _labelMedium(TextTheme t) => t.labelMedium;
TextStyle? _labelSmall(TextTheme t) => t.labelSmall;

/// Builds the final [TextTheme] from the base scale and the chosen options.
///
/// [base] must be a COMPLETE scale: geometry (sizes) merged with color. See
/// the STEP 2 comment in `app_theme_builder.dart` for why that matters.
/// Never start from scratch either: building an empty `TextTheme()` loses the
/// default colors, heights and `fontFeatures`.
TextTheme buildTextTheme(TextTheme base, ThemeLabState s) {
  // `TextTheme.apply(fontSizeFactor:)` asserts that every style it touches has
  // a non-null `fontSize`, and a failed assert inside a theme build takes the
  // whole app down. Checking it here turns an inscrutable framework assertion
  // into a message that names the actual mistake.
  assert(
    base.bodyMedium?.fontSize != null && base.displayLarge?.fontSize != null,
    'buildTextTheme() was handed a TextTheme with no font sizes. This is what '
    'you get from `typography.black` / `typography.white` on their own: they '
    'are colour-only themes. Merge a geometry theme into them first, e.g. '
    '`typography.englishLike.merge(typography.black)`.',
  );

  // Step 1 — the preset changes the scale's "character".
  TextTheme theme = switch (s.textPreset) {
    // Untouched: exactly what Flutter provides.
    TextThemePreset.framework => base,

    // Dense UI: everything 12 % smaller with tighter line height.
    // `apply` is the shortcut for transforming all 15 styles at once.
    TextThemePreset.compact =>
      base
          .apply(fontSizeFactor: 0.88)
          .copyWith(
            bodyLarge: base.bodyLarge?.copyWith(fontSize: 14, height: 1.25),
            bodyMedium: base.bodyMedium?.copyWith(fontSize: 12.5, height: 1.25),
          ),

    // Long-form reading: serif headlines and generous body line height.
    TextThemePreset.editorial => base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
      ),
      displayMedium: base.displayMedium?.copyWith(fontFamily: 'serif'),
      displaySmall: base.displaySmall?.copyWith(fontFamily: 'serif'),
      headlineLarge: base.headlineLarge?.copyWith(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(fontFamily: 'serif'),
      headlineSmall: base.headlineSmall?.copyWith(fontFamily: 'serif'),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 17, height: 1.6),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 15.5, height: 1.6),
    ),

    // Developer tooling: monospaced everywhere.
    TextThemePreset.mono => base.apply(fontFamily: 'monospace'),
  };

  // Step 2 — fine-tuning applied equally to all 15 styles.
  //
  // `apply(fontSizeFactor:)` multiplies every size in one go, which beats
  // repeating `copyWith` fifteen times. Note the precondition asserted above:
  // it throws if any style is missing its `fontSize`.
  if (s.fontSizeScale != 1.0) {
    theme = theme.apply(fontSizeFactor: s.fontSizeScale);
  }

  // Neither `letterSpacing` nor `height` has a shortcut in `apply`, so we walk
  // the styles by hand. This helper keeps the code readable.
  TextStyle? tune(TextStyle? style, {FontWeight? weight}) {
    if (style == null) {
      return null;
    }
    return style.copyWith(
      fontWeight: weight ?? style.fontWeight,
      letterSpacing: (style.letterSpacing ?? 0) + s.letterSpacingDelta,
      height: style.height == null ? null : style.height! * s.lineHeightScale,
    );
  }

  final FontWeight titleWeight = kFontWeights[s.titleFontWeightIndex];

  return theme.copyWith(
    displayLarge: tune(theme.displayLarge, weight: titleWeight),
    displayMedium: tune(theme.displayMedium, weight: titleWeight),
    displaySmall: tune(theme.displaySmall, weight: titleWeight),
    headlineLarge: tune(theme.headlineLarge, weight: titleWeight),
    headlineMedium: tune(theme.headlineMedium, weight: titleWeight),
    headlineSmall: tune(theme.headlineSmall, weight: titleWeight),
    titleLarge: tune(theme.titleLarge, weight: titleWeight),
    titleMedium: tune(theme.titleMedium),
    titleSmall: tune(theme.titleSmall),
    bodyLarge: tune(theme.bodyLarge),
    bodyMedium: tune(theme.bodyMedium),
    bodySmall: tune(theme.bodySmall),
    labelLarge: tune(theme.labelLarge),
    labelMedium: tune(theme.labelMedium),
    labelSmall: tune(theme.labelSmall),
  );
}
