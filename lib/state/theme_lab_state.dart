import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  LAB STATE
// ───────────────────────────────────────────────────────────────────────────
//  This file does NOT build the theme: it only records "what the user picked".
//  Translating these options into a real [ThemeData] happens in
//  `lib/theme/app_theme_builder.dart`.
//
//  Separating STATE (what I want) from CONSTRUCTION (how the ThemeData is
//  assembled) is the usual pattern in real apps: the state normally comes from
//  saved preferences, a backend or a state manager (Provider / Riverpod /
//  Bloc), and the builder is a pure function.
// ═══════════════════════════════════════════════════════════════════════════

/// Where the app's [ColorScheme] comes from.
///
/// A [ColorScheme] is the app's *semantic* palette: it does not say "blue", it
/// says "primary", "surface", "error"... Material widgets read those roles,
/// never loose colors. Swapping the scheme recolors the entire app.
enum ColorSchemeSource {
  /// `ColorScheme.fromSeed(seedColor: ...)`.
  ///
  /// The **recommended approach in Material 3**: you give ONE seed color and
  /// Material's HCT algorithm generates the ~45 roles with correct contrast.
  seed,

  /// `ThemeData(primarySwatch: Colors.indigo)`.
  ///
  /// The **classic Material 2 approach**. A [MaterialColor] is a 10-step scale
  /// (50..900) from which Flutter derives primaryColor, primaryColorDark,
  /// primaryColorLight and an approximate ColorScheme.
  swatch,

  /// `ColorScheme.light()` / `ColorScheme.dark()`.
  ///
  /// Material 3's *baseline* palette: the default purples you see when you
  /// configure nothing.
  baseline,

  /// `ColorScheme(...)` written by hand, role by role.
  ///
  /// Absolute control. This is what you end up doing when a brand manual is
  /// locked down and the seed algorithm does not produce your exact colors.
  manual,
}

/// [TextTheme] presets this app knows how to generate.
enum TextThemePreset {
  /// Whatever Flutter provides by default (per [Typography]). Untouched.
  framework,

  /// Everything slightly smaller and tighter: dense UIs, dashboards, tables.
  compact,

  /// Large headlines and roomier line height: reading material.
  editorial,

  /// A monospaced font across every style: developer tooling.
  mono,
}

/// Implementation of the ink animation on press (the ripple).
enum SplashKind {
  /// Let Flutter decide: [InkSparkle] on M3, [InkRipple] on M2.
  auto,

  /// M3: a glow that fades out from the pressed point.
  inkSparkle,

  /// M2: a circular wave expanding from the pressed point.
  inkRipple,

  /// Older M2: a wave expanding from the center.
  inkSplash,

  /// No press animation at all (useful on desktop or very sober UIs).
  noSplash,
}

/// Route navigation animation ([PageTransitionsTheme]).
enum PageTransitionKind {
  /// Each platform with its native animation (what Flutter does untouched).
  defaults,

  /// Zoom + fade. The Android standard since M3.
  zoom,

  /// Smooth horizontal slide with a fade. New in Material 3 expressive.
  fadeForwards,

  /// iOS-style lateral slide, with the "swipe back" gesture.
  cupertino,

  /// Hooks into Android 14+'s predictive back gesture.
  predictiveBack,
}

/// Base type scale ([Typography]).
enum TypographyKind {
  /// Material 3's 15 styles (displayLarge … labelSmall) at their M3 sizes.
  material2021,

  /// Material 2's sizes (mapped onto the new names).
  material2018,

  /// The original Material 1 (2014) sizes.
  material2014,
}

/// Fonts available without adding assets to the project.
///
/// These are *generic aliases* resolved by the operating system, so they work
/// on Android, iOS, web and desktop with nothing to download.
enum FontChoice {
  /// `null` → the platform's default font (Roboto on Android...).
  platformDefault(null),
  roboto('Roboto'),
  serif('serif'),
  monospace('monospace'),
  cursive('cursive');

  const FontChoice(this.family);

  /// The value handed to `ThemeData.fontFamily`.
  final String? family;

