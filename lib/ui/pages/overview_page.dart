import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/overview_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// Page 1 — What a theme is and how Flutter decides every pixel.
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final OverviewStrings t = LabStrings.of(context).overview;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.colorJourneyHeading, icon: Icons.route),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.colorJourneyIntro, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16),
                // The `code` values stay untranslated: they are API
                // identifiers, and finding them in the Flutter source is the
                // point of showing them.
                _PriorityStep(
                  order: 1,
                  title: t.step1Title,
                  code: 'ElevatedButton(style: ButtonStyle(...))',
                  detail: t.step1Detail,
                ),
                _PriorityStep(
                  order: 2,
                  title: t.step2Title,
                  code: 'ThemeData.elevatedButtonTheme',
                  detail: t.step2Detail,
                ),
                _PriorityStep(
                  order: 3,
                  title: t.step3Title,
                  code: 'ThemeData.colorScheme.primary',
                  detail: t.step3Detail,
                ),
                _PriorityStep(
                  order: 4,
                  title: t.step4Title,
                  code: '_ElevatedButtonDefaultsM3',
                  detail: t.step4Detail,
                  isLast: true,
                ),
              ],
            ),
          ),
        ),

        SectionTitle(t.readingHeading, icon: Icons.code),
        const CodeBlock('''
// The whole theme. This subscribes the widget: if the theme
// changes, this build() runs again automatically.
final ThemeData theme = Theme.of(context);

// The three lookups you will use 95 % of the time:
theme.colorScheme.primary        // semantic colour
theme.textTheme.titleLarge       // semantic text style
theme.colorScheme.onSurface      // text colour over the background

// NEVER do this: it breaks dark mode and rebranding.
const Color red = Color(0xFFFF0000);'''),

        SectionTitle(t.threeLevelsHeading, icon: Icons.layers),
        PropertyCard(
          name: 'MaterialApp.theme',
          type: 'ThemeData?',
          description: t.themeDescription,
          defaultValue: 'ThemeData.light()',
        ),
        PropertyCard(
          name: 'MaterialApp.darkTheme',
          type: 'ThemeData?',
          description: t.darkThemeDescription,
          defaultValue: 'null',
          tip: t.darkThemeTip,
        ),
        PropertyCard(
          name: 'MaterialApp.themeMode',
          type: 'ThemeMode',
          description: t.themeModeDescription,
          defaultValue: 'ThemeMode.system',
          currentValue: s.themeMode.name,
          demo: SegmentedButton<ThemeMode>(
            segments: const <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                value: ThemeMode.light,
                label: Text('light'),
                icon: Icon(Icons.light_mode),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.system,
                label: Text('system'),
                icon: Icon(Icons.brightness_auto),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.dark,
                label: Text('dark'),
                icon: Icon(Icons.dark_mode),
              ),
            ],
            selected: <ThemeMode>{s.themeMode},
            onSelectionChanged: (Set<ThemeMode> value) =>
                s.update(() => s.themeMode = value.first),
          ),
        ),
        PropertyCard(
          name: 'Theme(data: ..., child: ...)',
          type: 'Widget',
          description: t.nestedThemeDescription,
          tip: t.nestedThemeTip,
        ),

        SectionTitle(t.nestedLiveHeading, icon: Icons.account_tree),
        Row(
          children: <Widget>[
            Expanded(child: _MiniCard(label: t.appThemeLabel)),
            const SizedBox(width: 12),
            Expanded(
              child: Theme(
                // A real local-override example: force the opposite
                // brightness, starting from the current ColorScheme.
                data: theme.copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: theme.colorScheme.primary,
                    brightness: theme.brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark,
                  ),
                ),
                child: _MiniCard(label: t.nestedThemeLabel),
              ),
            ),
          ],
        ),

        SectionTitle(t.pitfallsHeading, icon: Icons.warning_amber),
        PropertyCard(
          name: t.pitfallContextName,
          type: 'error',
          description: t.pitfallContextDescription,
        ),
        PropertyCard(
          name: 'ThemeData.copyWith(useMaterial3: true)',
          type: 'error',
          description: t.pitfallCopyWithDescription,
          deprecated: true,
        ),
      ],
    );
  }
}

class _PriorityStep extends StatelessWidget {
  const _PriorityStep({
    required this.order,
    required this.title,
    required this.code,
    required this.detail,
    this.isLast = false,
  });

  final int order;
  final String title;
  final String code;
  final String detail;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              CircleAvatar(
                radius: 14,
                backgroundColor: cs.primary,
                child: Text(
                  '$order',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(child: VerticalDivider(color: cs.outlineVariant)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    code,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    detail,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final OverviewStrings t = LabStrings.of(context).overview;
    return Material(
      // `surface` is the background of surfaces. Inside a nested Theme() it is
      // worth something different from the rest of the app.
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            FilledButton(onPressed: () {}, child: Text(t.miniCardAction)),
            const SizedBox(height: 8),
            Text(
              t.miniCardSurfaceText,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
