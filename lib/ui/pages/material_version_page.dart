import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/material_version_strings.dart';
import '../../state/theme_lab_state.dart';
import '../../theme/app_theme_builder.dart';
import '../widgets/lab_widgets.dart';
import '../widgets/widget_gallery.dart';

/// Page 2 — Material 2 against Material 3, on the same configuration.
///
/// The technique: build TWO [ThemeData]s from the same state, one with
/// `useMaterial3: false` and one with `true`, then wrap the same showcase in a
/// different [Theme]. Every difference you see comes from that single flag.
class MaterialVersionPage extends StatelessWidget {
  const MaterialVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final MaterialVersionStrings t = LabStrings.of(context).materialVersion;
    final Brightness brightness = theme.brightness;

    // Same state, same function; only the version override differs. Every
    // difference between the two columns is caused by that boolean.
    final ThemeData m2 = AppThemeBuilder.build(
      s,
      brightness,
      materialVersionOverride: false,
    );
    final ThemeData m3 = AppThemeBuilder.build(
      s,
      brightness,
      materialVersionOverride: true,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool sideBySide = constraints.maxWidth > 900;

        return ListView(
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

            PropertyCard(
              name: 'ThemeData.useMaterial3',
              type: 'bool',
              description: t.useMaterial3Description,
              defaultValue: 'true',
              currentValue: '${s.useMaterial3}',
              demo: SegmentedButton<bool>(
                segments: <ButtonSegment<bool>>[
                  ButtonSegment<bool>(value: false, label: Text(t.columnM2)),
                  ButtonSegment<bool>(value: true, label: Text(t.columnM3)),
                ],
                selected: <bool>{s.useMaterial3},
                onSelectionChanged: (Set<bool> v) =>
                    s.update(() => s.useMaterial3 = v.first),
              ),
              tip: t.useMaterial3Tip,
            ),

            SectionTitle(t.differencesHeading, icon: Icons.compare_arrows),
            const _DifferenceTable(),

            SectionTitle(t.sideBySideHeading, icon: Icons.view_column),
            Text(
              t.sideBySideIntro,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            if (sideBySide)
              Row(
                // `start` lets each panel keep its natural height instead of
                // stretching. IntrinsicHeight is avoided on purpose: it forces
                // a second measuring pass over the whole subtree, and some
                // widgets (sliders, text fields) cannot report an intrinsic
                // height at all.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _ThemedPanel(title: t.columnM2, data: m2),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ThemedPanel(title: t.columnM3, data: m3),
                  ),
                ],
              )
            else
              Column(
                children: <Widget>[
                  _ThemedPanel(title: t.columnM2, data: m2),
                  const SizedBox(height: 16),
                  _ThemedPanel(title: t.columnM3, data: m3),
                ],
              ),

            SectionTitle(t.migrationHeading, icon: Icons.upgrade),
            const CodeBlock('''
// BEFORE (Material 2)
ThemeData(
  primarySwatch: Colors.indigo,     // a 10-shade scale
  accentColor: Colors.orange,       // removed from the SDK
  backgroundColor: Colors.white,    // removed from the SDK
  textTheme: TextTheme(
    headline6: TextStyle(...),      // old names, gone now
    bodyText2: TextStyle(...),
  ),
)

// AFTER (Material 3)
ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,       // a single input colour
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(...),     // headline6 -> titleLarge
    bodyMedium: TextStyle(...),     // bodyText2 -> bodyMedium
  ),
)'''),

            PropertyCard(
              name: 'ThemeData.applyElevationOverlayColor',
              type: 'bool',
              description: t.elevationOverlayDescription,
              defaultValue: 'false',
              deprecated: true,
            ),
          ],
        );
      },
    );
  }
}

/// A panel carrying its own [Theme], with the showcase inside.
class _ThemedPanel extends StatelessWidget {
  const _ThemedPanel({required this.title, required this.data});

  final String title;
  final ThemeData data;

  @override
  Widget build(BuildContext context) {
    // `Theme` replaces the ThemeData for everything hanging below it. Any
    // `Theme.of(context)` inside `child` will return `data`.
    return Theme(
      data: data,
      child: Builder(
        // The Builder is essential: we need a context that sits BELOW the
        // Theme we just created. Without it, Theme.of(context) would return
        // the app's theme.
        builder: (BuildContext innerContext) {
          final ThemeData t = Theme.of(innerContext);
          return Container(
            decoration: BoxDecoration(
              color: t.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: t.colorScheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // A real AppBar, so the bar differences are visible.
                AppBar(
                  title: Text(title),
                  primary: false,
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: WidgetGallery(compact: true),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Table of concrete differences between the two versions.
class _DifferenceTable extends StatelessWidget {
  const _DifferenceTable();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MaterialVersionStrings t = LabStrings.of(context).materialVersion;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          // DataTable reads dividerColor, dataTextStyle and headingTextStyle
          // from the theme (or from ThemeData.dataTableTheme if you set it).
          columns: <DataColumn>[
            DataColumn(label: Text(t.columnAspect)),
            DataColumn(label: Text(t.columnM2)),
            DataColumn(label: Text(t.columnM3)),
          ],
          rows: <DataRow>[
            for (final VersionDifference row in t.differences)
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(
                      row.aspect,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 260),
                      child: Text(row.m2, style: theme.textTheme.bodySmall),
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text(
                        row.m3,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
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
