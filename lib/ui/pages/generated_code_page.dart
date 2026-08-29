import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/generated_code_strings.dart';
import '../../state/theme_lab_state.dart';
import '../../theme/theme_code_generator.dart';
import '../widgets/lab_widgets.dart';

/// Page 11 — The Dart source of the theme you have built.
class GeneratedCodePage extends StatelessWidget {
  const GeneratedCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final GeneratedCodeStrings t = LabStrings.of(context).generatedCode;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.generatedHeading, icon: Icons.download),
        CodeBlock(ThemeCodeGenerator.generate(s), label: 'app_theme.dart'),

        SectionTitle(t.howToUseHeading, icon: Icons.play_arrow),
        const CodeBlock('''
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The SAME function for both, changing only the brightness:
      // light and dark then share an identical structure and the
      // animation between them stays clean.
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}''', label: 'main.dart'),

        SectionTitle(t.structureHeading, icon: Icons.folder_open),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.structureIntro, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                CodeBlock('''
lib/
  theme/
    app_theme.dart        # buildAppTheme(Brightness) -> ThemeData
    app_colors.dart       # the seeds and brand colours
    app_typography.dart   # the TextTheme and its transformations
    app_shapes.dart       # reusable radii and ShapeBorders
    extensions/
      brand_theme.dart    # your ThemeExtensions
  main.dart''', label: t.structureLabel),
                const SizedBox(height: 8),
                Text(
                  t.closingRule,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),

        SectionTitle(t.checklistHeading, icon: Icons.checklist_rtl),
        const _Checklist(),

        SectionTitle(t.toolsHeading, icon: Icons.build),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final ToolEntry tool in t.tools)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tool.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          tool.description,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Checklist extends StatefulWidget {
  const _Checklist();

  @override
  State<_Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<_Checklist> {
  final Set<int> _checked = <int>{};

  @override
  Widget build(BuildContext context) {
    final List<String> items = LabStrings.of(context).generatedCode.checklist;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < items.length; i++)
              CheckboxListTile(
                value: _checked.contains(i),
                onChanged: (bool? v) => setState(() {
                  if (v ?? false) {
                    _checked.add(i);
                  } else {
                    _checked.remove(i);
                  }
                }),
                title: Text(
                  items[i],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
          ],
        ),
      ),
    );
  }
}
