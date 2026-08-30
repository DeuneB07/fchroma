import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../state/theme_lab_state.dart';
import 'control_panel.dart';
import 'pages/about_page.dart';
import 'pages/color_scheme_page.dart';
import 'pages/component_themes_page.dart';
import 'pages/density_shape_page.dart';
import 'pages/extensions_page.dart';
import 'pages/generated_code_page.dart';
import 'pages/legacy_colors_page.dart';
import 'pages/material_version_page.dart';
import 'pages/overview_page.dart';
import 'pages/text_theme_page.dart';
import 'pages/transitions_page.dart';
import 'pages/typography_page.dart';

/// Identifies a section independently of its displayed name.
///
/// The label used to live in the const list as a plain string. Once it needs
/// translating that stops working: the text depends on a [BuildContext], which
/// a `const` list cannot hold. Keeping a stable id and resolving the label on
/// demand preserves both the const list and the translations — and gives tests
/// a name that does not change with the locale.
enum LabSectionId {
  fundamentals,
  materialVersion,
  colorScheme,
  legacyColors,
  textTheme,
  typography,
  components,
  shapeDensity,
  extensions,
  transitions,
  export,
  about,
}

/// One section of the lab.
class LabSection {
  const LabSection({
    required this.id,
    required this.icon,
    required this.builder,
  });

  final LabSectionId id;
  final IconData icon;
  final WidgetBuilder builder;

  /// Full name, for the drawer and the extended rail.
  String label(AppLocalizations l) => switch (id) {
    LabSectionId.fundamentals => l.navFundamentals,
    LabSectionId.materialVersion => l.navMaterialVersion,
    LabSectionId.colorScheme => l.navColorScheme,
    LabSectionId.legacyColors => l.navLegacyColors,
    LabSectionId.textTheme => l.navTextTheme,
    LabSectionId.typography => l.navTypography,
    LabSectionId.components => l.navComponents,
    LabSectionId.shapeDensity => l.navShapeDensity,
    LabSectionId.extensions => l.navExtensions,
    LabSectionId.transitions => l.navTransitions,
    LabSectionId.export => l.navExport,
    LabSectionId.about => l.navAbout,
  };

  /// Abbreviated name, for the narrow rail where space is tight.
  String shortLabel(AppLocalizations l) => switch (id) {
    LabSectionId.fundamentals => l.navFundamentalsShort,
    LabSectionId.materialVersion => l.navMaterialVersionShort,
    LabSectionId.colorScheme => l.navColorSchemeShort,
    LabSectionId.legacyColors => l.navLegacyColorsShort,
    LabSectionId.textTheme => l.navTextThemeShort,
    LabSectionId.typography => l.navTypographyShort,
    LabSectionId.components => l.navComponentsShort,
    LabSectionId.shapeDensity => l.navShapeDensityShort,
    LabSectionId.extensions => l.navExtensionsShort,
    LabSectionId.transitions => l.navTransitionsShort,
    LabSectionId.export => l.navExportShort,
    LabSectionId.about => l.navAbout,
  };
}

const List<LabSection> kSections = <LabSection>[
  LabSection(
    id: LabSectionId.fundamentals,
    icon: Icons.school_outlined,
    builder: _overview,
  ),
  LabSection(
    id: LabSectionId.materialVersion,
    icon: Icons.compare_arrows,
    builder: _materialVersion,
  ),
  LabSection(
    id: LabSectionId.colorScheme,
    icon: Icons.palette_outlined,
    builder: _colorScheme,
  ),
  LabSection(
    id: LabSectionId.legacyColors,
    icon: Icons.history,
    builder: _legacy,
  ),
  LabSection(
    id: LabSectionId.textTheme,
    icon: Icons.text_fields,
    builder: _textTheme,
  ),
  LabSection(
    id: LabSectionId.typography,
    icon: Icons.font_download_outlined,
    builder: _typography,
  ),
  LabSection(
    id: LabSectionId.components,
    icon: Icons.widgets_outlined,
    builder: _components,
  ),
  LabSection(
    id: LabSectionId.shapeDensity,
    icon: Icons.rounded_corner,
    builder: _density,
  ),
  LabSection(
    id: LabSectionId.extensions,
    icon: Icons.extension_outlined,
    builder: _extensions,
  ),
  LabSection(
    id: LabSectionId.transitions,
    icon: Icons.animation,
    builder: _transitions,
  ),
  LabSection(id: LabSectionId.export, icon: Icons.code, builder: _code),
  LabSection(
    id: LabSectionId.about,
    icon: Icons.info_outlined,
    builder: _about,
  ),
];

// Top-level functions so kSections can be declared `const`.
Widget _overview(BuildContext c) => const OverviewPage();
Widget _materialVersion(BuildContext c) => const MaterialVersionPage();
Widget _colorScheme(BuildContext c) => const ColorSchemePage();
Widget _legacy(BuildContext c) => const LegacyColorsPage();
Widget _textTheme(BuildContext c) => const TextThemePage();
Widget _typography(BuildContext c) => const TypographyPage();
Widget _components(BuildContext c) => const ComponentThemesPage();
Widget _density(BuildContext c) => const DensityShapePage();
Widget _extensions(BuildContext c) => const ExtensionsPage();
Widget _transitions(BuildContext c) => const TransitionsPage();
Widget _code(BuildContext c) => const GeneratedCodePage();
Widget _about(BuildContext c) => const AboutPage();

