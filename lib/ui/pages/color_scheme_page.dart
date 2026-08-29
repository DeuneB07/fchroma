import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/color_scheme_strings.dart';
import '../../state/theme_lab_state.dart';
import '../widgets/lab_widgets.dart';

/// Page 3 — The complete [ColorScheme]: Material 3's 45 roles.
class ColorSchemePage extends StatelessWidget {
  const ColorSchemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final ColorSchemeStrings t = LabStrings.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        PageHeader(badge: t.badge, title: t.title, subtitle: t.subtitle),

        SectionTitle(t.generationHeading, icon: Icons.auto_awesome),
        PropertyCard(
          name: 'ColorScheme.fromSeed(seedColor:)',
          type: 'Color',
          description: t.seedDescription,
          currentValue: hexOf(s.seedColor),
          demo: _SeedPicker(state: s),
        ),
        PropertyCard(
          name: 'ColorScheme.fromSeed(dynamicSchemeVariant:)',
          type: 'DynamicSchemeVariant',
          description: t.variantDescription,
          defaultValue: 'tonalSpot',
          currentValue: s.schemeVariant.name,
          demo: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final DynamicSchemeVariant v in DynamicSchemeVariant.values)
                ChoiceChip(
                  label: Text(v.name),
                  selected: s.schemeVariant == v,
                  onSelected: (_) => s.update(() => s.schemeVariant = v),
                ),
            ],
          ),
          tip: t.variantTip,
        ),
        PropertyCard(
          name: 'ColorScheme.fromSeed(contrastLevel:)',
          type: 'double',
          description: t.contrastDescription,
          defaultValue: '0.0',
          currentValue: s.contrastLevel.toStringAsFixed(2),
          demo: Slider(
            value: s.contrastLevel,
            min: -1,
            max: 1,
            divisions: 8,
            label: s.contrastLevel.toStringAsFixed(2),
            onChanged: (double v) => s.update(() => s.contrastLevel = v),
          ),
          tip: t.contrastTip,
        ),

        SectionTitle(t.pairingHeading, icon: Icons.contrast),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.pairingBody, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
                const CodeBlock('''
Container(
  color: colorScheme.primaryContainer,
  child: Text(
    'Always legible',
    style: TextStyle(color: colorScheme.onPrimaryContainer),
  ),
)'''),
              ],
            ),
          ),
        ),

        // ── The role groups ─────────────────────────────────────────────
        //
        // The role NAMES are hardcoded here rather than translated: they are
        // the actual `ColorScheme` member names, and being able to search for
        // them in the Flutter source is the point of the page. Only the usage
        // note next to each one comes from the strings file.
        SectionTitle(t.primaryHeading, icon: Icons.looks_one),
        _RoleGroup(
          description: t.primaryGroupDescription,
          roles: <_Role>[
            _Role('primary', cs.primary, cs.onPrimary, t.rolePrimary),
            _Role('onPrimary', cs.onPrimary, cs.primary, t.roleOnPrimary),
            _Role(
              'primaryContainer',
              cs.primaryContainer,
              cs.onPrimaryContainer,
              t.rolePrimaryContainer,
            ),
            _Role(
              'onPrimaryContainer',
              cs.onPrimaryContainer,
              cs.primaryContainer,
              t.roleOnPrimaryContainer,
            ),
            _Role(
              'primaryFixed',
              cs.primaryFixed,
              cs.onPrimaryFixed,
              t.rolePrimaryFixed,
            ),
            _Role(
              'primaryFixedDim',
              cs.primaryFixedDim,
              cs.onPrimaryFixed,
              t.rolePrimaryFixedDim,
            ),
            _Role(
              'onPrimaryFixed',
              cs.onPrimaryFixed,
              cs.primaryFixed,
              t.roleOnPrimaryFixed,
            ),
            _Role(
              'onPrimaryFixedVariant',
              cs.onPrimaryFixedVariant,
              cs.primaryFixed,
              t.roleOnPrimaryFixedVariant,
            ),
            _Role(
              'inversePrimary',
              cs.inversePrimary,
              cs.inverseSurface,
              t.roleInversePrimary,
            ),
          ],
        ),

        SectionTitle(t.secondaryHeading, icon: Icons.looks_two),
        _RoleGroup(
          description: t.secondaryGroupDescription,
          roles: <_Role>[
            _Role('secondary', cs.secondary, cs.onSecondary, t.roleSecondary),
            _Role(
              'onSecondary',
              cs.onSecondary,
              cs.secondary,
              t.roleOnSecondary,
            ),
            _Role(
              'secondaryContainer',
              cs.secondaryContainer,
              cs.onSecondaryContainer,
              t.roleSecondaryContainer,
            ),
            _Role(
              'onSecondaryContainer',
              cs.onSecondaryContainer,
              cs.secondaryContainer,
              t.roleOnSecondaryContainer,
            ),
            _Role(
              'secondaryFixed',
              cs.secondaryFixed,
              cs.onSecondaryFixed,
              t.roleSecondaryFixed,
            ),
            _Role(
              'secondaryFixedDim',
              cs.secondaryFixedDim,
              cs.onSecondaryFixed,
              t.roleSecondaryFixedDim,
            ),
            _Role(
              'onSecondaryFixed',
              cs.onSecondaryFixed,
              cs.secondaryFixed,
              t.roleOnSecondaryFixed,
            ),
            _Role(
              'onSecondaryFixedVariant',
              cs.onSecondaryFixedVariant,
              cs.secondaryFixed,
              t.roleOnSecondaryFixedVariant,
            ),
          ],
        ),

        SectionTitle(t.tertiaryHeading, icon: Icons.looks_3),
        _RoleGroup(
          description: t.tertiaryGroupDescription,
          roles: <_Role>[
            _Role('tertiary', cs.tertiary, cs.onTertiary, t.roleTertiary),
            _Role('onTertiary', cs.onTertiary, cs.tertiary, t.roleOnTertiary),
            _Role(
              'tertiaryContainer',
              cs.tertiaryContainer,
              cs.onTertiaryContainer,
              t.roleTertiaryContainer,
            ),
            _Role(
              'onTertiaryContainer',
              cs.onTertiaryContainer,
              cs.tertiaryContainer,
              t.roleOnTertiaryContainer,
            ),
            _Role(
              'tertiaryFixed',
              cs.tertiaryFixed,
              cs.onTertiaryFixed,
              t.roleTertiaryFixed,
            ),
            _Role(
              'tertiaryFixedDim',
              cs.tertiaryFixedDim,
              cs.onTertiaryFixed,
              t.roleTertiaryFixedDim,
            ),
            _Role(
              'onTertiaryFixed',
              cs.onTertiaryFixed,
              cs.tertiaryFixed,
              t.roleOnTertiaryFixed,
            ),
            _Role(
              'onTertiaryFixedVariant',
              cs.onTertiaryFixedVariant,
              cs.tertiaryFixed,
              t.roleOnTertiaryFixedVariant,
            ),
          ],
        ),

        SectionTitle(t.errorHeading, icon: Icons.error_outline),
        _RoleGroup(
          description: t.errorGroupDescription,
          roles: <_Role>[
            _Role('error', cs.error, cs.onError, t.roleError),
            _Role('onError', cs.onError, cs.error, t.roleOnError),
            _Role(
              'errorContainer',
              cs.errorContainer,
              cs.onErrorContainer,
              t.roleErrorContainer,
            ),
            _Role(
              'onErrorContainer',
              cs.onErrorContainer,
              cs.errorContainer,
              t.roleOnErrorContainer,
            ),
          ],
        ),

        SectionTitle(t.surfacesHeading, icon: Icons.layers),
        _RoleGroup(
          description: t.surfacesGroupDescription,
          roles: <_Role>[
            _Role('surface', cs.surface, cs.onSurface, t.roleSurface),
            _Role('onSurface', cs.onSurface, cs.surface, t.roleOnSurface),
            _Role(
              'onSurfaceVariant',
              cs.onSurfaceVariant,
              cs.surface,
              t.roleOnSurfaceVariant,
            ),
            _Role('surfaceDim', cs.surfaceDim, cs.onSurface, t.roleSurfaceDim),
            _Role(
              'surfaceBright',
              cs.surfaceBright,
              cs.onSurface,
              t.roleSurfaceBright,
            ),
            _Role(
              'surfaceContainerLowest',
              cs.surfaceContainerLowest,
              cs.onSurface,
              t.roleSurfaceContainerLowest,
            ),
            _Role(
              'surfaceContainerLow',
              cs.surfaceContainerLow,
              cs.onSurface,
              t.roleSurfaceContainerLow,
            ),
            _Role(
              'surfaceContainer',
              cs.surfaceContainer,
              cs.onSurface,
              t.roleSurfaceContainer,
            ),
            _Role(
              'surfaceContainerHigh',
              cs.surfaceContainerHigh,
              cs.onSurface,
              t.roleSurfaceContainerHigh,
            ),
            _Role(
              'surfaceContainerHighest',
              cs.surfaceContainerHighest,
              cs.onSurface,
              t.roleSurfaceContainerHighest,
            ),
            _Role(
              'surfaceTint',
              cs.surfaceTint,
              cs.onSurface,
              t.roleSurfaceTint,
            ),
            _Role(
              'inverseSurface',
              cs.inverseSurface,
              cs.onInverseSurface,
              t.roleInverseSurface,
            ),
            _Role(
              'onInverseSurface',
              cs.onInverseSurface,
              cs.inverseSurface,
              t.roleOnInverseSurface,
            ),
          ],
        ),

        SectionTitle(t.outlinesHeading, icon: Icons.border_style),
        _RoleGroup(
          description: t.outlinesGroupDescription,
          roles: <_Role>[
            _Role('outline', cs.outline, cs.surface, t.roleOutline),
            _Role(
              'outlineVariant',
              cs.outlineVariant,
              cs.onSurface,
              t.roleOutlineVariant,
            ),
            _Role('shadow', cs.shadow, Colors.white, t.roleShadow),
            _Role('scrim', cs.scrim, Colors.white, t.roleScrim),
          ],
        ),

        SectionTitle(t.retiredHeading, icon: Icons.delete_outline),
        PropertyCard(
          name: 'background / onBackground / surfaceVariant',
          type: 'Color',
          description: t.retiredDescription,
          deprecated: true,
        ),

        SectionTitle(t.codeHeading, icon: Icons.code),
        CodeBlock(_schemeCode(s)),
      ],
    );
  }

  static String _schemeCode(ThemeLabState s) {
    return switch (s.colorSource) {
      ColorSchemeSource.seed =>
        '''
colorScheme: ColorScheme.fromSeed(
  seedColor: Color(${hexOf(s.seedColor)}),
  brightness: Brightness.light,
  dynamicSchemeVariant: DynamicSchemeVariant.${s.schemeVariant.name},
  contrastLevel: ${s.contrastLevel.toStringAsFixed(2)},
),''',
      ColorSchemeSource.swatch =>
        '''
// Material 2 style: a MaterialColor of 10 shades (50..900).
colorScheme: ColorScheme.fromSwatch(
  primarySwatch: Colors.indigo,
  brightness: Brightness.light,
),''',
      ColorSchemeSource.baseline =>
        '''
// Material 3's factory palette.
colorScheme: const ColorScheme.light(),''',
      ColorSchemeSource.manual =>
        '''
// Start from a seed and override only the brand roles: that way
// you never write all 45 and the contrasts are preserved.
colorScheme: ColorScheme.fromSeed(
  seedColor: Color(${hexOf(s.manualPrimary)}),
).copyWith(
  primary: Color(${hexOf(s.manualPrimary)}),
  secondary: Color(${hexOf(s.manualSecondary)}),
  tertiary: Color(${hexOf(s.manualTertiary)}),
  error: Color(${hexOf(s.manualError)}),
),''',
    };
  }
}

/// One role with its color and a usage note.
class _Role {
  const _Role(this.name, this.color, this.onColor, this.usage);
  final String name;
  final Color color;
  final Color onColor;
  final String usage;
}

class _RoleGroup extends StatelessWidget {
  const _RoleGroup({required this.description, required this.roles});

  final String description;
  final List<_Role> roles;

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
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                for (final _Role role in roles)
                  ColorRoleSwatch(
                    name: role.name,
                    color: role.color,
                    onColor: role.onColor,
                    usage: role.usage,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Seed-color picker built from Material's palette.
class _SeedPicker extends StatelessWidget {
  const _SeedPicker({required this.state});
  final ThemeLabState state;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (final MaterialColor color in Colors.primaries)
          _SeedDot(
            color: color,
            selected: state.seedColor.toARGB32() == color.toARGB32(),
            onTap: () => state.update(() => state.seedColor = color),
          ),
      ],
    );
  }
}

class _SeedDot extends StatelessWidget {
  const _SeedDot({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
            width: 3,
          ),
        ),
        child: selected
            ? Icon(
                Icons.check,
                size: 16,
                color: color.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              )
            : null,
      ),
    );
  }
}
