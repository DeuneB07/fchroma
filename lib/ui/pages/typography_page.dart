import 'package:flutter/material.dart';

import '../../l10n/enum_labels.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/lab_strings.dart';
import '../../l10n/strings/typography_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// Page 5 — [Typography], font families and icons.
///
/// The key distinction almost nobody spells out:
///   · [Typography]  = the BASE SCALE (which sizes and weights exist).
///   · [TextTheme]   = the resolved, colored scale the widgets actually read.
/// ThemeData takes the Typography, picks the `black` or `white` set according
/// to the brightness, and the default TextTheme comes out of that.
class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final TypographyStrings t = LabStrings.of(context).typography;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.baseScaleHeading, icon: Icons.straighten),
        PropertyCard(
          name: 'ThemeData.typography',
          type: 'Typography',
          description: t.typographyDescription,
          defaultValue: t.typographyDefault,
          currentValue: s.typography.name,
          demo: SegmentedButton<TypographyKind>(
            segments: const <ButtonSegment<TypographyKind>>[
              ButtonSegment<TypographyKind>(
                value: TypographyKind.material2021,
                label: Text('2021 (M3)'),
              ),
              ButtonSegment<TypographyKind>(
                value: TypographyKind.material2018,
                label: Text('2018 (M2)'),
              ),
              ButtonSegment<TypographyKind>(
                value: TypographyKind.material2014,
                label: Text('2014 (M1)'),
              ),
            ],
            selected: <TypographyKind>{s.typography},
            onSelectionChanged: (Set<TypographyKind> v) =>
                s.update(() => s.typography = v.first),
          ),
          tip: t.typographyTip,
        ),

        SectionTitle(t.blackWhiteHeading, icon: Icons.contrast),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.blackWhiteBody, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                const CodeBlock('''
final Typography typography = Typography.material2021(
  colorScheme: scheme,
);

// The right choice depends on the theme's brightness:
final TextTheme base = brightness == Brightness.dark
    ? typography.white     // light text on a dark background
    : typography.black;    // dark text on a light background

// There are also per-platform variants with slightly different metrics:
Typography.blackMountainView   // Android (Roboto)
Typography.whiteMountainView
Typography.blackCupertino      // iOS (San Francisco)
Typography.whiteCupertino
Typography.blackRedmond        // Windows (Segoe UI)
Typography.blackHelsinki       // Linux
Typography.blackRedwoodCity    // Web'''),
              ],
            ),
          ),
        ),

        SectionTitle(t.familiesHeading, icon: Icons.font_download),
        PropertyCard(
          name: 'ThemeData.fontFamily',
          type: 'String?',
          description: t.fontFamilyDescription,
          defaultValue: t.fontFamilyDefault,
          currentValue: s.fontChoice.family ?? 'null',
          demo: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final FontChoice f in FontChoice.values)
                ChoiceChip(
                  label: Text(f.label(AppLocalizations.of(context))),
                  selected: s.fontChoice == f,
                  onSelected: (_) => s.update(() => s.fontChoice = f),
                ),
            ],
          ),
          tip: t.fontFamilyTip,
        ),
        PropertyCard(
          name: 'ThemeData.fontFamilyFallback',
          type: 'List<String>?',
          description: t.fallbackDescription,
          defaultValue: 'null',
        ),
        const CodeBlock('''
# pubspec.yaml — declaring a font of your own
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
        - asset: assets/fonts/Inter-Italic.ttf
          style: italic''', label: 'yaml'),
        const CodeBlock('''
// And in the theme:
ThemeData(
  fontFamily: 'Inter',
  fontFamilyFallback: const <String>['NotoColorEmoji', 'sans-serif'],
)'''),

        SectionTitle(t.anatomyHeading, icon: Icons.format_size),
        const _TextStyleAnatomy(),

        SectionTitle(t.onPrimaryHeading, icon: Icons.invert_colors),
        PropertyCard(
          name: 'ThemeData.primaryTextTheme',
          type: 'TextTheme',
          description: t.primaryTextThemeDescription,
          defaultValue: t.primaryTextThemeDefault,
          deprecated: true,
          tip: t.primaryTextThemeTip,
        ),

        SectionTitle(t.iconsHeading, icon: Icons.emoji_symbols),
        PropertyCard(
          name: 'ThemeData.iconTheme',
          type: 'IconThemeData',
          description: t.iconThemeDescription,
          defaultValue: t.iconThemeDefault,
          // Wrap rather than Row: on a narrow phone the five sizes do not fit
          // on one line, and a Row would overflow instead of wrapping.
          demo: Wrap(
            spacing: 12,
            runSpacing: 8,
            children: <Widget>[
              for (final double size in <double>[16, 20, 24, 32, 40])
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.favorite, size: size),
                    Text('${size.toInt()}', style: theme.textTheme.labelSmall),
                  ],
                ),
            ],
          ),
        ),
        PropertyCard(
          name: 'ThemeData.primaryIconTheme',
          type: 'IconThemeData',
          description: t.primaryIconThemeDescription,
          deprecated: true,
        ),

        SectionTitle(t.defaultTextStyleHeading, icon: Icons.text_format),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.defaultTextStyleBody, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                const CodeBlock('''
DefaultTextStyle.merge(
  style: const TextStyle(fontStyle: FontStyle.italic),
  child: Column(
    children: <Widget>[
      Text('I inherit the italics'),
      Text('So do I'),
    ],
  ),
)'''),
                const SizedBox(height: 8),
                DefaultTextStyle.merge(
                  style: const TextStyle(fontStyle: FontStyle.italic),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(t.inheritsItalic),
                      Text(t.inheritsItalicToo),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SectionTitle(t.accessibilityHeading, icon: Icons.accessibility),
        PropertyCard(
          name: 'MediaQuery.textScalerOf(context)',
          type: 'TextScaler',
          description: t.textScalerDescription,
          tip: t.textScalerTip,
        ),
      ],
    );
  }
}

/// A visual breakdown of a [TextStyle]'s properties.
class _TextStyleAnatomy extends StatelessWidget {
  const _TextStyleAnatomy();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TypographyStrings t = LabStrings.of(context).typography;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final TextStyleProperty p in t.styleProperties)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Wrap, not Row: pairs like `leadingDistribution` +
                    // `TextLeadingDistribution?` are wider than a phone, and
                    // monospace identifiers have no spaces to break at.
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text(
                          p.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          p.type,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontFamily: 'monospace',
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Text(p.description, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text(t.liveExamplesHeading, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 20,
              runSpacing: 12,
              children: <Widget>[
                Text(
                  'fontFeatures: tabular',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFeatures: const <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                Text(
                  'decoration: wavy',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: theme.colorScheme.error,
                  ),
                ),
                Text(
                  'shadows',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    shadows: <Shadow>[
                      Shadow(
                        color: theme.colorScheme.primary,
                        offset: const Offset(1.5, 1.5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
                Text(
                  'backgroundColor',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    backgroundColor: theme.colorScheme.tertiaryContainer,
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
