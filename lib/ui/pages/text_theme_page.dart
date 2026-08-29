import 'package:flutter/material.dart';

import '../../l10n/enum_labels.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/lab_strings.dart';
import '../../l10n/strings/text_theme_strings.dart';
import '../../state/theme_lab_state.dart';
import '../../theme/text_theme_presets.dart';
import '../widgets/lab_widgets.dart';

/// Page 4 — [TextTheme]: the app's 15 named styles.
class TextThemePage extends StatelessWidget {
  const TextThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final TextTheme tt = theme.textTheme;
    final TextThemeStrings t = LabStrings.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.familiesHeading, icon: Icons.category),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < t.families.length; i++)
                  _FamilyRow(
                    family: t.families[i],
                    isLast: i == t.families.length - 1,
                  ),
              ],
            ),
          ),
        ),

        SectionTitle(t.rolesLiveHeading, icon: Icons.text_fields),
        Text(
          t.rolesLiveIntro,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: <Widget>[
                for (final TextRoleInfo role in kTextRoles)
                  _RoleSample(role: role, style: role.style(tt)),
              ],
            ),
          ),
        ),

        SectionTitle(t.presetsHeading, icon: Icons.tune),
        PropertyCard(
          name: 'ThemeData.textTheme',
          type: 'TextTheme',
          description: t.textThemeDescription,
          currentValue: s.textPreset.name,
          demo: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final TextThemePreset p in TextThemePreset.values)
                ChoiceChip(
                  label: Text(p.label(AppLocalizations.of(context))),
                  selected: s.textPreset == p,
                  onSelected: (_) => s.update(() => s.textPreset = p),
                ),
            ],
          ),
        ),

        SectionTitle(t.transformHeading, icon: Icons.transform),
        PropertyCard(
          name: 'TextTheme.apply()',
          type: 'TextTheme Function({...})',
          description: t.applyDescription,
          tip: t.applyTip,
        ),
        const CodeBlock('''
// Scale the whole type scale by 15 %
textTheme: baseTextTheme.apply(fontSizeFactor: 1.15),

// Change the family of every style
textTheme: baseTextTheme.apply(fontFamily: 'monospace'),

// Recolour (mind the body / display distinction)
textTheme: baseTextTheme.apply(
  bodyColor: colorScheme.onSurface,
  displayColor: colorScheme.primary,
),

// Override one specific role: copyWith, not apply
textTheme: baseTextTheme.copyWith(
  titleLarge: baseTextTheme.titleLarge?.copyWith(
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  ),
),'''),

        PropertyCard(
          name: 'fontSizeFactor',
          type: 'double',
          description: t.sizeFactorDescription,
          currentValue: '×${s.fontSizeScale.toStringAsFixed(2)}',
          demo: Slider(
            value: s.fontSizeScale,
            min: 0.7,
            max: 1.6,
            divisions: 18,
            label: '×${s.fontSizeScale.toStringAsFixed(2)}',
            onChanged: (double v) => s.update(() => s.fontSizeScale = v),
          ),
          tip: t.sizeFactorTip,
        ),
        PropertyCard(
          name: 'TextStyle.letterSpacing',
          type: 'double',
          description: t.letterSpacingDescription,
          currentValue:
              '${s.letterSpacingDelta >= 0 ? '+' : ''}'
              '${s.letterSpacingDelta.toStringAsFixed(2)} px',
          demo: Slider(
            value: s.letterSpacingDelta,
            min: -1,
            max: 3,
            divisions: 16,
            onChanged: (double v) => s.update(() => s.letterSpacingDelta = v),
          ),
        ),
        PropertyCard(
          name: 'TextStyle.height',
          type: 'double',
          description: t.lineHeightDescription,
          currentValue: '×${s.lineHeightScale.toStringAsFixed(2)}',
          demo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider(
                value: s.lineHeightScale,
                min: 0.8,
                max: 2.0,
                divisions: 12,
                onChanged: (double v) => s.update(() => s.lineHeightScale = v),
              ),
              Text(t.lineHeightSample, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
        PropertyCard(
          name: 'TextStyle.fontWeight',
          type: 'FontWeight',
          description: t.fontWeightDescription,
          currentValue: 'w${kFontWeights[s.titleFontWeightIndex].value}',
          demo: Slider(
            value: s.titleFontWeightIndex.toDouble(),
            min: 0,
            max: 8,
            divisions: 8,
            label: 'w${kFontWeights[s.titleFontWeightIndex].value}',
            onChanged: (double v) =>
                s.update(() => s.titleFontWeightIndex = v.round()),
          ),
          tip: t.fontWeightTip,
        ),

        SectionTitle(t.migrationHeading, icon: Icons.swap_horiz),
        const _NameMigrationTable(),

        SectionTitle(t.whoUsesHeading, icon: Icons.widgets_outlined),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final TextRoleInfo role in kTextRoles)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DefinitionRow(
                      termWidth: 140,
                      term: Text(
                        role.name,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      definition: Text(
                        t.usedBy(role.id),
                        style: theme.textTheme.bodySmall,
                      ),
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

/// A row rendering a role in its own style, plus its metrics.
class _RoleSample extends StatelessWidget {
  const _RoleSample({required this.role, required this.style});

  final TextRoleInfo role;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                role.name,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: 'monospace',
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _metrics(style),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Here is the point of the whole page: the text is painted in ITS
          // own style.
          //
          // displayLarge is 57 px, and at maximum scale it passes 90. It does
          // not fit in a narrow column, so we ellipsize instead of letting it
          // spill past the edge.
          Text(
            'Aa Bb Cc — 0123',
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
        ],
      ),
    );
  }

  /// A readable summary of the [TextStyle]'s metrics.
  static String _metrics(TextStyle? s) {
    if (s == null) {
      return 'null';
    }
    final List<String> parts = <String>[
      if (s.fontSize != null) '${s.fontSize!.toStringAsFixed(1)} px',
      // FontWeight.value gives the number directly (400, 700...). The old
      // `index` (0..8) was deprecated because it cannot express intermediate
      // weights.
      if (s.fontWeight != null) 'w${s.fontWeight!.value}',
      if (s.height != null) 'height ${s.height!.toStringAsFixed(2)}',
      if (s.letterSpacing != null)
        'spacing ${s.letterSpacing!.toStringAsFixed(2)}',
      if (s.fontFamily != null) s.fontFamily!,
    ];
    return parts.join('  ·  ');
  }
}