/// The app's shell: navigation + content + control panel.
///
/// The layout adapts to the available width, which is exactly what a real app
/// has to do:
///   · > 1300 px  →  rail + content + panel pinned on the right
///   · > 800 px   →  rail + content, panel in a Drawer
///   · narrower   →  navigation Drawer + content, panel in the endDrawer
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeLabState s = ThemeLabScope.of(context);
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context);
    final double width = MediaQuery.sizeOf(context).width;

    final bool wide = width > 800;
    final bool extraWide = width > 1300;

    final LabSection section = kSections[_index];

    return Scaffold(
      appBar: AppBar(
        // Nothing in here sets a colour. AppBar already wraps its whole
        // toolbar in an IconTheme and its title in a DefaultTextStyle carrying
        // the correct foreground, so icon and text inherit it for free.
        //
        // Hardcoding `colorScheme.primary` here looked fine in Material 3,
        // where the bar sits on `surface` — and vanished completely in
        // Material 2, where the bar IS `primary`. Inheriting is the fix, and
        // it is the same reason this app keeps telling you not to reach for a
        // colour that the surface underneath does not know about.
        title: Row(
          children: <Widget>[
            const Icon(Icons.color_lens),
            const SizedBox(width: 10),
            const Text('FChroma'),
            const SizedBox(width: 12),
            if (width > 600)
              Flexible(
                child: Opacity(
                  // Opacity instead of a dimmer colour: it works on top of
                  // whatever foreground the AppBar decided to use.
                  opacity: 0.7,
                  child: Text(
                    '· ${section.label(l)}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
        actions: <Widget>[
          // Badge showing which Material version is active.
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                s.useMaterial3 ? 'M3' : 'M2',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: l.toggleLightDark,
            onPressed: () => s.update(
              () => s.themeMode = s.themeMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            ),
            icon: Icon(
              s.themeMode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          if (!extraWide)
            Builder(
              builder: (BuildContext innerContext) => IconButton(
                tooltip: l.controlPanel,
                onPressed: () => Scaffold.of(innerContext).openEndDrawer(),
                icon: const Icon(Icons.tune),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),

      // On narrow screens the navigation lives in a Drawer.
      drawer: wide
          ? null
          : NavigationDrawer(
              selectedIndex: _index,
              onDestinationSelected: (int i) {
                setState(() => _index = i);
                Navigator.of(context).pop();
              },
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 24, 16, 12),
                  child: Text(l.sections),
                ),
                for (final LabSection sec in kSections)
                  NavigationDrawerDestination(
                    icon: Icon(sec.icon),
                    label: Text(sec.label(l)),
                  ),
              ],
            ),

      // The control panel is always reachable through the endDrawer.
      endDrawer: extraWide
          ? null
          : const Drawer(width: 340, child: ControlPanel()),

      // ── SYSTEM BARS ────────────────────────────────────────────────────
      //
      // The app runs edge-to-edge (see `main`), so the status bar and the
      // Android navigation bar are drawn OVER this Row. Anything underneath
      // them still renders and still looks fine — it just cannot be tapped.
      //
      // `top: false` because the AppBar above has already consumed the status
      // bar inset; padding for it again would leave a dead strip. The bottom,
      // left and right insets are ours to handle: the gesture bar, the
      // three-button bar, and display cutouts in landscape.
      body: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            if (wide)
              // NavigationRail does not scroll on its own: with 11 destinations
              // and a short window it overflows. This is the standard pattern
              // for making it scrollable without losing the full-height
              // background: a scroll view whose minimum height is the viewport.
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          selectedIndex: _index,
                          onDestinationSelected: (int i) =>
                              setState(() => _index = i),
                          // `extended` shows the labels next to the icons.
                          extended: extraWide,
                          labelType: extraWide
                              ? NavigationRailLabelType.none
                              : NavigationRailLabelType.all,
                          destinations: <NavigationRailDestination>[
                            for (final LabSection sec in kSections)
                              NavigationRailDestination(
                                icon: Icon(sec.icon),
                                label: Text(
                                  extraWide ? sec.label(l) : sec.shortLabel(l),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (wide) const VerticalDivider(width: 1),

            // The content of the selected section.
            Expanded(
              child: ClipRect(
                // AnimatedSwitcher keeps section changes from snapping.
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: KeyedSubtree(
                    key: ValueKey<int>(_index),
                    child: Builder(builder: section.builder),
                  ),
                ),
              ),
            ),

            // On very wide screens the panel stays pinned to the right.
            if (extraWide) ...<Widget>[
              const VerticalDivider(width: 1),
              const SizedBox(width: 340, child: ControlPanel()),
            ],
          ],
        ),
      ),
    );
  }
}
