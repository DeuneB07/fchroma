import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  THEME EXTENSION — how to put YOUR own properties inside the theme
// ───────────────────────────────────────────────────────────────────────────
//  The problem: [ThemeData] has ~150 properties, but none of them is called
//  "successColor", "cardSpacing" or "brandGradient". Before ThemeExtensions
//  people solved this with global constants
//  (`class AppColors { static const success = ... }`), which broke dark mode
//  and could not be interpolated.
//
//  The official solution: extend [ThemeExtension<T>] and register it in
//  `ThemeData(extensions: [...])`. From then on your properties:
//    · travel with the theme (light and dark hold different values),
//    · are read with `Theme.of(context).extension<BrandTheme>()!`,
//    · ANIMATE across theme changes, thanks to your `lerp` implementation.
// ═══════════════════════════════════════════════════════════════════════════

@immutable
class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    required this.spacing,
    required this.accent,
    required this.onAccent,
    required this.successColor,
    required this.warningColor,
    required this.brandGradient,
  });

  /// The brand's own spacing scale. Material defines none.
  final double spacing;

  /// A corporate color that fits no [ColorScheme] role.
  final Color accent;

  /// Color legible on top of [accent] (the same "onX" pattern Material uses).
  final Color onAccent;

  /// Semantics Material 3 does not cover: it only ships `error`, no `success`
  /// and no `warning`. This is the flagship use case for extensions.
  final Color successColor;
  final Color warningColor;

  /// Extensions are not limited to colors and numbers: any object works.
  final LinearGradient brandGradient;

  // ── ThemeExtension requirement 1: copyWith ───────────────────────────────
  // Lets you derive variants without rebuilding the whole object.
  @override
  BrandTheme copyWith({
    double? spacing,
    Color? accent,
    Color? onAccent,
    Color? successColor,
    Color? warningColor,
    LinearGradient? brandGradient,
  }) {
    return BrandTheme(
      spacing: spacing ?? this.spacing,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      brandGradient: brandGradient ?? this.brandGradient,
    );
  }

  // ── ThemeExtension requirement 2: lerp ───────────────────────────────────
  // This is what makes your colors blend smoothly instead of snapping when the
  // app moves from light to dark. Returning `this` unconditionally would make
  // the change instant (sometimes that is exactly what you want).
  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }
    return BrandTheme(
      // lerpDouble and Color.lerp are the helpers Flutter ships.
      spacing: spacing + (other.spacing - spacing) * t,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      brandGradient: LinearGradient.lerp(
        brandGradient,
        other.brandGradient,
        t,
      )!,
    );
  }

  /// Syntactic sugar for reading the extension without spelling the generic:
  /// `BrandTheme.of(context).successColor`.
  ///
  /// The `?? _fallback` avoids the classic crash: if someone uses this widget
  /// under a [Theme] that never registered the extension, `extension<T>()`
  /// returns null.
  static BrandTheme of(BuildContext context) {
    return Theme.of(context).extension<BrandTheme>() ?? _fallback;
  }

  static const BrandTheme _fallback = BrandTheme(
    spacing: 16,
    accent: Color(0xFFFF6D00),
    onAccent: Colors.white,
    successColor: Color(0xFF2E7D32),
    warningColor: Color(0xFFF9A825),
    brandGradient: LinearGradient(
      colors: <Color>[Color(0xFFFF6D00), Color(0xFFFFAB40)],
    ),
  );

  /// Builds the extension for a given brightness.
  ///
  /// Note how the colors change with [brightness]: that is precisely what a
  /// global constant CANNOT do.
  factory BrandTheme.forBrightness({
    required Brightness brightness,
    required double spacing,
    required Color accent,
  }) {
    final bool isDark = brightness == Brightness.dark;
    return BrandTheme(
      spacing: spacing,
      accent: accent,
      // Pick black or white based on the brand color's luminance: the same
      // contrast criterion Material applies internally.
      onAccent: accent.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      successColor: isDark ? const Color(0xFF7BD88F) : const Color(0xFF2E7D32),
      warningColor: isDark ? const Color(0xFFFFD54F) : const Color(0xFFF9A825),
      brandGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          accent,
          Color.lerp(accent, isDark ? Colors.black : Colors.white, 0.45)!,
        ],
      ),
    );
  }
}
