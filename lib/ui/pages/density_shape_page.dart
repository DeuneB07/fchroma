import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/density_shape_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// Page 8 — Density, shape, elevation and touch feedback.
class DensityShapePage extends StatelessWidget {
  const DensityShapePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final DensityShapeStrings t = LabStrings.of(context).densityShape;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.densityHeading, icon: Icons.compress),
        PropertyCard(
          name: 'ThemeData.visualDensity',
          type: 'VisualDensity',
          description: t.densityDescription,
          defaultValue: t.densityDefault,
          currentValue: s.adaptiveDensity
              ? 'adaptivePlatformDensity'
              : '(${s.densityHorizontal.toStringAsFixed(1)}, '
                    '${s.densityVertical.toStringAsFixed(1)})',
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t.adaptiveSwitchTitle),
                subtitle: Text(t.adaptiveSwitchSubtitle),
                value: s.adaptiveDensity,
                onChanged: (bool v) => s.update(() => s.adaptiveDensity = v),
              ),
              const SizedBox(height: 8),
              Text(t.axisHorizontal, style: theme.textTheme.labelSmall),
              Slider(
                value: s.densityHorizontal,
                min: -4,
                max: 4,
                divisions: 16,
                label: s.densityHorizontal.toStringAsFixed(1),
                onChanged: s.adaptiveDensity
                    ? null
                    : (double v) => s.update(() => s.densityHorizontal = v),
              ),
              Text(t.axisVertical, style: theme.textTheme.labelSmall),
              Slider(
                value: s.densityVertical,
                min: -4,
                max: 4,
                divisions: 16,
                label: s.densityVertical.toStringAsFixed(1),
                onChanged: s.adaptiveDensity
                    ? null
                    : (double v) => s.update(() => s.densityVertical = v),
              ),
              const SizedBox(height: 8),
              // Density-sensitive widgets, so the effect is visible.
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  ElevatedButton(onPressed: () {}, child: Text(t.demoButton)),
                  Checkbox(value: true, onChanged: (_) {}),
                  Chip(label: Text(t.demoChip)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
                ],
              ),
              ListTile(
                title: Text(t.listTileTitle),
                subtitle: Text(t.listTileSubtitle),
                leading: const Icon(Icons.list),
                onTap: () {},
              ),
            ],
          ),
          tip: t.densityTip,
        ),

        SectionTitle(t.tapTargetHeading, icon: Icons.touch_app),
        PropertyCard(
          name: 'ThemeData.materialTapTargetSize',
          type: 'MaterialTapTargetSize',
          description: t.tapTargetDescription,
          defaultValue: 'padded',
          currentValue: s.tapTargetSize.name,
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SegmentedButton<MaterialTapTargetSize>(
                segments: const <ButtonSegment<MaterialTapTargetSize>>[
                  ButtonSegment<MaterialTapTargetSize>(
                    value: MaterialTapTargetSize.padded,
                    label: Text('padded'),
                  ),
                  ButtonSegment<MaterialTapTargetSize>(
                    value: MaterialTapTargetSize.shrinkWrap,
                    label: Text('shrinkWrap'),
                  ),
                ],
                selected: <MaterialTapTargetSize>{s.tapTargetSize},
                onSelectionChanged: (Set<MaterialTapTargetSize> v) =>
                    s.update(() => s.tapTargetSize = v.first),
              ),
              const SizedBox(height: 12),
              // The borders reveal how much space each one reserves.
              Row(
                children: <Widget>[
                  for (int i = 0; i < 3; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Checkbox(value: i.isEven, onChanged: (_) {}),
                    ),
                ],
              ),
            ],
          ),
          tip: t.tapTargetTip,
        ),

        SectionTitle(t.shapeHeading, icon: Icons.rounded_corner),
        PropertyCard(
          name: t.shapeName,
          type: 'double → ShapeBorder',
          description: t.shapeDescription,
          currentValue: '${s.cornerRadius.toStringAsFixed(0)} px',
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider(
                value: s.cornerRadius,
                max: 32,
                divisions: 32,
                label: s.cornerRadius.toStringAsFixed(0),
                onChanged: (double v) => s.update(() => s.cornerRadius = v),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  FilledButton(onPressed: () {}, child: Text(t.demoButton)),
                  Chip(label: Text(t.demoChip)),
                  SizedBox(
                    width: 120,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          t.demoCard,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          tip: t.shapeTip,
        ),
        const CodeBlock('''
// Radii in one place, applied to each component theme
const double kRadiusSmall = 8;
const double kRadiusMedium = 16;
const double kRadiusLarge = 28;

ThemeData(
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusMedium),
    ),
  ),
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusLarge),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: const StadiumBorder(),   // a pill: the M3 default
    ),
  ),
)

// Other useful ShapeBorders:
//   StadiumBorder()                      a pill
//   CircleBorder()                       a perfect circle
//   ContinuousRectangleBorder(...)       iOS-style "squircle" corners
//   BeveledRectangleBorder(...)          chamfered corners
//   RoundedRectangleBorder(side: ...)    with a visible border'''),

        SectionTitle(t.elevationHeading, icon: Icons.layers),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.elevationBody, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    for (final double e in <double>[0, 1, 2, 3, 4, 6, 8, 12])
                      SizedBox(
                        width: 96,
                        child: Card(
                          elevation: e,
                          child: SizedBox(
                            height: 64,
                            child: Center(
                              child: Text(
                                'elev\n${e.toStringAsFixed(0)}',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                const CodeBlock('''
// To switch off the M3 tint and keep shadows only:
cardTheme: const CardThemeData(surfaceTintColor: Colors.transparent),

// The 6 canonical elevation levels in Material 3:
//   0 dp  flat surfaces: Scaffold, AppBar at rest
//   1 dp  Card, components at rest
//   3 dp  AppBar with content beneath, menus, FAB
//   6 dp  dialogs, pressed FAB
//   8 dp  navigation drawer
//  12 dp  dragged elements'''),
              ],
            ),
          ),
        ),

        SectionTitle(t.splashHeading, icon: Icons.water_drop),
        PropertyCard(
          name: 'ThemeData.splashFactory',
          type: 'InteractiveInkFeatureFactory',
          description: t.splashDescription,
          defaultValue: t.splashDefault,
          currentValue: s.splash.name,
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final SplashKind k in SplashKind.values)
                    ChoiceChip(
                      label: Text(k.name),
                      selected: s.splash == k,
                      onSelected: (_) => s.update(() => s.splash = k),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(t.splashHint, style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
              Material(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        t.splashZone,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          tip: t.splashTip,
        ),

        SectionTitle(t.platformHeading, icon: Icons.devices),
        PropertyCard(
          name: 'ThemeData.platform',
          type: 'TargetPlatform',
          description: t.platformDescription,
          defaultValue: 'defaultTargetPlatform',
        ),
        PropertyCard(
          name: 'ThemeData.adaptations',
          type: 'Iterable<Adaptation<Object>>',
          description: t.adaptationsDescription,
          defaultValue: '[]',
        ),
        PropertyCard(
          name: 'ThemeData.cupertinoOverrideTheme',
          type: 'NoDefaultCupertinoThemeData?',
          description: t.cupertinoOverrideDescription,
        ),
        PropertyCard(
          name: 'ThemeData.scrollbarTheme',
          type: 'ScrollbarThemeData',
          description: t.scrollbarDescription,
        ),
      ],
    );
  }
}
