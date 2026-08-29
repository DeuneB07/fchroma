import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/brand_theme_extension.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  LAB SUPPORT WIDGETS
// ───────────────────────────────────────────────────────────────────────────
//  Note that NONE of these widgets hardcodes a color or a size: they all read
//  `Theme.of(context)`. That is why the lab's own interface restyles itself
//  whenever you change an option.
// ═══════════════════════════════════════════════════════════════════════════

/// Page header: large title plus description.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.badge,
  });

  final String title;
  final String subtitle;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    // `Theme.of(context)` walks up the tree to the nearest [Theme]. It returns
    // the whole ThemeData and subscribes this widget to its changes.
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (badge != null) ...<Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge!,
              // `labelSmall` is the smallest role in the TextTheme.
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(title, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Section separator inside a page.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // The rule is a bottom border rather than an `Expanded(Divider)` sharing
    // the Row.
    //
    // That earlier shape was the single worst offender in this app: a plain
    // `Text` next to an `Expanded` is inflexible, so a long title took its
    // full intrinsic width and blew past the right edge — by 417 px in one
    // case. Making the text `Flexible` instead does not fix it either: two
    // flex children split the free space between them, so the title would
    // wrap at half width even when there was plenty of room.
    //
    // A border sidesteps the flex negotiation entirely: one flexible child,
    // a rule that always spans the full width, and nothing to overflow.
    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 12),
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(icon, size: 20, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              text,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The schematic card documenting ONE theme property.
///
/// Layout: property name · type · what it does · live demo.
/// It is the main building block of the whole lab.
class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.name,
    required this.type,
    required this.description,
    this.defaultValue,
    this.currentValue,
    this.demo,
    this.tip,
    this.deprecated = false,
  });

  /// The exact property name in the SDK, e.g. `colorScheme.primary`.
  final String name;

  /// The property's Dart type.
  final String type;

  /// What it is for, in plain language.
  final String description;

  /// What it is worth if you never touch it.
  final String? defaultValue;

  /// What it is worth right now with the lab's current configuration.
  final String? currentValue;

  /// Visual demonstration of the property.
  final Widget? demo;

  /// A warning or a practical tip.
  final String? tip;

  /// Whether the property is deprecated or discouraged in Material 3.
  final bool deprecated;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                _Mono(name, emphasis: true),
                _TypeChip(type),
                if (deprecated)
                  _Pill(
                    AppLocalizations.of(context).deprecatedBadge,
                    background: cs.errorContainer,
                    foreground: cs.onErrorContainer,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(description, style: theme.textTheme.bodyMedium),
            if (defaultValue != null || currentValue != null) ...<Widget>[
              const SizedBox(height: 10),
              Wrap(
                spacing: 16,
                runSpacing: 4,
                children: <Widget>[
                  if (defaultValue != null)
                    _KeyValue(
                      label: AppLocalizations.of(context).defaultValueLabel,
                      value: defaultValue!,
                    ),
                  if (currentValue != null)
                    _KeyValue(
                      label: AppLocalizations.of(context).currentValueLabel,
                      value: currentValue!,
                      highlight: true,
                    ),
                ],
              ),
            ],
            if (demo != null) ...<Widget>[
              const SizedBox(height: 14),
              // Material, not a coloured Container.
              //
              // Ink effects are painted by the nearest Material ancestor, not
              // by the widget that was tapped. Putting a coloured DecoratedBox
              // between a ListTile and its Material hides the splash — and
              // Flutter asserts about it, which is how this surfaced.
              //
              // A Material with the same colour and radius looks identical and
              // gives every interactive demo a surface to paint its ink on.
              Material(
                // `surfaceContainerHighest` is M3's role for "one layer above
                // the background". It replaces the old `surfaceVariant`.
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(width: double.infinity, child: demo),
                ),
              ),
            ],
            if (tip != null) ...<Widget>[
              const SizedBox(height: 12),
              _TipBox(tip!),
            ],
          ],
        ),
      ),
    );
  }
}

