// `CupertinoPageTransitionsBuilder` lives in the Cupertino library, not the
// Material one. The `show` clause imports just that symbol and avoids any name
// collision between the two libraries.
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import '../state/theme_lab_state.dart';
import 'brand_theme_extension.dart';
import 'text_theme_presets.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  APP THEME BUILDER — where the ThemeData is actually assembled
// ───────────────────────────────────────────────────────────────────────────
//  What is ThemeData?
//  It is an IMMUTABLE object holding every style default for the app. It draws
//  nothing on its own: each Material widget looks it up through
//  `Theme.of(context)`. If a widget is handed an explicit color, that color
//  wins; if it is handed nothing, it falls back to the theme. That is the
//  whole trick.
//
//  How Flutter decides a color (highest priority first):
//    1. The widget's own parameter ........... ElevatedButton(style: ...)
//    2. The matching component theme ......... ThemeData.elevatedButtonTheme
//    3. The theme's ColorScheme .............. ThemeData.colorScheme.primary
//    4. Material's built-in default .......... hardcoded in the framework
//
//  And at the tree level: a nested [Theme] widget overrides the one above it,
//  so a single section of the app can carry its own theme.
// ═══════════════════════════════════════════════════════════════════════════

abstract final class AppThemeBuilder {
  /// Entry point: lab state + brightness → [ThemeData].
  ///
  /// `MaterialApp` calls this TWICE (once for `theme`, once for `darkTheme`).
  /// That is why [brightness] is a parameter instead of coming from the state:
  /// the dark theme has to exist even while we are in light mode, so Flutter
  /// can interpolate between the two when the mode changes.
  static ThemeData build(
    ThemeLabState s,
    Brightness brightness, {

    /// Forces a contrast level different from the lab's own.
    ///
    /// Used by `MaterialApp.highContrastTheme`: when the user turns on high
    /// contrast in the system settings, Flutter switches to that theme
    /// automatically. Passing 1.0 here is the cheapest way to provide one.
    double? contrastOverride,

    /// Forces a Material version different from the lab's own.
    ///
    /// Used by the comparison page to build the same theme as M2 and M3 side
    /// by side. A parameter is the clean way to do this: the alternative —
    /// mutating the state, building, then restoring it — only works by
    /// accident and breaks as soon as anything on the path becomes async.
    bool? materialVersionOverride,
  }) {
    final bool useMaterial3 = materialVersionOverride ?? s.useMaterial3;

    // ── STEP 1 ── The ColorScheme: the semantic palette ───────────────────
    final ColorScheme scheme = _buildColorScheme(
      s,
      brightness,
      contrastOverride,
    );

    // ── STEP 2 ── The base type scale ─────────────────────────────────────
    //
    // [Typography] is really TWO things bolted together, and mixing them up is
    // the source of a very confusing crash.
    //
    //  · `black` / `white` are the COLOR themes. One carries dark text for
    //    light backgrounds, the other light text for dark backgrounds. Picking
    //    the wrong one is the classic "I can't read anything in dark mode".
    //    They define color, fontFamily and decoration — and NOTHING ELSE.
    //    Every `fontSize` in them is null.
    //
    //  · `englishLike` / `dense` / `tall` are the GEOMETRY themes: the sizes,
    //    weights, letter spacing and line heights, one variant per script
    //    family (Latin, CJK, Indic...).
    //
    // Flutter normally keeps them apart until the very last moment:
    // `ThemeData.localize()` merges the geometry that matches the active
    // locale into the theme, which is why a stock app renders correctly even
    // though `typography.black` has no sizes in it.
    final Typography typography = switch (s.typography) {
      TypographyKind.material2021 => Typography.material2021(
        colorScheme: scheme,
      ),
      TypographyKind.material2018 => Typography.material2018(),
      TypographyKind.material2014 => Typography.material2014(),
    };

    final TextTheme colorTextTheme = brightness == Brightness.dark
        ? typography.white
        : typography.black;

    // We merge the geometry in HERE, up front, because this app transforms
    // sizes, letter spacing and line height. Starting from the color-only
    // theme would mean scaling a bunch of nulls: `TextTheme.apply` asserts on
    // a null `fontSize` and takes the whole app down with it.
    //
    // The trade-off is that we freeze the Latin geometry instead of letting
    // `localize()` swap in `dense` or `tall` for CJK and Indic locales. For a
    // single-locale demo that is the right call; a multi-script product should
    // pick the geometry from the locale rather than hardcoding `englishLike`.
    final TextTheme baseTextTheme = typography.englishLike.merge(
      colorTextTheme,
    );

    // Apply our presets and fine-tuning on top of that base.
    final TextTheme textTheme = buildTextTheme(baseTextTheme, s);

    // The M2-era counterpart: the same scale recoloured for painting on top of
    // `primary`. Needed below by the AppBar title.
    final TextTheme primaryTextTheme = textTheme.apply(
      bodyColor: scheme.onPrimary,
      displayColor: scheme.onPrimary,
    );

    // ── STEP 3 ── Visual density ──────────────────────────────────────────
    //
    // [VisualDensity] does not change fonts: it changes the internal PADDING
    // of components. Each unit is worth 4 logical pixels per side.
    final VisualDensity density = s.adaptiveDensity
        // `adaptivePlatformDensity` = compact on desktop, standard on mobile.
        // This is the right choice for cross-platform apps.
        ? VisualDensity.adaptivePlatformDensity
        : VisualDensity(
            horizontal: s.densityHorizontal,
            vertical: s.densityVertical,
          );

    // ── STEP 4 ── Press feedback ──────────────────────────────────────────
    final InteractiveInkFeatureFactory? splashFactory = switch (s.splash) {
      // `null` lets ThemeData decide: InkSparkle on M3, InkRipple on M2.
      SplashKind.auto => null,
      SplashKind.inkSparkle => InkSparkle.splashFactory,
      SplashKind.inkRipple => InkRipple.splashFactory,
      SplashKind.inkSplash => InkSplash.splashFactory,
      SplashKind.noSplash => NoSplash.splashFactory,
    };

    // ── STEP 5 ── Page transitions ────────────────────────────────────────
    //
    // [PageTransitionsTheme] maps PLATFORM → animation. Note that it is keyed
    // per platform rather than set globally, because the usual goal is each
    // system's native animation.
    final PageTransitionsTheme? pageTransitions = _buildPageTransitions(
      s.pageTransition,
    );

    // ── STEP 6 ── The global shape ────────────────────────────────────────
    final BorderRadius radius = BorderRadius.circular(s.cornerRadius);
    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      borderRadius: radius,
    );