  /// Font names are proper nouns and stay untranslated; only the "platform
  /// default" entry is a phrase, and the UI supplies that from the
  /// translations. Returning null here keeps this file free of UI strings.
  String? get displayName => switch (this) {
    FontChoice.platformDefault => null,
    FontChoice.roboto => 'Roboto',
    FontChoice.serif => 'Serif',
    FontChoice.monospace => 'Monospace',
    FontChoice.cursive => 'Cursive',
  };
}

/// Observable state holding EVERY option the lab lets you touch.
///
/// It uses [ChangeNotifier] on purpose: it ships with Flutter, needs no
/// external packages, and makes the cycle obvious — *data changes →
/// notifyListeners → the ThemeData is rebuilt → the app repaints*.
class ThemeLabState extends ChangeNotifier {
  // ─────────────────────────────────────────────────────────────────────────
  // 1. MATERIAL VERSION AND LIGHT/DARK MODE
  // ─────────────────────────────────────────────────────────────────────────

  /// `ThemeData.useMaterial3`
  ///
  /// The biggest switch of them all. It changes shapes (corners), heights,
  /// elevations, typography, component colors and the ripple.
  /// Since Flutter 3.16 the default value is `true`.
  bool useMaterial3 = true;

  /// `MaterialApp.themeMode`
  ///
  /// Decides whether `MaterialApp.theme` (light), `MaterialApp.darkTheme`
  /// (dark) or the operating system's setting ([ThemeMode.system]) applies.
  ThemeMode themeMode = ThemeMode.light;

  /// `MaterialApp.themeAnimationDuration`
  ///
  /// Flutter interpolates between the old theme and the new one. Set it to 0
  /// to see changes snap, or raise it to appreciate the transition.
  Duration themeAnimationDuration = const Duration(milliseconds: 400);

  /// `MaterialApp.locale`
  ///
  /// `null` means "follow the device", which is what a real app should do by
  /// default. A non-null value forces one language, which is what the picker
  /// in the control panel does.
  ///
  /// Language belongs here, next to the theme, because both are presentation
  /// preferences that the whole widget tree reads through an inherited widget.
  Locale? locale;

  // ─────────────────────────────────────────────────────────────────────────
  // 2. COLOR
  // ─────────────────────────────────────────────────────────────────────────

  /// Strategy used to build the [ColorScheme].
  ColorSchemeSource colorSource = ColorSchemeSource.seed;

  /// `ColorScheme.fromSeed(seedColor: ...)`
  ///
  /// The only color you need in Material 3. All 45 roles come from it.
  Color seedColor = const Color(0xFF6750A4);

  /// `ColorScheme.fromSeed(dynamicSchemeVariant: ...)`
  ///
  /// The algorithm's "character": how far the palette drifts from the seed,
  /// how much saturation it keeps, whether it generates harmonies or
  /// monochrome.
  DynamicSchemeVariant schemeVariant = DynamicSchemeVariant.tonalSpot;

  /// `ColorScheme.fromSeed(contrastLevel: ...)`
  ///
  /// From -1.0 (low contrast) to 1.0 (high contrast). 0.0 is the standard.
  /// Useful for honouring the system's accessibility settings.
  double contrastLevel = 0.0;

  /// `ThemeData(primarySwatch: ...)` — only when [colorSource] is swatch.
  MaterialColor primarySwatch = Colors.indigo;

  // Colors for "manual" mode: written straight into the ColorScheme.
  Color manualPrimary = const Color(0xFF00696D);
  Color manualSecondary = const Color(0xFF4A6365);
  Color manualTertiary = const Color(0xFF4F5F7E);
  Color manualError = const Color(0xFFBA1A1A);

  // ── Legacy overrides (loose ThemeData properties, Material 2 era) ────────
  // They still exist and still beat whatever the ColorScheme says, which makes
  // them the number one cause of "I changed the theme and this screen didn't".

  /// When `true`, the loose overrides below are applied.
  bool applyLegacyOverrides = false;

  /// `ThemeData.scaffoldBackgroundColor` — background of every [Scaffold].
  Color scaffoldBackgroundColor = const Color(0xFFF3F1F7);

