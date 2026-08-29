import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/legacy_colors_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// Page 6 — [ThemeData]'s loose color properties.
///
/// They predate the [ColorScheme] and are still around for compatibility. When
/// set, they BEAT the ColorScheme in the widgets that still read them. They
/// are the number one cause of "I changed the theme and this screen didn't".
class LegacyColorsPage extends StatelessWidget {
  const LegacyColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final LegacyColorsStrings t = LabStrings.of(context).legacyColors;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        Card(
          color: theme.colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: theme.colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t.ruleOfThumb,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        SwitchListTile(
          title: Text(t.applyOverridesTitle),
          subtitle: Text(t.applyOverridesSubtitle),
          value: s.applyLegacyOverrides,
          onChanged: (bool v) => s.update(() => s.applyLegacyOverrides = v),
        ),

        SectionTitle(t.backgroundsHeading, icon: Icons.wallpaper),
        _ColorProperty(
          name: 'scaffoldBackgroundColor',
          description: t.scaffoldBackgroundDescription,
          fallback: 'colorScheme.surface',
          value: s.scaffoldBackgroundColor,
          onChanged: (Color c) => s.update(() => s.scaffoldBackgroundColor = c),
          enabled: s.applyLegacyOverrides,
        ),
        _ColorProperty(
          name: 'canvasColor',
          description: t.canvasDescription,
          fallback: 'colorScheme.surface',
          value: s.canvasColor,
          onChanged: (Color c) => s.update(() => s.canvasColor = c),
          enabled: s.applyLegacyOverrides,
        ),
        PropertyCard(
          name: 'cardColor',
          type: 'Color',
          description: t.cardColorDescription,
          deprecated: true,
        ),

        SectionTitle(t.dividersHeading, icon: Icons.horizontal_rule),
        _ColorProperty(
          name: 'dividerColor',
          description: t.dividerDescription,
          fallback: 'colorScheme.outlineVariant',
          value: s.dividerColor,
          onChanged: (Color c) => s.update(() => s.dividerColor = c),
          enabled: s.applyLegacyOverrides,
          demo: Column(
            children: <Widget>[
              Text(t.aboveDivider),
              const Divider(),
              Text(t.belowDivider),
            ],
          ),
        ),

        SectionTitle(t.interactionHeading, icon: Icons.touch_app),
        _ColorProperty(
          name: 'disabledColor',
          description: t.disabledDescription,
          fallback: t.disabledFallback,
          value: s.disabledColor,
          onChanged: (Color c) => s.update(() => s.disabledColor = c),
          enabled: s.applyLegacyOverrides,
          demo: Row(
            children: <Widget>[
              ElevatedButton(onPressed: null, child: Text(t.disabledDemoLabel)),
              const SizedBox(width: 12),
              const Icon(Icons.block),
            ],
          ),
        ),
        _ColorProperty(
          name: 'hintColor',
          description: t.hintDescription,
          fallback: 'onSurfaceVariant',
          value: s.hintColor,
          onChanged: (Color c) => s.update(() => s.hintColor = c),
          enabled: s.applyLegacyOverrides,
          demo: TextField(
            decoration: InputDecoration(hintText: t.hintDemoText),
          ),
        ),
        PropertyCard(
          name: 'focusColor / hoverColor / highlightColor / splashColor',
          type: 'Color',
          description: t.inkStatesDescription,
          deprecated: true,
          tip: t.inkStatesTip,
        ),

        SectionTitle(t.shadowsHeading, icon: Icons.filter_drama),
        _ColorProperty(
          name: 'shadowColor',
          description: t.shadowDescription,
          fallback: t.shadowFallback,
          value: s.shadowColor,
          onChanged: (Color c) => s.update(() => s.shadowColor = c),
          enabled: s.applyLegacyOverrides,
          demo: const Row(
            children: <Widget>[
              Card(
                elevation: 8,
                child: SizedBox(
                  width: 90,
                  height: 50,
                  child: Center(child: Text('elev 8')),
                ),
              ),
            ],
          ),
        ),

        SectionTitle(t.removedHeading, icon: Icons.delete_forever),
        PropertyCard(
          name:
              'accentColor · backgroundColor · bottomAppBarColor · '
              'toggleableActiveColor · errorColor · selectedRowColor',
          type: 'Color',
          description: t.removedDescription,
          deprecated: true,
        ),
        PropertyCard(
          name: 'ThemeData.primaryColor / primaryColorLight / primaryColorDark',
          type: 'Color',
          description: t.primaryColorDescription,
          deprecated: true,
        ),
        PropertyCard(
          name: 'ThemeData.primarySwatch',
          type: 'MaterialColor',
          description: t.primarySwatchDescription,
          deprecated: true,
        ),

        SectionTitle(t.swatchScaleHeading, icon: Icons.gradient),
        _SwatchScale(swatch: s.primarySwatch),
      ],
    );
  }
}

/// A property card with a built-in color picker.
class _ColorProperty extends StatelessWidget {
  const _ColorProperty({
    required this.name,
    required this.description,
    required this.fallback,
    required this.value,
    required this.onChanged,
    required this.enabled,
    this.demo,
  });

  final String name;
  final String description;
  final String fallback;
  final Color value;
  final ValueChanged<Color> onChanged;
  final bool enabled;
  final Widget? demo;

  static const List<Color> _palette = <Color>[
    Color(0xFFFFFFFF),
    Color(0xFFF3F1F7),
    Color(0xFFE0E0E0),
    Color(0xFFBDBDBD),
    Color(0xFF757575),
    Color(0xFF37474F),
    Color(0xFF212121),
    Color(0xFF000000),
    Color(0xFFB00020),
    Color(0xFF00696D),
    Color(0xFF6750A4),
    Color(0xFFFF6D00),
  ];

  @override
  Widget build(BuildContext context) {
    return PropertyCard(
      name: 'ThemeData.$name',
      type: 'Color',
      description: description,
      defaultValue: fallback,
      currentValue: enabled
          ? hexOf(value)
          : LabStrings.of(context).legacyColors.notApplied,
      demo: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Opacity(
            opacity: enabled ? 1 : 0.4,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                for (final Color c in _palette)
                  GestureDetector(
                    onTap: enabled ? () => onChanged(c) : null,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: c,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: c.toARGB32() == value.toARGB32()
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outlineVariant,
                          width: c.toARGB32() == value.toARGB32() ? 3 : 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (demo != null) ...<Widget>[const SizedBox(height: 12), demo!],
        ],
      ),
    );
  }
}

/// The 10 shades of a [MaterialColor] — what a theme amounted to in M2.
class _SwatchScale extends StatelessWidget {
  const _SwatchScale({required this.swatch});
  final MaterialColor swatch;

  static const List<int> _shades = <int>[
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              LabStrings.of(context).legacyColors.swatchScaleBody,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                for (final int shade in _shades)
                  Expanded(
                    child: Container(
                      height: 56,
                      color: swatch[shade],
                      alignment: Alignment.center,
                      child: Text(
                        '$shade',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'monospace',
                          color: shade < 500 ? Colors.black87 : Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            const CodeBlock('''
// Reaching the scale
Colors.indigo            // shade 500
Colors.indigo[50]        // the lightest
Colors.indigo.shade900   // the darkest

// A MaterialColor of your own has to be written out in full:
const MaterialColor myBrand = MaterialColor(0xFF00696D, <int, Color>{
  50: Color(0xFFE0F2F1),
  100: Color(0xFFB2DFDB),
  // ... up to 900
});'''),
          ],
        ),
      ),
    );
  }
}