    // ══ And now, the ThemeData itself ═════════════════════════════════════
    return ThemeData(
      // ─────────────────────────────────────────────────────────────────
      // GENERAL CONFIGURATION
      // ─────────────────────────────────────────────────────────────────

      /// Turns on the Material 3 design (corners, elevations, typography,
      /// tonal colors, the new ripple). It defaults to `true` since Flutter
      /// 3.16. Setting it to `false` returns the app to the Material 2 look.
      useMaterial3: useMaterial3,

      /// Material 2 + dark only: lightens surfaces according to their
      /// elevation by laying a translucent white veil over them. M3 ignores
      /// it, because `colorScheme.surfaceTint` plays that role there.
      applyElevationOverlayColor: useMaterial3
          ? false
          : s.applyElevationOverlayColor,

      /// Internal spacing of components. See STEP 3.
      visualDensity: density,

      /// Minimum touch target size.
      ///  · padded     → at least 48x48 dp (accessibility, advised on mobile)
      ///  · shrinkWrap → the widget takes only its own size (dense, desktop)
      materialTapTargetSize: s.tapTargetSize,

      /// The ink animation on press. See STEP 4.
      splashFactory: splashFactory,

      /// Route navigation animations. See STEP 5.
      pageTransitionsTheme: pageTransitions,

      /// YOUR own properties inside the theme. See `brand_theme_extension.dart`.
      /// It is a list because several extensions can be registered at once;
      /// they are retrieved by type with `Theme.of(context).extension<MyType>()`.
      extensions: <ThemeExtension<dynamic>>[
        BrandTheme.forBrightness(
          brightness: brightness,
          spacing: s.brandSpacing,
          accent: s.brandAccent,
        ),
      ],

      // ─────────────────────────────────────────────────────────────────
      // COLOR
      // ─────────────────────────────────────────────────────────────────

      /// The semantic palette. This is THE color property in Material 3:
      /// everything else should derive from it.
      ///
      /// Note: `colorScheme`, `primarySwatch` and `brightness` are mutually
      /// exclusive in practice. If you pass `colorScheme`, the scheme wins.
      colorScheme: scheme,

      // ── Loose colors, inherited from Material 2 ──────────────────────
      //
      // These properties PREDATE the ColorScheme and still exist for backwards
      // compatibility. When set, they BEAT the ColorScheme in the widgets that
      // still read them. They are the number one cause of "I changed the theme
      // and this screen stayed the same".
      //
      // Rule of thumb: do NOT use them in new code. They are exposed here so
      // you can see exactly what each one affects.
      /// Background of every [Scaffold]. If null → `colorScheme.surface`.
      scaffoldBackgroundColor: s.applyLegacyOverrides
          ? s.scaffoldBackgroundColor
          : null,

      /// Background of "canvases": [Drawer], dropdown menus, uncolored
      /// [Material].
      canvasColor: s.applyLegacyOverrides ? s.canvasColor : null,

      /// Color of [Divider], and of the separator lines in [DataTable],
      /// [ListTile] with a divider, bordered [Card] on M3...
      dividerColor: s.applyLegacyOverrides ? s.dividerColor : null,

      /// Color used to paint disabled widgets.
      disabledColor: s.applyLegacyOverrides ? s.disabledColor : null,

      /// Color of the `hintText` in [TextField]s.
      hintColor: s.applyLegacyOverrides ? s.hintColor : null,

      /// Color of the shadow cast by elevation.
      shadowColor: s.applyLegacyOverrides ? s.shadowColor : null,

      // ─────────────────────────────────────────────────────────────────
      // TYPOGRAPHY
      // ─────────────────────────────────────────────────────────────────

      /// The base scale (M3 / M2 / M1 sizes and weights). See STEP 2.
      typography: typography,

      /// The 15 final styles the widgets will read.
      textTheme: textTheme,

      /// Applies one font family to ALL the theme's styles at once.
      /// Equivalent to calling `textTheme.apply(fontFamily: ...)` but it also
      /// reaches `primaryTextTheme` and the component styles.
      fontFamily: s.fontChoice.family,

      /// Fallback families for glyphs the main one lacks (emoji, CJK...).
      fontFamilyFallback: const <String>['sans-serif'],

      /// Default icons: size, color and opacity.
      /// Left as null, M3 uses `colorScheme.onSurfaceVariant`.
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 24),

