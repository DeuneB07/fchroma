import 'package:flutter/material.dart';

import '../l10n/enum_labels.dart';
import '../l10n/generated/app_localizations.dart';
import '../state/theme_lab_state.dart';
import '../theme/text_theme_presets.dart' show kFontWeights;

/// Global control panel: the switches that rebuild the theme.
///
/// It lives INSIDE the themed tree on purpose: the panel restyles itself with
/// every change, which is the best possible demonstration.
class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      // `Drawer` does not apply a SafeArea of its own (unlike
      // `NavigationDrawer`, which does), so in the endDrawer this panel runs
      // the full height of the screen — header under the status bar, last
      // slider under the navigation bar and unreachable.
      //
      // Nesting is safe: SafeArea removes the padding it consumed from the
      // MediaQuery it passes down, so when this panel is pinned inside the
      // already-padded Row it adds nothing.
      child: SafeArea(
        child: Column(
          children: <Widget>[
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              child: Row(
                children: <Widget>[
                  Icon(Icons.tune, color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l.controlPanel,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: l.resetAll,
                    onPressed: s.reset,
                    icon: const Icon(Icons.restart_alt),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: <Widget>[
                  // ── Presets ───────────────────────────────────────────
                  _GroupTitle(l.groupPresets),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: s.applyMaterial2Preset,
                            child: Text(l.presetM2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: s.applyMaterial3Preset,
                            child: Text(l.presetM3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Language ──────────────────────────────────────────
                  //
                  // Sitting next to the theme controls on purpose: locale and
                  // theme are the same kind of preference, and both are read
                  // from MaterialApp.
                  _GroupTitle(l.groupLanguage),
                  _Row(
                    label: 'MaterialApp.locale',
                    child: SegmentedButton<String>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: <ButtonSegment<String>>[
                        ButtonSegment<String>(
                          value: 'system',
                          label: Text(l.followSystem),
                        ),
                        ButtonSegment<String>(
                          value: 'en',
                          label: Text(l.languageEnglish),
                        ),
                        ButtonSegment<String>(
                          value: 'es',
                          label: Text(l.languageSpanish),
                        ),
                      ],
                      selected: <String>{s.locale?.languageCode ?? 'system'},
                      onSelectionChanged: (Set<String> v) => s.update(
                        // `null` hands the decision back to the device, which is
                        // what a real app should default to.
                        () => s.locale = v.first == 'system'
                            ? null
                            : Locale(v.first),
                      ),
                    ),
                  ),

                  // ── Basics ────────────────────────────────────────────
                  _GroupTitle(l.groupBasics),
                  SwitchListTile(
                    dense: true,
                    title: const Text('useMaterial3'),
                    subtitle: Text(s.useMaterial3 ? l.material3 : l.material2),
                    value: s.useMaterial3,
                    onChanged: (bool v) => s.update(() => s.useMaterial3 = v),
                  ),
                  _Row(
                    label: 'themeMode',
                    child: SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: const <ButtonSegment<ThemeMode>>[
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.light,
                          icon: Icon(Icons.light_mode, size: 18),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.system,
                          icon: Icon(Icons.brightness_auto, size: 18),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.dark,
                          icon: Icon(Icons.dark_mode, size: 18),
                        ),
                      ],
                      selected: <ThemeMode>{s.themeMode},
                      onSelectionChanged: (Set<ThemeMode> v) =>
                          s.update(() => s.themeMode = v.first),
                    ),
                  ),

                  // ── Color ─────────────────────────────────────────────
                  _GroupTitle(l.groupColour),
                  _Row(
                    label: l.colorSchemeSource,
                    child: DropdownButtonFormField<ColorSchemeSource>(
                      initialValue: s.colorSource,
                      isDense: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: <DropdownMenuItem<ColorSchemeSource>>[
                        for (final ColorSchemeSource source
                            in ColorSchemeSource.values)
                          DropdownMenuItem<ColorSchemeSource>(
                            value: source,
                            child: Text(source.label(l)),
                          ),
                      ],
                      onChanged: (ColorSchemeSource? v) => s.update(
                        () => s.colorSource = v ?? ColorSchemeSource.seed,
                      ),
                    ),
                  ),
                  if (s.colorSource == ColorSchemeSource.seed) ...<Widget>[
                    _Row(
                      label: 'seedColor',
                      child: _ColorRow(
                        colors: Colors.primaries,
                        selected: s.seedColor,
                        onSelected: (Color c) =>
                            s.update(() => s.seedColor = c),
                      ),
                    ),
                    _Row(
                      label: 'dynamicSchemeVariant',
                      child: DropdownButtonFormField<DynamicSchemeVariant>(
                        initialValue: s.schemeVariant,
                        isDense: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        items: <DropdownMenuItem<DynamicSchemeVariant>>[
                          for (final DynamicSchemeVariant v
                              in DynamicSchemeVariant.values)
                            DropdownMenuItem<DynamicSchemeVariant>(
                              value: v,
                              child: Text(v.name),
                            ),
                        ],
                        onChanged: (DynamicSchemeVariant? v) => s.update(
                          () => s.schemeVariant =
                              v ?? DynamicSchemeVariant.tonalSpot,
                        ),
                      ),
                    ),
                    _Slider(
                      label: 'contrastLevel',
                      value: s.contrastLevel,
                      min: -1,
                      max: 1,
                      divisions: 8,
                      onChanged: (double v) =>
                          s.update(() => s.contrastLevel = v),
                    ),
                  ],
                  if (s.colorSource == ColorSchemeSource.swatch)
                    _Row(
                      label: 'primarySwatch',
                      child: _ColorRow(
                        colors: Colors.primaries,
                        selected: s.primarySwatch,
                        onSelected: (Color c) => s.update(
                          () => s.primarySwatch = c as MaterialColor,
                        ),
                      ),
                    ),
                  SwitchListTile(
                    dense: true,
                    title: Text(l.legacyOverrides),
                    subtitle: Text(l.legacyOverridesSubtitle),
                    value: s.applyLegacyOverrides,
                    onChanged: (bool v) =>
                        s.update(() => s.applyLegacyOverrides = v),
                  ),
                  if (!s.useMaterial3)
                    SwitchListTile(
                      dense: true,
                      title: const Text('applyElevationOverlayColor'),
                      subtitle: Text(l.elevationOverlaySubtitle),
                      value: s.applyElevationOverlayColor,
                      onChanged: (bool v) =>
                          s.update(() => s.applyElevationOverlayColor = v),
                    ),

                  // ── Typography ────────────────────────────────────────
                  _GroupTitle(l.groupTypography),
                  _Row(
                    label: 'typography',
                    child: SegmentedButton<TypographyKind>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: const <ButtonSegment<TypographyKind>>[
                        ButtonSegment<TypographyKind>(
                          value: TypographyKind.material2021,
                          label: Text('2021'),
                        ),
                        ButtonSegment<TypographyKind>(
                          value: TypographyKind.material2018,
                          label: Text('2018'),
                        ),
                        ButtonSegment<TypographyKind>(
                          value: TypographyKind.material2014,
                          label: Text('2014'),
                        ),
                      ],
                      selected: <TypographyKind>{s.typography},
                      onSelectionChanged: (Set<TypographyKind> v) =>
                          s.update(() => s.typography = v.first),
                    ),
                  ),
                  _Row(
                    label: l.fontFamilyLabel,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: <Widget>[
                        for (final FontChoice f in FontChoice.values)
                          ChoiceChip(
                            visualDensity: VisualDensity.compact,
                            label: Text(f.label(l)),
                            selected: s.fontChoice == f,
                            onSelected: (_) => s.update(() => s.fontChoice = f),
                          ),
                      ],
                    ),
                  ),
                  _Row(
                    label: l.textThemePreset,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: <Widget>[
                        for (final TextThemePreset p in TextThemePreset.values)
                          ChoiceChip(
                            visualDensity: VisualDensity.compact,
                            label: Text(p.label(l)),
                            selected: s.textPreset == p,
                            onSelected: (_) => s.update(() => s.textPreset = p),
                          ),
                      ],
                    ),
                  ),
                  _Slider(
                    label: l.sizeScale,
                    value: s.fontSizeScale,
                    min: 0.7,
                    max: 1.6,
                    divisions: 18,
                    onChanged: (double v) =>
                        s.update(() => s.fontSizeScale = v),
                  ),
                  _Slider(
                    label: l.letterSpacingDelta,
                    value: s.letterSpacingDelta,
                    min: -1,
                    max: 3,
                    divisions: 16,
                    onChanged: (double v) =>
                        s.update(() => s.letterSpacingDelta = v),
                  ),
                  _Slider(
                    label: l.lineHeightScale,
                    value: s.lineHeightScale,
                    min: 0.8,
                    max: 2,
                    divisions: 12,
                    onChanged: (double v) =>
                        s.update(() => s.lineHeightScale = v),
                  ),
                  _Slider(
                    label: l.titleWeight,
                    value: s.titleFontWeightIndex.toDouble(),
                    min: 0,
                    max: 8,
                    divisions: 8,
                    displayValue:
                        'w${kFontWeights[s.titleFontWeightIndex].value}',
                    onChanged: (double v) =>
                        s.update(() => s.titleFontWeightIndex = v.round()),
                  ),

                  // ── Shape and density ─────────────────────────────────
                  _GroupTitle(l.groupShapeDensity),
                  _Slider(
                    label: l.cornerRadius,
                    value: s.cornerRadius,
                    max: 32,
                    divisions: 32,
                    displayValue: '${s.cornerRadius.toStringAsFixed(0)} px',
                    onChanged: (double v) => s.update(() => s.cornerRadius = v),
                  ),
                  SwitchListTile(
                    dense: true,
                    title: Text(l.componentThemes),
                    subtitle: Text(l.componentThemesSubtitle),
                    value: s.applyComponentThemes,
                    onChanged: (bool v) =>
                        s.update(() => s.applyComponentThemes = v),
                  ),
                  SwitchListTile(
                    dense: true,
                    title: const Text('adaptivePlatformDensity'),
                    value: s.adaptiveDensity,
                    onChanged: (bool v) =>
                        s.update(() => s.adaptiveDensity = v),
                  ),
                  if (!s.adaptiveDensity) ...<Widget>[
                    _Slider(
                      label: l.densityHorizontal,
                      value: s.densityHorizontal,
                      min: -4,
                      max: 4,
                      divisions: 16,
                      onChanged: (double v) =>
                          s.update(() => s.densityHorizontal = v),
                    ),
                    _Slider(
                      label: l.densityVertical,
                      value: s.densityVertical,
                      min: -4,
                      max: 4,
                      divisions: 16,
                      onChanged: (double v) =>
                          s.update(() => s.densityVertical = v),
                    ),
                  ],
                  _Row(
                    label: 'materialTapTargetSize',
                    child: SegmentedButton<MaterialTapTargetSize>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: <ButtonSegment<MaterialTapTargetSize>>[
                        ButtonSegment<MaterialTapTargetSize>(
                          value: MaterialTapTargetSize.padded,
                          label: Text(l.tapTargetPadded),
                        ),
                        ButtonSegment<MaterialTapTargetSize>(
                          value: MaterialTapTargetSize.shrinkWrap,
                          label: Text(l.tapTargetShrink),
                        ),
                      ],
                      selected: <MaterialTapTargetSize>{s.tapTargetSize},
                      onSelectionChanged: (Set<MaterialTapTargetSize> v) =>
                          s.update(() => s.tapTargetSize = v.first),
                    ),
                  ),
                  _Row(
                    label: 'splashFactory',
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: <Widget>[
                        for (final SplashKind k in SplashKind.values)
                          ChoiceChip(
                            visualDensity: VisualDensity.compact,
                            label: Text(k.name),
                            selected: s.splash == k,
                            onSelected: (_) => s.update(() => s.splash = k),
                          ),
                      ],
                    ),
                  ),

                  // ── Motion ────────────────────────────────────────────
                  _GroupTitle(l.groupMotion),
                  _Slider(
                    label: 'themeAnimationDuration',
                    value: s.themeAnimationDuration.inMilliseconds.toDouble(),
                    max: 2000,
                    divisions: 20,
                    displayValue:
                        '${s.themeAnimationDuration.inMilliseconds} ms',
                    onChanged: (double v) => s.update(
                      () => s.themeAnimationDuration = Duration(
                        milliseconds: v.round(),
                      ),
                    ),
                  ),

                  // ── Custom extension ──────────────────────────────────
                  _GroupTitle(l.groupExtension),
                  _Slider(
                    label: 'brand.spacing',
                    value: s.brandSpacing,
                    min: 4,
                    max: 40,
                    divisions: 18,
                    displayValue: '${s.brandSpacing.toStringAsFixed(0)} px',
                    onChanged: (double v) => s.update(() => s.brandSpacing = v),
                  ),
                  _Row(
                    label: 'brand.accent',
                    child: _ColorRow(
                      colors: const <Color>[
                        Color(0xFFFF6D00),
                        Color(0xFFD81B60),
                        Color(0xFF00ACC1),
                        Color(0xFF43A047),
                        Color(0xFF8E24AA),
                      ],
                      selected: s.brandAccent,
                      onSelected: (Color c) =>
                          s.update(() => s.brandAccent = c),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontFamily: 'monospace',
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    required this.label,
    required this.value,
    required this.max,
    required this.divisions,
    required this.onChanged,
    this.min = 0,
    this.displayValue,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String? displayValue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontFamily: 'monospace',
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                displayValue ?? value.toStringAsFixed(2),
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: 'monospace',
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SliderTheme(
            // An example of a component theme applied locally through an
            // XxxTheme widget instead of through ThemeData.
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.colors,
    required this.selected,
    required this.onSelected,
  });

  final List<Color> colors;
  final Color selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        for (final Color c in colors)
          GestureDetector(
            onTap: () => onSelected(c),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  color: c.toARGB32() == selected.toARGB32()
                      ? Theme.of(context).colorScheme.onSurface
                      : Colors.transparent,
                  width: 2.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
