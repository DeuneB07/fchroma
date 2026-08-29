import 'package:flutter/material.dart';

import '../../l10n/enum_labels.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/lab_strings.dart';
import '../../l10n/strings/transitions_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// Page 10 — Animation: route transitions and the theme's own.
class TransitionsPage extends StatelessWidget {
  const TransitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final TransitionsStrings t = LabStrings.of(context).transitions;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.routeHeading, icon: Icons.swipe),
        PropertyCard(
          name: 'ThemeData.pageTransitionsTheme',
          type: 'PageTransitionsTheme',
          description: t.routeDescription,
          defaultValue: t.routeDefault,
          currentValue: s.pageTransition.name,
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final PageTransitionKind k in PageTransitionKind.values)
                    ChoiceChip(
                      label: Text(k.label(AppLocalizations.of(context))),
                      selected: s.pageTransition == k,
                      onSelected: (_) => s.update(() => s.pageTransition = k),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext _) => const _DemoRoute(),
                  ),
                ),
                icon: const Icon(Icons.open_in_new),
                label: Text(t.navigateButton),
              ),
            ],
          ),
          tip: t.routeTip,
        ),
        const CodeBlock('''
ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      // iOS-style lateral slide, with the swipe-back gesture
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),

      // Zoom + fade: the Android standard since Material 3
      TargetPlatform.android: ZoomPageTransitionsBuilder(),

      // New in M3 expressive: a horizontal slide with a fade
      TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),

      // Hooks into the Android 14+ predictive back gesture
      TargetPlatform.linux: PredictiveBackPageTransitionsBuilder(),
    },
  ),
)'''),

        SectionTitle(t.themeAnimationHeading, icon: Icons.animation),
        PropertyCard(
          name: 'MaterialApp.themeAnimationDuration',
          type: 'Duration',
          description: t.durationDescription,
          defaultValue: t.durationDefault,
          currentValue: '${s.themeAnimationDuration.inMilliseconds} ms',
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider(
                value: s.themeAnimationDuration.inMilliseconds.toDouble(),
                max: 2000,
                divisions: 20,
                label: '${s.themeAnimationDuration.inMilliseconds} ms',
                onChanged: (double v) => s.update(
                  () => s.themeAnimationDuration = Duration(
                    milliseconds: v.round(),
                  ),
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: () => s.update(
                  () => s.themeMode = s.themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                ),
                icon: const Icon(Icons.brightness_6),
                label: Text(t.toggleButton),
              ),
            ],
          ),
          tip: t.durationTip,
        ),
        PropertyCard(
          name: 'MaterialApp.themeAnimationCurve',
          type: 'Curve',
          description: t.curveDescription,
          defaultValue: 'Curves.linear',
        ),
        PropertyCard(
          name: 'MaterialApp.themeAnimationStyle',
          type: 'AnimationStyle?',
          description: t.styleDescription,
        ),

        SectionTitle(t.lerpHeading, icon: Icons.auto_awesome_motion),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.lerpIntro, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                for (final LerpEntry entry in t.lerpEntries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DefinitionRow(
                      termWidth: 200,
                      term: Text(
                        entry.name,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      definition: Text(
                        entry.description,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        SectionTitle(t.accessibilityHeading, icon: Icons.accessibility_new),
        PropertyCard(
          name: 'MediaQuery.disableAnimationsOf(context)',
          type: 'bool',
          description: t.disableAnimationsDescription,
          tip: t.disableAnimationsTip,
        ),
      ],
    );
  }
}

/// Destination screen, so the enter and exit transitions can be seen.
class _DemoRoute extends StatelessWidget {
  const _DemoRoute();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TransitionsStrings t = LabStrings.of(context).transitions;

    return Scaffold(
      appBar: AppBar(title: Text(t.demoRouteTitle)),
      // This route has its own Scaffold, so it needs its own bottom inset:
      // the "Volver" button would otherwise sit under the navigation bar.
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.animation,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  t.demoRouteBody,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  t.demoRouteHint,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(t.backButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