      /// The [IconThemeData] used ON TOP of primary surfaces (the Material 2
      /// AppBar, for instance). It pairs with `primaryTextTheme`.
      primaryIconTheme: IconThemeData(color: scheme.onPrimary, size: 24),

      /// An alternate [TextTheme] meant for text painted over the primary
      /// color. A leftover from M2, where the AppBar was always primary.
      primaryTextTheme: primaryTextTheme,

      // ─────────────────────────────────────────────────────────────────
      // COMPONENT THEMES — one theme per widget family
      // ─────────────────────────────────────────────────────────────────
      //
      // There are around 50 of these. They all follow the same pattern:
      // `XxxThemeData` with the same property names as the `Xxx` widget. What
      // you set here becomes the default for EVERY instance of that widget.
      //
      // We only configure a representative handful, and only when the user
      // flips the switch, so the defaults stay available for comparison.
      appBarTheme: s.applyComponentThemes
          ? AppBarThemeData(
              /// Center the title. On M3 the default is `false` (left
              /// aligned); on iOS and M2 you usually want `true`.
              centerTitle: s.appBarCenterTitle,

              /// Resting shadow. On M3 the default is 0: bars are flat.
              elevation: s.appBarElevation,

              /// Elevation while content is scrolled UNDERNEATH the bar. This
              /// is what makes the AppBar tint itself on scroll.
              scrolledUnderElevation: s.appBarElevation + 3,

              /// Title text style — and a trap worth stopping on.
              ///
              /// In Material 3 the AppBar sits on `surface`, so the normal
              /// `textTheme` (dark text) is correct. In Material 2 it sits on
              /// `primary`, so the title has to come from `primaryTextTheme`
              /// or you get dark text on a dark bar.
              ///
              /// Left as null, AppBar picks the right one by itself. The
              /// moment you override it, that choice becomes your problem.
              titleTextStyle: useMaterial3
                  ? textTheme.titleLarge
                  : primaryTextTheme.titleLarge,
            )
          : null,

      cardTheme: s.applyComponentThemes
          ? CardThemeData(
              /// The card's shape: the global corner radius.
              shape: shape,

              /// Shadow. On M3 Cards default to `elevation: 1`.
              elevation: 1,

              /// Default outer margin of every Card.
              margin: EdgeInsets.zero,

              /// M3 tints elevated surfaces with this color instead of using
              /// heavy shadows. `Colors.transparent` disables the tint.
              surfaceTintColor: scheme.surfaceTint,
            )
          : null,