class _FamilyRow extends StatelessWidget {
  const _FamilyRow({required this.family, this.isLast = false});

  final TextFamily family;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Wrap, not Row: "headline Large / Medium / Small" plus its sizes is
          // wider than a phone, and a Row has no way to break the line.
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(
                '${family.name} Large / Medium / Small',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                family.sizes,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(family.purpose, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// The table you need when migrating old code.
class _NameMigrationTable extends StatelessWidget {
  const _NameMigrationTable();

  static const List<(String, String)> _pairs = <(String, String)>[
    ('headline1', 'displayLarge'),
    ('headline2', 'displayMedium'),
    ('headline3', 'displaySmall'),
    ('headline4', 'headlineMedium'),
    ('headline5', 'headlineSmall'),
    ('headline6', 'titleLarge'),
    ('subtitle1', 'titleMedium'),
    ('subtitle2', 'titleSmall'),
    ('bodyText1', 'bodyLarge'),
    ('bodyText2', 'bodyMedium'),
    ('caption', 'bodySmall'),
    ('button', 'labelLarge'),
    ('overline', 'labelSmall'),
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
              LabStrings.of(context).textTheme.migrationBody,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: <Widget>[
                for (final (String old, String modern) pair in _pairs)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          pair.$1,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            decoration: TextDecoration.lineThrough,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Icon(Icons.arrow_right_alt, size: 16),
                        Text(
                          pair.$2,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
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
