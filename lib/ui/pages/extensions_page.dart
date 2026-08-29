import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/extensions_strings.dart';
import '../../state/theme_lab_state.dart';
import '../../theme/brand_theme_extension.dart';
import '../widgets/lab_widgets.dart';

/// Page 9 — [ThemeExtension]: putting YOUR properties inside the theme.
class ExtensionsPage extends StatelessWidget {
  const ExtensionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    // This is how an extension is read. It is safe here because the builder
    // always registers it; in library code use the `?? fallback` pattern.
    final BrandTheme brand = BrandTheme.of(context);
    final ExtensionsStrings t = LabStrings.of(context).extensions;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.problemHeading, icon: Icons.report_problem_outlined),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.problemBody, style: theme.textTheme.bodyMedium),
                const CodeBlock('''
// ✗ The classic anti-pattern
class AppColors {
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
}

// The problems:
//  · it does not change in dark mode,
//  · it is not interpolated when the theme animates,
//  · it cannot be overridden for one branch of the tree,
//  · it does not show up in DevTools beside the rest of the theme.'''),
              ],
            ),
          ),
        ),

        SectionTitle(t.solutionHeading, icon: Icons.extension),
        const CodeBlock('''
// 1. Declare the class, extending ThemeExtension<T>
@immutable
class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    required this.spacing,
    required this.successColor,
  });

  final double spacing;
  final Color successColor;

  // 2. copyWith: required
  @override
  BrandTheme copyWith({double? spacing, Color? successColor}) {
    return BrandTheme(
      spacing: spacing ?? this.spacing,
      successColor: successColor ?? this.successColor,
    );
  }

  // 3. lerp: required. It is what makes your colours BLEND on a
  //    theme change instead of snapping.
  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) return this;
    return BrandTheme(
      spacing: spacing + (other.spacing - spacing) * t,
      successColor: Color.lerp(successColor, other.successColor, t)!,
    );
  }
}

// 4. Register it in the theme (the list takes several at once)
ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    BrandTheme(spacing: 16, successColor: Color(0xFF2E7D32)),
  ],
)

// 5. Use it. It is retrieved BY TYPE.
final BrandTheme brand = Theme.of(context).extension<BrandTheme>()!;
Container(color: brand.successColor);'''),

        SectionTitle(t.liveHeading, icon: Icons.science),
        PropertyCard(
          name: 'BrandTheme.spacing',
          type: 'double',
          description: t.spacingDescription,
          currentValue: '${brand.spacing.toStringAsFixed(0)} px',
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider(
                value: s.brandSpacing,
                min: 4,
                max: 40,
                divisions: 18,
                label: s.brandSpacing.toStringAsFixed(0),
                onChanged: (double v) => s.update(() => s.brandSpacing = v),
              ),
              // The padding comes from the extension, not from a constant.
              Container(
                padding: EdgeInsets.all(brand.spacing),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Text(
                  'padding: EdgeInsets.all(brand.spacing)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        PropertyCard(
          name: 'BrandTheme.accent / onAccent',
          type: 'Color',
          description: t.accentDescription,
          currentValue: hexOf(brand.accent),
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final Color c in <Color>[
                    const Color(0xFFFF6D00),
                    const Color(0xFFD81B60),
                    const Color(0xFF00ACC1),
                    const Color(0xFF43A047),
                    const Color(0xFF8E24AA),
                  ])
                    GestureDetector(
                      onTap: () => s.update(() => s.brandAccent = c),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: s.brandAccent.toARGB32() == c.toARGB32()
                                ? theme.colorScheme.onSurface
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  // A gradient stored inside the extension: extensions are not
                  // limited to colors and numbers.
                  gradient: brand.brandGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'brand.brandGradient + brand.onAccent',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: brand.onAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
        PropertyCard(
          name: 'BrandTheme.successColor / warningColor',
          type: 'Color',
          description: t.statesDescription,
          // Three Expanded boxes in a Row split a phone into ~75 px columns,
          // and `colorScheme.error` is one unbreakable token far wider than
          // that. A Wrap with a floor on the box width lets them stack instead
          // of clipping the labels.
          demo: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: _StatusBox(
                  color: brand.successColor,
                  icon: Icons.check_circle_outline,
                  label: 'successColor',
                ),
              ),
              SizedBox(
                width: 150,
                child: _StatusBox(
                  color: brand.warningColor,
                  icon: Icons.warning_amber_outlined,
                  label: 'warningColor',
                ),
              ),
              SizedBox(
                width: 150,
                child: _StatusBox(
                  color: theme.colorScheme.error,
                  icon: Icons.error_outline,
                  label: 'colorScheme.error',
                ),
              ),
            ],
          ),
          tip: t.statesTip,
        ),

        SectionTitle(t.branchHeading, icon: Icons.account_tree),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.branchBody, style: theme.textTheme.bodyMedium),
                const CodeBlock('''
Theme(
  data: Theme.of(context).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      BrandTheme.of(context).copyWith(accent: Colors.pink),
    ],
  ),
  child: const MiSeccionEspecial(),
)'''),
                const SizedBox(height: 8),
                Theme(
                  data: theme.copyWith(
                    extensions: <ThemeExtension<dynamic>>[
                      brand.copyWith(
                        accent: Colors.pink,
                        onAccent: Colors.white,
                      ),
                    ],
                  ),
                  child: Builder(
                    // The Builder is needed to get a context sitting below the
                    // Theme we just created.
                    builder: (BuildContext innerContext) {
                      final BrandTheme localBrand = BrandTheme.of(innerContext);
                      return Container(
                        padding: EdgeInsets.all(localBrand.spacing),
                        decoration: BoxDecoration(
                          color: localBrand.accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          t.branchLabel,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: localBrand.onAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        SectionTitle(t.practicesHeading, icon: Icons.checklist),
        PropertyCard(
          name: 'BrandTheme.of(context)',
          type: 'static BrandTheme Function(BuildContext)',
          description: t.helperDescription,
        ),
        PropertyCard(
          name: t.oneOrManyName,
          type: t.oneOrManyType,
          description: t.oneOrManyDescription,
        ),
      ],
    );
  }
}

class _StatusBox extends StatelessWidget {
  const _StatusBox({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