      /// Every button shares the [ButtonStyle] API. Note [WidgetStateProperty]:
      /// it allows a DIFFERENT value per state (normal, hover, pressed,
      /// disabled, focused).
      elevatedButtonTheme: s.applyComponentThemes
          ? ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: shape,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            )
          : null,
      filledButtonTheme: s.applyComponentThemes
          ? FilledButtonThemeData(style: FilledButton.styleFrom(shape: shape))
          : null,
      outlinedButtonTheme: s.applyComponentThemes
          ? OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(shape: shape),
            )
          : null,
      textButtonTheme: s.applyComponentThemes
          ? TextButtonThemeData(style: TextButton.styleFrom(shape: shape))
          : null,

      inputDecorationTheme: s.applyComponentThemes
          ? InputDecorationThemeData(
              /// `filled: true` paints the field's background. That is the M3
              /// default look; on M2 fields were just a bottom line.
              filled: true,
              fillColor: scheme.surfaceContainerHighest,

              /// The resting border. Three variants combine here:
              /// [OutlineInputBorder] (a frame), [UnderlineInputBorder] (a
              /// line) and [InputBorder.none].
              border: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide.none,
              ),

              /// Border while the field holds focus.
              focusedBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: scheme.primary, width: 2),
              ),

              /// Border while there is an `errorText`.
              errorBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: scheme.error),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            )
          : null,

      chipTheme: s.applyComponentThemes
          ? ChipThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(s.cornerRadius * 0.7),
              ),
            )
          : null,

      dialogTheme: s.applyComponentThemes
          ? DialogThemeData(
              shape: RoundedRectangleBorder(
                // Dialogs usually carry a larger radius than everything else.
                borderRadius: BorderRadius.circular(s.cornerRadius * 2),
              ),
              elevation: 6,
            )
          : null,

      snackBarTheme: s.applyComponentThemes
          ? SnackBarThemeData(
              /// `floating` lifts it off the bottom edge; `fixed` glues it.
              behavior: SnackBarBehavior.floating,
              shape: shape,
            )
          : null,

      /// [DividerThemeData] controls thickness and margins as well as color.
      dividerTheme: s.applyComponentThemes
          ? const DividerThemeData(space: 24, thickness: 1)
          : null,

      /// The M3 navigation bar indicator (the "pill").
      navigationBarTheme: s.applyComponentThemes
          ? NavigationBarThemeData(
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(s.cornerRadius),
              ),
              labelTextStyle: WidgetStateProperty.resolveWith((
                Set<WidgetState> states,
              ) {
                // A WidgetStateProperty example: the selected label is painted
                // bold, the rest at normal weight.
                return states.contains(WidgetState.selected)
                    ? textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      )
                    : textTheme.labelMedium;
              }),
            )
          : null,

      listTileTheme: s.applyComponentThemes
          ? ListTileThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(s.cornerRadius * 0.75),
              ),
            )
          : null,

      tabBarTheme: s.applyComponentThemes
          ? TabBarThemeData(
              /// `tab` sizes the indicator to the tab's width; `label` sizes
              /// it to the text's width.
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
            )
          : null,

      tooltipTheme: s.applyComponentThemes
          ? TooltipThemeData(
              waitDuration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: scheme.inverseSurface,
                borderRadius: BorderRadius.circular(s.cornerRadius * 0.5),
              ),
              textStyle: textTheme.bodySmall?.copyWith(
                color: scheme.onInverseSurface,
              ),
            )
          : null,

      floatingActionButtonTheme: s.applyComponentThemes
          ? FloatingActionButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(s.cornerRadius),
              ),
            )
          : null,
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  //  Building the ColorScheme according to the chosen strategy
  // ═════════════════════════════════════════════════════════════════════

  /// Cache of already computed schemes.
  ///
  /// `ColorScheme.fromSeed` is not free: it converts the seed into HCT space,
  /// generates five tonal palettes and resolves around 45 roles. And it is
  /// called FOUR times per change here (light, dark, and their two
  /// high-contrast variants). Dragging a slider means four recomputations per
  /// frame.
  ///
  /// The key only includes the inputs that affect color, so moving the
  /// typography or corner-radius sliders no longer recomputes anything.
  static final Map<String, ColorScheme> _schemeCache = <String, ColorScheme>{};

  /// Cache ceiling. Without it the map would grow without bound while
  /// dragging sliders — the classic "temporary" cache memory leak.
  static const int _maxCachedSchemes = 64;

  static ColorScheme _buildColorScheme(
    ThemeLabState s,
    Brightness brightness,
    double? contrastOverride,
  ) {
    final double contrast = contrastOverride ?? s.contrastLevel;

    final String key =
        '${s.colorSource.name}|${brightness.name}|$contrast|'
        '${s.seedColor.toARGB32()}|${s.schemeVariant.name}|'
        '${s.primarySwatch.toARGB32()}|${s.manualPrimary.toARGB32()}|'
        '${s.manualSecondary.toARGB32()}|${s.manualTertiary.toARGB32()}|'
        '${s.manualError.toARGB32()}';

    final ColorScheme? cached = _schemeCache[key];
    if (cached != null) {
      return cached;
    }

    final ColorScheme scheme = _computeColorScheme(s, brightness, contrast);

    if (_schemeCache.length >= _maxCachedSchemes) {
      _schemeCache.remove(_schemeCache.keys.first);
    }
    _schemeCache[key] = scheme;
    return scheme;
  }

  static ColorScheme _computeColorScheme(
    ThemeLabState s,
    Brightness brightness,
    double contrast,
  ) {
    switch (s.colorSource) {
      // ── Material 3: one seed color → 45 roles ────────────────────────
      case ColorSchemeSource.seed:
        return ColorScheme.fromSeed(
          /// The only required color. It does NOT necessarily end up as
          /// `primary`: it is the algorithm's input, which moves it into HCT
          /// space and extracts tonal palettes from there.
          seedColor: s.seedColor,

          /// Produces the light or dark variant of the same palette.
          brightness: brightness,

          /// The algorithm's "character":
          ///  · tonalSpot  → the Material You standard. Restrained.
          ///  · fidelity   → stays as close to the original color as possible.
          ///  · content    → like fidelity, but derives harmonies from content.
          ///  · vibrant    → more saturation and contrast between roles.
          ///  · expressive → secondary/tertiary colors wander far from the seed.
          ///  · neutral    → nearly grey, barely tinted.
          ///  · monochrome → pure greyscale.
          ///  · rainbow / fruitSalad → playful, high-contrast palettes.
          dynamicSchemeVariant: s.schemeVariant,

          /// -1.0 (low contrast) … 0.0 (normal) … 1.0 (high contrast).
          /// Wire it to `MediaQuery.highContrastOf(context)` to honour the
          /// system accessibility settings.
          contrastLevel: contrast,
        );

      // ── Material 2: a MaterialColor of 10 shades ─────────────────────
      case ColorSchemeSource.swatch:
        // `ColorScheme.fromSwatch` is the bridge between the old world and the
        // new one: it takes the 50..900 scale and fills the roles as best it
        // can. Caveat: it does NOT generate M3's tonal roles (containers,
        // fixed...), so with M3 on, some components look washed out.
        return ColorScheme.fromSwatch(
          primarySwatch: s.primarySwatch,
          brightness: brightness,
        );

      // ── The Material 3 baseline palette (the factory purples) ────────
      case ColorSchemeSource.baseline:
        return brightness == Brightness.dark
            ? const ColorScheme.dark()
            : const ColorScheme.light();

      // ── Role by role, by hand ────────────────────────────────────────
      case ColorSchemeSource.manual:
        // A very useful trick: start from a generated scheme and override ONLY
        // the roles your brand dictates. That way you never write all 45 and
        // the rest keeps coherent contrast.
        return ColorScheme.fromSeed(
          seedColor: s.manualPrimary,
          brightness: brightness,
          contrastLevel: contrast,
        ).copyWith(
          /// The main action color: FAB, FilledButton, active Switch.
          primary: s.manualPrimary,

          /// Supporting accent: selected FilterChip, secondary elements.
          secondary: s.manualSecondary,

          /// A third accent, for contrast and balance. New in M3.
          tertiary: s.manualTertiary,

          /// Error states: invalid TextField borders, error text.
          error: s.manualError,
        );
    }
  }

  // ═════════════════════════════════════════════════════════════════════
  //  PageTransitionsTheme
  // ═════════════════════════════════════════════════════════════════════
  static PageTransitionsTheme? _buildPageTransitions(PageTransitionKind kind) {
    if (kind == PageTransitionKind.defaults) {
      // `null` → Flutter uses its default map: Zoom on Android, Cupertino on
      // iOS/macOS, a fade elsewhere.
      return null;
    }

    final PageTransitionsBuilder builder = switch (kind) {
      PageTransitionKind.zoom => const ZoomPageTransitionsBuilder(),
      PageTransitionKind.fadeForwards =>
        const FadeForwardsPageTransitionsBuilder(),
      PageTransitionKind.cupertino => const CupertinoPageTransitionsBuilder(),
      PageTransitionKind.predictiveBack =>
        const PredictiveBackPageTransitionsBuilder(),
      PageTransitionKind.defaults => const ZoomPageTransitionsBuilder(),
    };

    // The map goes platform → animation builder. We force the same one
    // everywhere so the effect is visible wherever you run this.
    return PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        for (final TargetPlatform platform in TargetPlatform.values)
          platform: builder,
      },
    );
  }
}