  /// `ThemeData.canvasColor` — background of [Drawer], [DropdownButton]...
  Color canvasColor = const Color(0xFFFFFBFE);

  /// `ThemeData.dividerColor` — [Divider] lines and table/list borders.
  Color dividerColor = const Color(0xFFCAC4D0);

  /// `ThemeData.disabledColor` — color applied to disabled widgets.
  Color disabledColor = const Color(0x61000000);

  /// `ThemeData.hintColor` — placeholder of text fields.
  Color hintColor = const Color(0x99000000);

  /// `ThemeData.shadowColor` — color of the shadows cast by elevation.
  Color shadowColor = const Color(0xFF000000);

  /// `ThemeData.applyElevationOverlayColor`
  ///
  /// Material 2 + dark theme only: lays a translucent white veil over elevated
  /// surfaces to simulate them catching more light. On M3 that role belongs to
  /// `ColorScheme.surfaceTint`.
  bool applyElevationOverlayColor = false;

  // ─────────────────────────────────────────────────────────────────────────
  // 3. TYPOGRAPHY
  // ─────────────────────────────────────────────────────────────────────────

  /// `ThemeData.typography`
  ///
  /// The *base* type scale the [TextTheme] is applied on top of.
  TypographyKind typography = TypographyKind.material2021;

  /// `ThemeData.fontFamily` — applies one family to ALL the theme's styles.
  FontChoice fontChoice = FontChoice.platformDefault;

  /// Which [TextTheme] preset is layered over the base typography.
  TextThemePreset textPreset = TextThemePreset.framework;

  /// Multiplier applied to the `fontSize` of the TextTheme's 15 styles.
  ///
  /// CAREFUL: this is NOT the same as `MediaQuery.textScaler` (the user's
  /// accessibility setting). Here we change the *design*; the textScaler is a
  /// user preference multiplied on top of it.
  double fontSizeScale = 1.0;

  /// Delta in pixels added to each style's `letterSpacing`.
  double letterSpacingDelta = 0.0;

  /// Multiplier for each style's `height` (line height).
  double lineHeightScale = 1.0;

  /// Base `FontWeight` for the headline styles.
  int titleFontWeightIndex = 5; // FontWeight.w600

  // ─────────────────────────────────────────────────────────────────────────
  // 4. DENSITY, SHAPE AND TOUCH FEEDBACK
  // ─────────────────────────────────────────────────────────────────────────

  /// `ThemeData.visualDensity`
  ///
  /// Tightens or loosens the internal spacing of components. It does not
  /// change font sizes: it changes *padding*. Ranges from -4.0 to 4.0 per axis.
  double densityHorizontal = 0.0;
  double densityVertical = 0.0;

  /// When `true`, ignores the sliders and uses
  /// [VisualDensity.adaptivePlatformDensity] (compact on desktop, standard on
  /// mobile). That is usually what cross-platform apps want.
  bool adaptiveDensity = false;

  /// `ThemeData.materialTapTargetSize`
  ///
  /// [MaterialTapTargetSize.padded] enforces a minimum 48x48 dp touch area (an
  /// accessibility requirement). [shrinkWrap] leaves the widget at its natural
  /// size: more compact, but harder to hit with a finger.
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;

  /// `ThemeData.splashFactory`
  SplashKind splash = SplashKind.auto;

  /// Global corner radius the builder injects into the *component themes*.
  ///
  /// [ThemeData] has no global "borderRadius" property: shape is defined
  /// component by component ([CardThemeData.shape], [ElevatedButtonThemeData],
  /// [DialogThemeData.shape]...). Here we simulate such a global property by
  /// applying the same radius to all of them.
  double cornerRadius = 12.0;

  /// When `false`, the builder touches no *component theme* at all and you see
  /// Material's own defaults.
  bool applyComponentThemes = true;

  /// `AppBarTheme.centerTitle` — a concrete *component theme* example.
  bool appBarCenterTitle = false;

