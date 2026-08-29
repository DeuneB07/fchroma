import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fchroma/l10n/generated/app_localizations.dart';
import 'package:fchroma/l10n/lab_strings.dart';
import 'package:fchroma/state/theme_lab_state.dart';
import 'package:fchroma/theme/app_theme_builder.dart';
import 'package:fchroma/ui/home_shell.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  REGRESSION TESTS
// ───────────────────────────────────────────────────────────────────────────
//  These cover the two failure modes that actually shipped:
//
//   1. Building the theme threw once the font-size slider left 1.0, because
//      the base TextTheme came from `typography.black`, which has no sizes.
//      `TextTheme.apply(fontSizeFactor:)` asserts on a null fontSize.
//
//   2. Several pages overflowed at phone width. Flutter reports a RenderFlex
//      overflow through FlutterError, and any such report fails a widget test,
//      so simply rendering every page at 375 px is enough to catch it.
// ═══════════════════════════════════════════════════════════════════════════

/// A phone-sized surface. 375x812 is the iPhone X logical size and is narrow
/// enough to catch anything that assumes a tablet.
const Size kPhone = Size(375, 812);

void main() {
  group('AppThemeBuilder never throws', () {
    // The crash was only reachable through certain combinations, so we sweep
    // the axes that feed into the text theme rather than spot-checking.
    for (final TypographyKind typography in TypographyKind.values) {
      for (final TextThemePreset preset in TextThemePreset.values) {
        for (final double scale in <double>[0.7, 1.0, 1.6]) {
          test('typography=${typography.name} preset=${preset.name} '
              'scale=$scale', () {
            final ThemeLabState state = ThemeLabState()
              ..typography = typography
              ..textPreset = preset
              ..fontSizeScale = scale
              ..letterSpacingDelta = 1.5
              ..lineHeightScale = 1.4;

            for (final Brightness brightness in Brightness.values) {
              final ThemeData theme = AppThemeBuilder.build(state, brightness);

              // Every style must survive with a real size, otherwise the next
              // `apply(fontSizeFactor:)` downstream blows up again.
              expect(theme.textTheme.bodyMedium?.fontSize, isNotNull);
              expect(theme.textTheme.displayLarge?.fontSize, isNotNull);
            }
          });
        }
      }
    }

    test('both Material versions and all colour sources build', () {
      for (final ColorSchemeSource source in ColorSchemeSource.values) {
        for (final bool useMaterial3 in <bool>[false, true]) {
          final ThemeLabState state = ThemeLabState()
            ..colorSource = source
            ..useMaterial3 = useMaterial3
            ..fontSizeScale = 1.3;

          expect(
            () => AppThemeBuilder.build(state, Brightness.dark),
            returnsNormally,
            reason: 'source=${source.name} useMaterial3=$useMaterial3',
          );
        }
      }
    });

    test('high-contrast override builds', () {
      final ThemeLabState state = ThemeLabState();
      expect(
        () => AppThemeBuilder.build(
          state,
          Brightness.light,
          contrastOverride: 1.0,
        ),
        returnsNormally,
      );
    });
  });

  group('every section renders at phone width', () {
    for (int index = 0; index < kSections.length; index++) {
      final LabSection section = kSections[index];

      // The id, not the label: test names must not shift with the locale.
      testWidgets('${section.id.name} (Material 3)', (
        WidgetTester tester,
      ) async {
        await _renderSection(tester, index, useMaterial3: true);
      });

      testWidgets('${section.id.name} (Material 2)', (
        WidgetTester tester,
      ) async {
        await _renderSection(tester, index, useMaterial3: false);
      });
    }

    testWidgets('sections survive an extreme text scale', (
      WidgetTester tester,
    ) async {
      // The typography page is the densest one, so it is the best canary for
      // a layout that cannot cope with larger text.
      await _renderSection(
        tester,
        kSections.indexWhere((LabSection s) => s.id == LabSectionId.typography),
        useMaterial3: true,
        configure: (ThemeLabState s) => s.fontSizeScale = 1.6,
      );
    });

    // English tends to be shorter than Spanish, but not always, and a layout
    // that only ever gets exercised in one language will break in the other.
    for (final Locale locale in AppLocalizations.supportedLocales) {
      testWidgets('every section renders in ${locale.languageCode}', (
        WidgetTester tester,
      ) async {
        for (int index = 0; index < kSections.length; index++) {
          await _renderSection(
            tester,
            index,
            useMaterial3: true,
            locale: locale,
          );
        }
      });
    }
  });
}

/// Builds one section at phone size and scrolls through the whole page.
///
/// Scrolling matters: a ListView only builds the children it can see, so a
/// widget that overflows near the bottom is invisible to a test that never
/// scrolls down to it.
Future<void> _renderSection(
  WidgetTester tester,
  int index, {
  required bool useMaterial3,
  Locale locale = const Locale('es'),
  void Function(ThemeLabState state)? configure,
}) async {
  tester.view.physicalSize = kPhone;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final ThemeLabState state = ThemeLabState()..useMaterial3 = useMaterial3;
  configure?.call(state);

  await tester.pumpWidget(
    ThemeLabScope(
      state: state,
      child: MaterialApp(
        theme: AppThemeBuilder.build(state, Brightness.light),
        // Without the delegates `AppLocalizations.of` and `LabStrings.of`
        // find nothing and every translated string throws.
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          ...AppLocalizations.localizationsDelegates,
          const LabStringsDelegate(),
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        // The Scaffold is required, not cosmetic: pages contain IconButtons
        // and Cards, which assert unless there is a Material ancestor. Without
        // it every such widget throws, Flutter swaps in an ErrorWidget, and
        // ErrorWidget expands to fill its constraints — which shows up as
        // nonsense 100 000 px "overflows" that have nothing to do with the
        // layout being tested. HomeShell supplies this Scaffold in the app.
        home: Scaffold(body: Builder(builder: kSections[index].builder)),
      ),
    ),
  );

  // `pumpAndSettle` would hang here: the widget gallery contains progress
  // indicators, which animate forever. A bounded pump is what this needs.
  await tester.pump(const Duration(milliseconds: 300));

  final Finder scrollable = find.byType(Scrollable);
  if (scrollable.evaluate().isNotEmpty) {
    for (int i = 0; i < 12; i++) {
      await tester.drag(scrollable.first, const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  // Any RenderFlex overflow, failed assertion or other framework error raised
  // while building, laying out or painting lands here.
  expect(tester.takeException(), isNull);
}
