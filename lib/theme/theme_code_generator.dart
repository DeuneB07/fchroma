import 'package:flutter/material.dart';

import '../state/theme_lab_state.dart';
import '../ui/widgets/lab_widgets.dart';

/// Generates the Dart source equivalent to the current configuration.
///
/// This is the piece that makes the lab genuinely useful: you play with the
/// controls until you like the result and walk away with a ThemeData ready to
/// paste into your own project.
///
/// Note that the strings written below are the OUTPUT of the generator, not
/// comments in this file. They end up as comments in the exported Dart, so
/// they follow the project's rule that code comments are English — in both
/// UI languages, exactly like the snippets the pages display.
abstract final class ThemeCodeGenerator {
  static String generate(ThemeLabState s) {
    final StringBuffer b = StringBuffer();

    b.writeln('import \'package:flutter/material.dart\';');
    b.writeln();
    b.writeln('/// Theme generated with FChroma.');
    b.writeln('///');
    b.writeln('/// Call this function twice from MaterialApp:');
    b.writeln('///   theme:     buildAppTheme(Brightness.light)');
    b.writeln('///   darkTheme: buildAppTheme(Brightness.dark)');
    b.writeln('ThemeData buildAppTheme(Brightness brightness) {');
    b.writeln('  final ColorScheme colorScheme = ${_scheme(s)};');
    b.writeln();
    b.writeln('  return ThemeData(');
    b.writeln('    // ── General configuration ──────────────────────────');
    b.writeln('    useMaterial3: ${s.useMaterial3},');
    b.writeln('    colorScheme: colorScheme,');

    // Density
    if (s.adaptiveDensity) {
      b.writeln('    visualDensity: VisualDensity.adaptivePlatformDensity,');
    } else if (s.densityHorizontal != 0 || s.densityVertical != 0) {
      b.writeln(
        '    visualDensity: const VisualDensity(\n'
        '      horizontal: ${s.densityHorizontal.toStringAsFixed(1)},\n'
        '      vertical: ${s.densityVertical.toStringAsFixed(1)},\n'
        '    ),',
      );
    }

    if (s.tapTargetSize != MaterialTapTargetSize.padded) {
      b.writeln(
        '    materialTapTargetSize: MaterialTapTargetSize.${s.tapTargetSize.name},',
      );
    }

    final String? splash = _splash(s.splash);
    if (splash != null) {
      b.writeln('    splashFactory: $splash,');
    }

    if (!s.useMaterial3 && s.applyElevationOverlayColor) {
      b.writeln('    applyElevationOverlayColor: true,');
    }

    if (s.pageTransition != PageTransitionKind.defaults) {
      b.writeln();
      b.writeln('    // ── Route transitions ────────────────────────────');
      b.writeln('    pageTransitionsTheme: const PageTransitionsTheme(');
      b.writeln('      builders: <TargetPlatform, PageTransitionsBuilder>{');
      b.writeln(
        '        TargetPlatform.android: ${_transition(s.pageTransition)},',
      );
      b.writeln(
        '        TargetPlatform.iOS: ${_transition(s.pageTransition)},',
      );
      b.writeln('      },');
      b.writeln('    ),');
    }

    // Typography
    b.writeln();
    b.writeln('    // ── Typography ───────────────────────────────────');
    b.writeln('    typography: ${_typography(s)},');
    if (s.fontChoice.family != null) {
      b.writeln('    fontFamily: \'${s.fontChoice.family}\',');
    }
    if (_needsTextTheme(s)) {
      b.writeln('    textTheme: _buildTextTheme(brightness),');
    }

    // Legacy colors
    if (s.applyLegacyOverrides) {
      b.writeln();
      b.writeln('    // ── Loose overrides (Material 2 legacy) ──────────');
      b.writeln('    // Careful: these BEAT the colorScheme.');
      b.writeln(
        '    scaffoldBackgroundColor: const Color(${hexOf(s.scaffoldBackgroundColor)}),',
      );
      b.writeln('    canvasColor: const Color(${hexOf(s.canvasColor)}),');
      b.writeln('    dividerColor: const Color(${hexOf(s.dividerColor)}),');
      b.writeln('    disabledColor: const Color(${hexOf(s.disabledColor)}),');
      b.writeln('    hintColor: const Color(${hexOf(s.hintColor)}),');
      b.writeln('    shadowColor: const Color(${hexOf(s.shadowColor)}),');
    }

    // Component themes
    if (s.applyComponentThemes) {
      final String r = s.cornerRadius.toStringAsFixed(0);
      b.writeln();
      b.writeln('    // ── Component themes ─────────────────────────────');
      b.writeln('    appBarTheme: AppBarThemeData(');
      b.writeln('      centerTitle: ${s.appBarCenterTitle},');
      b.writeln('      elevation: ${s.appBarElevation.toStringAsFixed(1)},');
      b.writeln(
        '      scrolledUnderElevation: ${(s.appBarElevation + 3).toStringAsFixed(1)},',
      );
      b.writeln('    ),');
      b.writeln('    cardTheme: CardThemeData(');
      b.writeln('      elevation: 1,');
      b.writeln('      margin: EdgeInsets.zero,');
      b.writeln('      shape: RoundedRectangleBorder(');
      b.writeln('        borderRadius: BorderRadius.circular($r),');
      b.writeln('      ),');
      b.writeln('    ),');
      b.writeln('    filledButtonTheme: FilledButtonThemeData(');
      b.writeln('      style: FilledButton.styleFrom(');
      b.writeln('        shape: RoundedRectangleBorder(');
      b.writeln('          borderRadius: BorderRadius.circular($r),');
      b.writeln('        ),');
      b.writeln('      ),');
      b.writeln('    ),');
      b.writeln('    inputDecorationTheme: InputDecorationThemeData(');
      b.writeln('      filled: true,');
      b.writeln('      fillColor: colorScheme.surfaceContainerHighest,');
      b.writeln('      border: OutlineInputBorder(');
      b.writeln('        borderRadius: BorderRadius.circular($r),');
      b.writeln('        borderSide: BorderSide.none,');
      b.writeln('      ),');
      b.writeln('      focusedBorder: OutlineInputBorder(');
      b.writeln('        borderRadius: BorderRadius.circular($r),');
      b.writeln(
        '        borderSide: BorderSide(color: colorScheme.primary, width: 2),',
      );
      b.writeln('      ),');
      b.writeln('    ),');
      b.writeln('    dialogTheme: DialogThemeData(');
      b.writeln('      shape: RoundedRectangleBorder(');
      b.writeln(
        '        borderRadius: BorderRadius.circular(${(s.cornerRadius * 2).toStringAsFixed(0)}),',
      );
      b.writeln('      ),');
      b.writeln('    ),');
      b.writeln('    snackBarTheme: SnackBarThemeData(');
      b.writeln('      behavior: SnackBarBehavior.floating,');
      b.writeln('      shape: RoundedRectangleBorder(');
      b.writeln('        borderRadius: BorderRadius.circular($r),');
      b.writeln('      ),');
      b.writeln('    ),');
    }

    // Extensions
    b.writeln();
    b.writeln('    // ── Your own properties ──────────────────────────');
    b.writeln('    extensions: <ThemeExtension<dynamic>>[');
    b.writeln('      BrandTheme(');
    b.writeln('        spacing: ${s.brandSpacing.toStringAsFixed(0)},');
    b.writeln('        accent: const Color(${hexOf(s.brandAccent)}),');
    b.writeln('      ),');
    b.writeln('    ],');
    b.writeln('  );');
    b.writeln('}');

    if (_needsTextTheme(s)) {
      b.writeln();
      b.writeln(_textThemeFunction(s));
    }

    return b.toString();
  }