/// Highlighted notice inside a card.
class _TipBox extends StatelessWidget {
  const _TipBox(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Read OUR own theme extension: a color Material does not define.
    final BrandTheme brand = BrandTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: brand.warningColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: brand.warningColor, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.lightbulb_outline, size: 18, color: brand.warningColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // A Row with two Texts would overflow here: some values are whole
    // sentences ("material2021 if useMaterial3, material2014 otherwise") and a
    // Row hands its children unbounded width, so the text can never wrap.
    //
    // Text.rich puts both spans in ONE paragraph, which the parent constrains
    // normally and which wraps across lines by itself. This also has to work
    // inside a Wrap, which rules out Expanded/Flexible — they only exist
    // inside a Flex.
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$label: ',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          TextSpan(
            text: value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: 'monospace',
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              color: highlight
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip(this.type);
  final String type;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return _Pill(
      type,
      background: cs.tertiaryContainer,
      foreground: cs.onTertiaryContainer,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, {required this.background, required this.foreground});

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: foreground, fontFamily: 'monospace'),
      ),
    );
  }
}

class _Mono extends StatelessWidget {
  const _Mono(this.text, {this.emphasis = false});
  final String text;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontFamily: 'monospace',
        fontWeight: emphasis ? FontWeight.w700 : FontWeight.w400,
        color: emphasis
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
      ),
    );
  }
}

/// A "term + definition" row that stacks vertically when space runs out.
///
/// The naive version of this — `SizedBox(width: 180)` next to an `Expanded` —
/// looks fine on a laptop and falls apart on a phone: the fixed column eats
/// most of a 360 px screen and leaves the definition a sliver to wrap into.
///
/// [LayoutBuilder] gives us the width actually available at this point in the
/// tree, which is what should drive the decision. `MediaQuery.sizeOf` would
/// report the whole window and get it wrong for anything inside a panel, a
/// card or a split view.
class DefinitionRow extends StatelessWidget {
  const DefinitionRow({
    super.key,
    required this.term,
    required this.definition,
    this.termWidth = 180,
  });

  final Widget term;
  final Widget definition;

  /// Width of the term column in the side-by-side layout.
  final double termWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Side by side only while the definition still gets at least as much
        // room as the term. Below that, stacking reads better.
        if (constraints.maxWidth < termWidth * 2) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[term, const SizedBox(height: 2), definition],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: termWidth, child: term),
            const SizedBox(width: 12),
            Expanded(child: definition),
          ],
        );
      },
    );
  }
}

/// A Dart code block with a copy button.
class CodeBlock extends StatelessWidget {
  const CodeBlock(this.code, {super.key, this.label});

  final String code;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: cs.inverseSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 6, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label ?? 'dart',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.onInverseSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: AppLocalizations.of(context).copy,
                  iconSize: 18,
                  color: cs.onInverseSurface,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context).codeCopied),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy_all_outlined),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.5,
                color: cs.onInverseSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows one color role: the swatch, its name and its "on" color on top.
class ColorRoleSwatch extends StatelessWidget {
  const ColorRoleSwatch({
    super.key,
    required this.name,
    required this.color,
    this.onColor,
    required this.usage,
  });

  final String name;
  final Color color;
  final Color? onColor;
  final String usage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor =
        onColor ??
        (color.computeLuminance() > 0.5 ? Colors.black : Colors.white);

    return Tooltip(
      message: usage,
      child: Container(
        width: 168,
        height: 92,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            Text(
              _hex(color),
              style: TextStyle(
                color: textColor.withValues(alpha: 0.85),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Converts a [Color] to the `0xAARRGGBB` notation used in Dart.
String hexOf(Color color) => _hex(color);

String _hex(Color color) {
  // In modern Flutter the channels are `double`s in 0..1, so they have to be
  // rescaled to 0..255 to write the classic hexadecimal form.
  String two(double channel) =>
      (channel * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
  return '0x${two(color.a)}${two(color.r)}${two(color.g)}${two(color.b)}';
}