  /// `AppBarTheme.elevation` / `scrolledUnderElevation`.
  double appBarElevation = 0.0;

  /// `ThemeData.pageTransitionsTheme`
  PageTransitionKind pageTransition = PageTransitionKind.defaults;

  // ─────────────────────────────────────────────────────────────────────────
  // 5. THEME EXTENSIONS (YOUR properties inside the theme)
  // ─────────────────────────────────────────────────────────────────────────

  /// Sample value carried by a custom [ThemeExtension].
  double brandSpacing = 16.0;

  /// The extension's second value: a brand color Material does not have.
  Color brandAccent = const Color(0xFFFF6D00);

  // ─────────────────────────────────────────────────────────────────────────
  // Mutation: a single entry point so notifyListeners() is never repeated.
  // ─────────────────────────────────────────────────────────────────────────

  /// Applies a change and notifies the listeners.
  ///
  /// Example: `state.update(() => state.useMaterial3 = false);`
  void update(VoidCallback mutation) {
    mutation();
    notifyListeners();
  }

  /// Returns to the lab's factory values.
  void reset() {
    useMaterial3 = true;
    themeMode = ThemeMode.light;
    locale = null;
    themeAnimationDuration = const Duration(milliseconds: 400);
    colorSource = ColorSchemeSource.seed;
    seedColor = const Color(0xFF6750A4);
    schemeVariant = DynamicSchemeVariant.tonalSpot;
    contrastLevel = 0.0;
    primarySwatch = Colors.indigo;
    applyLegacyOverrides = false;
    applyElevationOverlayColor = false;
    typography = TypographyKind.material2021;
    fontChoice = FontChoice.platformDefault;
    textPreset = TextThemePreset.framework;
    fontSizeScale = 1.0;
    letterSpacingDelta = 0.0;
    lineHeightScale = 1.0;
    titleFontWeightIndex = 5;
    densityHorizontal = 0.0;
    densityVertical = 0.0;
    adaptiveDensity = false;
    tapTargetSize = MaterialTapTargetSize.padded;
    splash = SplashKind.auto;
    cornerRadius = 12.0;
    applyComponentThemes = true;
    appBarCenterTitle = false;
    appBarElevation = 0.0;
    pageTransition = PageTransitionKind.defaults;
    brandSpacing = 16.0;
    brandAccent = const Color(0xFFFF6D00);
    notifyListeners();
  }

  /// Loads a "real Material 2 app" preset for an at-a-glance comparison.
  void applyMaterial2Preset() {
    useMaterial3 = false;
    colorSource = ColorSchemeSource.swatch;
    primarySwatch = Colors.indigo;
    typography = TypographyKind.material2018;
    cornerRadius = 4.0;
    appBarElevation = 4.0;
    appBarCenterTitle = false;
    splash = SplashKind.inkRipple;
    notifyListeners();
  }

  /// Loads a "modern Material 3 app" preset.
  void applyMaterial3Preset() {
    useMaterial3 = true;
    colorSource = ColorSchemeSource.seed;
    seedColor = const Color(0xFF6750A4);
    schemeVariant = DynamicSchemeVariant.tonalSpot;
    typography = TypographyKind.material2021;
    cornerRadius = 16.0;
    appBarElevation = 0.0;
    appBarCenterTitle = true;
    splash = SplashKind.auto;
    notifyListeners();
  }
}

/// Exposes the [ThemeLabState] to the whole widget tree.
///
/// [InheritedNotifier] is Flutter's native mechanism for this: when the
/// [ChangeNotifier] notifies, it rebuilds every widget that called
/// `ThemeLabScope.of(context)`. Zero external dependencies.
class ThemeLabScope extends InheritedNotifier<ThemeLabState> {
  const ThemeLabScope({
    super.key,
    required ThemeLabState state,
    required super.child,
  }) : super(notifier: state);

  static ThemeLabState of(BuildContext context) {
    final ThemeLabScope? scope = context
        .dependOnInheritedWidgetOfExactType<ThemeLabScope>();
    assert(scope != null, 'No ThemeLabScope above this widget.');
    return scope!.notifier!;
  }
}