  static String _scheme(ThemeLabState s) => switch (s.colorSource) {
    ColorSchemeSource.seed =>
      'ColorScheme.fromSeed(\n'
          '    seedColor: const Color(${hexOf(s.seedColor)}),\n'
          '    brightness: brightness,\n'
          '    dynamicSchemeVariant: DynamicSchemeVariant.${s.schemeVariant.name},\n'
          '    contrastLevel: ${s.contrastLevel.toStringAsFixed(2)},\n'
          '  )',
    ColorSchemeSource.swatch =>
      'ColorScheme.fromSwatch(\n'
          '    primarySwatch: Colors.indigo,\n'
          '    brightness: brightness,\n'
          '  )',
    ColorSchemeSource.baseline =>
      'brightness == Brightness.dark\n'
          '      ? const ColorScheme.dark()\n'
          '      : const ColorScheme.light()',
    ColorSchemeSource.manual =>
      'ColorScheme.fromSeed(\n'
          '    seedColor: const Color(${hexOf(s.manualPrimary)}),\n'
          '    brightness: brightness,\n'
          '  ).copyWith(\n'
          '    primary: const Color(${hexOf(s.manualPrimary)}),\n'
          '    secondary: const Color(${hexOf(s.manualSecondary)}),\n'
          '    tertiary: const Color(${hexOf(s.manualTertiary)}),\n'
          '    error: const Color(${hexOf(s.manualError)}),\n'
          '  )',
  };

