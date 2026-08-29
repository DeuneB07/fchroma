import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/component_themes_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';
import '../widgets/widget_gallery.dart';

/// Page 7 — The *component themes*: one theme per widget family.
class ComponentThemesPage extends StatelessWidget {
  const ComponentThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final ComponentThemesStrings t = LabStrings.of(context).componentThemes;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SwitchListTile(
          title: Text(t.applySwitchTitle),
          subtitle: Text(t.applySwitchSubtitle),
          value: s.applyComponentThemes,
          onChanged: (bool v) => s.update(() => s.applyComponentThemes = v),
        ),

        SectionTitle(t.patternHeading, icon: Icons.pattern),
        const CodeBlock('''
ThemeData(
  // Each sub-theme sets the defaults for EVERY instance of that
  // widget in the app.
  cardTheme: CardThemeData(
    elevation: 1,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  // Buttons share the ButtonStyle API.
  // `styleFrom` is the convenient shortcut; ButtonStyle() is full control.
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
)'''),

        SectionTitle(t.widgetStateHeading, icon: Icons.mouse),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.widgetStateBody, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final String state in <String>[
                      'hovered',
                      'focused',
                      'pressed',
                      'dragged',
                      'selected',
                      'scrolledUnder',
                      'disabled',
                      'error',
                    ])
                      Chip(
                        label: Text(
                          'WidgetState.$state',
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                const CodeBlock('''
// A different colour depending on the widget's state
backgroundColor: WidgetStateProperty.resolveWith<Color>(
  (Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return colorScheme.onSurface.withValues(alpha: 0.12);
    }
    if (states.contains(WidgetState.pressed)) {
      return colorScheme.primaryContainer;
    }
    if (states.contains(WidgetState.hovered)) {
      return colorScheme.primary.withValues(alpha: 0.9);
    }
    return colorScheme.primary;   // the normal state
  },
),

// Shortcuts for the simple cases
WidgetStateProperty.all(Colors.red)          // always the same
WidgetStatePropertyAll<Color>(Colors.red)    // the const version'''),
                const SizedBox(height: 8),
                Text(t.widgetStateHint, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                const _StateDemoButton(),
              ],
            ),
          ),
        ),

        SectionTitle(t.catalogueHeading, icon: Icons.list_alt),
        const _ComponentThemeCatalog(),

        SectionTitle(t.liveHeading, icon: Icons.tune),
        PropertyCard(
          name: 'AppBarTheme.centerTitle',
          type: 'bool?',
          description: t.centerTitleDescription,
          defaultValue: t.centerTitleDefault,
          currentValue: '${s.appBarCenterTitle}',
          demo: Switch(
            value: s.appBarCenterTitle,
            onChanged: (bool v) => s.update(() => s.appBarCenterTitle = v),
          ),
        ),
        PropertyCard(
          name: 'AppBarTheme.elevation / scrolledUnderElevation',
          type: 'double?',
          description: t.elevationDescription,
          defaultValue: t.elevationDefault,
          currentValue: s.appBarElevation.toStringAsFixed(1),
          demo: Slider(
            value: s.appBarElevation,
            max: 12,
            divisions: 12,
            label: s.appBarElevation.toStringAsFixed(1),
            onChanged: (double v) => s.update(() => s.appBarElevation = v),
          ),
        ),

        SectionTitle(t.galleryHeading, icon: Icons.widgets),
        Text(
          t.galleryIntro,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: WidgetGallery(),
          ),
        ),
      ],
    );
  }
}

/// A button that prints the states it currently has active.
class _StateDemoButton extends StatefulWidget {
  const _StateDemoButton();

  @override
  State<_StateDemoButton> createState() => _StateDemoButtonState();
}

class _StateDemoButtonState extends State<_StateDemoButton> {
  Set<WidgetState> _states = <WidgetState>{};

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final ComponentThemesStrings t = LabStrings.of(context).componentThemes;

    return Row(
      children: <Widget>[
        FilledButton(
          onPressed: () {},
          style: ButtonStyle(
            // `resolveWith` receives the active states and returns the value.
            // We use the call to capture them and show them alongside.
            backgroundColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              // setState cannot be called during build, so we defer it to the
              // end of the frame.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !setEquals(states, _states)) {
                  setState(() => _states = <WidgetState>{...states});
                }
              });
              if (states.contains(WidgetState.pressed)) {
                return cs.tertiary;
              }
              if (states.contains(WidgetState.hovered)) {
                return cs.secondary;
              }
              return cs.primary;
            }),
          ),
          child: Text(t.hoverMeLabel),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            _states.isEmpty
                ? '{}  ${t.normalState}'
                : '{ ${_states.map((WidgetState e) => e.name).join(', ')} }',
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }

  /// Set comparison without depending on package:collection.
  static bool setEquals(Set<WidgetState> a, Set<WidgetState> b) =>
      a.length == b.length && a.containsAll(b);
}

/// A listing of the most-used component themes and what each one controls.
class _ComponentThemeCatalog extends StatelessWidget {
  const _ComponentThemeCatalog();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ComponentThemesStrings t = LabStrings.of(context).componentThemes;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              t.catalogueIntro,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            for (final ComponentThemeEntry e in t.catalogue)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: <Widget>[
                        Text(
                          e.property,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          e.type,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontFamily: 'monospace',
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Text(e.description, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
