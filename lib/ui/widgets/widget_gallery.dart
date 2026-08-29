import 'package:flutter/material.dart';

import '../../l10n/lab_strings.dart';
import '../../l10n/strings/gallery_strings.dart';

/// A showcase of Material widgets.
///
/// This widget hardcodes NO color and NO size: everything comes from the
/// theme. That is why it can be dropped inside any [Theme] and used as a test
/// specimen for comparing two themes side by side.
class WidgetGallery extends StatefulWidget {
  const WidgetGallery({super.key, this.compact = false});

  /// In compact mode some sections are dropped so it fits in two columns.
  final bool compact;

  @override
  State<WidgetGallery> createState() => _WidgetGalleryState();
}

class _WidgetGalleryState extends State<WidgetGallery>
    with SingleTickerProviderStateMixin {
  bool _switchValue = true;
  bool _checkboxValue = true;
  int _radioValue = 0;
  double _sliderValue = 0.6;
  int _selectedChip = 0;
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final GalleryStrings t = LabStrings.of(context).gallery;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ── Buttons ────────────────────────────────────────────────────
        // Material 3's five button types, in order of emphasis.
        //
        // Their captions are the widget names on purpose — Filled, Tonal,
        // Elevated — so they are written inline rather than translated.
        _Label(t.buttons, theme),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            // Highest emphasis: painted with colorScheme.primary.
            FilledButton(onPressed: () {}, child: const Text('Filled')),
            // Tonal variant: uses secondaryContainer. M3 only.
            FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
            // The quintessential M2 button: color plus shadow.
            ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
            // Medium emphasis: border only (colorScheme.outline).
            OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            // Lowest emphasis: just text in primary.
            TextButton(onPressed: () {}, child: const Text('Text')),
            // Disabled: watch how it reacts to ThemeData.disabledColor.
            FilledButton(onPressed: null, child: Text(t.disabled)),
          ],
        ),
        const SizedBox(height: 16),

        // ── Icon buttons ───────────────────────────────────────────────
        _Label(t.iconButtons, theme),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
            IconButton.filled(onPressed: () {}, icon: const Icon(Icons.add)),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.edit)),
            FloatingActionButton.small(
              onPressed: () {},
              child: const Icon(Icons.navigation),
            ),
            FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.star),
              label: const Text('Extended'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Selection controls ─────────────────────────────────────────
        _Label(t.selectionControls, theme),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            // The M3 Switch carries an icon inside the thumb; the M2 one does
            // not.
            Switch(
              value: _switchValue,
              onChanged: (bool v) => setState(() => _switchValue = v),
            ),
            Checkbox(
              value: _checkboxValue,
              onChanged: (bool? v) =>
                  setState(() => _checkboxValue = v ?? false),
            ),
            // Since Flutter 3.32 Radios no longer take groupValue/onChanged:
            // the group is declared with a [RadioGroup] ancestor.
            RadioGroup<int>(
              groupValue: _radioValue,
              onChanged: (int? v) => setState(() => _radioValue = v ?? 0),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Radio<int>(value: 0), Radio<int>(value: 1)],
              ),
            ),
          ],
        ),
        Slider(
          value: _sliderValue,
          onChanged: (double v) => setState(() => _sliderValue = v),
        ),
        const SizedBox(height: 8),

        // ── Chips ──────────────────────────────────────────────────────
        _Label(t.chips, theme),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              FilterChip(
                label: Text(t.filter(i + 1)),
                selected: _selectedChip == i,
                onSelected: (_) => setState(() => _selectedChip = i),
              ),
            ActionChip(
              avatar: const Icon(Icons.bolt, size: 18),
              label: Text(t.action),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Text input ─────────────────────────────────────────────────
        _Label(t.textFields, theme),
        TextField(
          decoration: InputDecoration(
            labelText: t.fieldLabel,
            hintText: t.fieldHint,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            labelText: t.fieldWithError,
            errorText: t.fieldErrorText,
          ),
        ),
        const SizedBox(height: 16),

        // ── Surfaces and elevation ─────────────────────────────────────
        _Label(t.surfaces, theme),
        Row(
          children: <Widget>[
            for (final double e in <double>[0, 1, 3])
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Card(
                    elevation: e,
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          'elev $e',
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),

        if (!widget.compact) ...<Widget>[
          // ── Tabs ─────────────────────────────────────────────────────
          _Label(t.tabs, theme),
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: t.tabOne),
              Tab(text: t.tabTwo),
              Tab(text: t.tabThree),
            ],
          ),
          const SizedBox(height: 16),

          // ── Progress indicators ──────────────────────────────────────
          _Label(t.progress, theme),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(width: 16),
              const Expanded(child: LinearProgressIndicator(value: 0.6)),
            ],
          ),
          const SizedBox(height: 16),

          // ── Lists and dialogs ────────────────────────────────────────
          _Label(t.listsAndDialogs, theme),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(t.listTileTitle),
            subtitle: Text(t.listTileSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          Wrap(
            spacing: 8,
            children: <Widget>[
              OutlinedButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (BuildContext dialogContext) => AlertDialog(
                    icon: const Icon(Icons.info_outline),
                    title: const Text('AlertDialog'),
                    content: Text(t.dialogBody),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(t.close),
                      ),
                    ],
                  ),
                ),
                child: Text(t.openDialog),
              ),
              OutlinedButton(
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(t.snackBarContent))),
                child: Text(t.showSnackBar),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Navigation ───────────────────────────────────────────────
          _Label(t.navigation, theme),
          NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
            destinations: <NavigationDestination>[
              NavigationDestination(
                icon: const Icon(Icons.home),
                label: t.navHome,
              ),
              NavigationDestination(
                icon: const Icon(Icons.search),
                label: t.navSearch,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings),
                label: t.navSettings,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, this.theme);
  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          letterSpacing: 1.1,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