  static String _typography(ThemeLabState s) => switch (s.typography) {
    TypographyKind.material2021 =>
      'Typography.material2021(colorScheme: colorScheme)',
    TypographyKind.material2018 => 'Typography.material2018()',
    TypographyKind.material2014 => 'Typography.material2014()',
  };

  static String? _splash(SplashKind k) => switch (k) {
    SplashKind.auto => null,
    SplashKind.inkSparkle => 'InkSparkle.splashFactory',
    SplashKind.inkRipple => 'InkRipple.splashFactory',
    SplashKind.inkSplash => 'InkSplash.splashFactory',
    SplashKind.noSplash => 'NoSplash.splashFactory',
  };

  static String _transition(PageTransitionKind k) => switch (k) {
    PageTransitionKind.zoom => 'ZoomPageTransitionsBuilder()',
    PageTransitionKind.fadeForwards => 'FadeForwardsPageTransitionsBuilder()',
    PageTransitionKind.cupertino => 'CupertinoPageTransitionsBuilder()',
    PageTransitionKind.predictiveBack =>
      'PredictiveBackPageTransitionsBuilder()',
    PageTransitionKind.defaults => 'ZoomPageTransitionsBuilder()',
  };

  static bool _needsTextTheme(ThemeLabState s) =>
      s.textPreset != TextThemePreset.framework ||
      s.fontSizeScale != 1.0 ||
      s.letterSpacingDelta != 0.0 ||
      s.lineHeightScale != 1.0;

  static String _textThemeFunction(ThemeLabState s) {
    final StringBuffer b = StringBuffer();
    b.writeln('/// The type scale, transformed from the base one.');
    b.writeln('///');
    b.writeln('/// Never start from an empty TextTheme(): you would lose the');
    b.writeln('/// colours and heights Flutter had already resolved.');
    b.writeln('TextTheme _buildTextTheme(Brightness brightness) {');
    b.writeln('  final Typography typography = Typography.material2021();');
    b.writeln();
    b.writeln('  // `black` and `white` carry COLOURS only — every fontSize');
    b.writeln('  // in them is null. Flutter normally merges the geometry in');
    b.writeln('  // later, inside ThemeData.localize(). Since the code below');
    b.writeln('  // scales sizes, the geometry has to be merged in up front,');
    b.writeln('  // or `apply(fontSizeFactor:)` asserts on a null fontSize.');
    b.writeln('  TextTheme base = typography.englishLike.merge(');
    b.writeln('    brightness == Brightness.dark');
    b.writeln('        ? typography.white');
    b.writeln('        : typography.black,');
    b.writeln('  );');
    b.writeln();

    if (s.textPreset == TextThemePreset.mono) {
      b.writeln('  base = base.apply(fontFamily: \'monospace\');');
    } else if (s.textPreset == TextThemePreset.compact) {
      b.writeln('  base = base.apply(fontSizeFactor: 0.88);');
    }

    if (s.fontSizeScale != 1.0) {
      b.writeln(
        '  base = base.apply(fontSizeFactor: ${s.fontSizeScale.toStringAsFixed(2)});',
      );
    }

    if (s.letterSpacingDelta != 0.0 || s.lineHeightScale != 1.0) {
      b.writeln();
      b.writeln('  // Neither letterSpacing nor height has a shortcut in');
      b.writeln('  // apply(), so the styles have to be walked by hand.');
      b.writeln('  TextStyle? tune(TextStyle? style) {');
      b.writeln('    if (style == null) return null;');
      b.writeln('    return style.copyWith(');
      if (s.letterSpacingDelta != 0.0) {
        b.writeln(
          '      letterSpacing: (style.letterSpacing ?? 0) + '
          '${s.letterSpacingDelta.toStringAsFixed(2)},',
        );
      }
      if (s.lineHeightScale != 1.0) {
        b.writeln(
          '      height: style.height == null\n'
          '          ? null\n'
          '          : style.height! * ${s.lineHeightScale.toStringAsFixed(2)},',
        );
      }
      b.writeln('    );');
      b.writeln('  }');
      b.writeln();
      b.writeln('  return base.copyWith(');
      for (final String role in <String>[
        'displayLarge',
        'displayMedium',
        'displaySmall',
        'headlineLarge',
        'headlineMedium',
        'headlineSmall',
        'titleLarge',
        'titleMedium',
        'titleSmall',
        'bodyLarge',
        'bodyMedium',
        'bodySmall',
        'labelLarge',
        'labelMedium',
        'labelSmall',
      ]) {
        b.writeln('    $role: tune(base.$role),');
      }
      b.writeln('  );');
    } else {
      b.writeln();
      b.writeln('  return base;');
    }

    b.writeln('}');
    return b.toString();
  }
}
