import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'l10n/generated/app_localizations.dart';
import 'l10n/lab_strings.dart';
import 'state/theme_lab_state.dart';
import 'theme/app_theme_builder.dart';
import 'ui/home_shell.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  FCHROMA — an interactive ThemeData lab
// ───────────────────────────────────────────────────────────────────────────
//  A sample app for understanding, property by property, how the style of a
//  Flutter application is defined.
//
//  A tour of the code:
//    main.dart ......................... this file: wires the app and theme
//    state/theme_lab_state.dart ........ what the user picked
//    theme/app_theme_builder.dart ...... how the ThemeData is assembled (core)
//    theme/text_theme_presets.dart ..... the 15 text styles
//    theme/brand_theme_extension.dart .. how to add your own properties
//    theme/theme_code_generator.dart ... exports the theme as Dart source
//    ui/ ............................... the lab's interface
// ═══════════════════════════════════════════════════════════════════════════

void main() {
  // Android 15 draws every app edge-to-edge and ignores attempts to opt out,
  // so the system bars sit ON TOP of the UI rather than beside it. Declaring
  // the mode here makes older Android versions behave the same way, so there
  // is one behaviour to design against instead of two.
  //
  // Edge-to-edge is only half the job: whatever draws underneath the bars has
  // to be padded out of the way, or it looks fine and cannot be tapped. That
  // padding is applied in `HomeShell` and `ControlPanel` via [SafeArea].
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const FChromaApp());
}

class FChromaApp extends StatefulWidget {
  const FChromaApp({super.key});

  @override
  State<FChromaApp> createState() => _FChromaAppState();
}

class _FChromaAppState extends State<FChromaApp> {
  /// The state lives in the root widget so it survives navigation.
  final ThemeLabState _state = ThemeLabState();

  @override
  void dispose() {
    // A ChangeNotifier must always be disposed: otherwise its listeners keep
    // the reference alive and memory leaks.
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The scope sits ABOVE the MaterialApp so the MaterialApp itself can read
    // it and rebuild whenever an option changes.
    return ThemeLabScope(state: _state, child: const _ThemedApp());
  }
}

class _ThemedApp extends StatelessWidget {
  const _ThemedApp();

  @override
  Widget build(BuildContext context) {
    // This line subscribes the widget to the ThemeLabState: every
    // notifyListeners() re-runs this build and, with it, rebuilds both themes.
    final ThemeLabState s = ThemeLabScope.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ── LOCALIZATION ────────────────────────────────────────────────

      /// `title` is read before any Localizations exist, so a localized title
      /// has to come from this callback instead. Its context sits below the
      /// delegates, so `AppLocalizations.of` works here.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appTitle,

      /// Two sources of strings, both delivered the same way.
      ///
      /// `AppLocalizations` is the gen-l10n class built from the ARB files and
      /// already bundles the Material, Cupertino and Widgets delegates, so
      /// Material's own strings ("Cancel", "Show menu", the date picker) get
      /// translated too. `LabStringsDelegate` carries the long-form page copy
      /// — see `lib/l10n/lab_strings.dart` for why that one is hand-written.
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        ...AppLocalizations.localizationsDelegates,
        const LabStringsDelegate(),
      ],

      /// Locales the app declares support for. Flutter matches the device
      /// locale against this list and falls back to the first entry.
      supportedLocales: AppLocalizations.supportedLocales,

      /// `null` follows the device. The control panel sets it to force one.
      locale: s.locale,

      // ── THE THREE PILLARS OF THEMING IN MaterialApp ─────────────────
      //
      // Note that light and dark come from the SAME function, with only the
      // brightness changing. That is the golden rule: build them separately
      // and you end up with two themes that drift apart, and the animation
      // between them jumps.

      /// The theme used in light mode.
      theme: AppThemeBuilder.build(s, Brightness.light),

      /// The theme used in dark mode. Left as null, the app would use `theme`
      /// in dark mode too and become unreadable.
      darkTheme: AppThemeBuilder.build(s, Brightness.dark),

      /// Which of the two applies: light, dark, or whatever the system says.
      themeMode: s.themeMode,

      // ── THE THEME-CHANGE ANIMATION ──────────────────────────────────
      //
      // Flutter does not snap from one theme to another: it INTERPOLATES them
      // property by property using each type's lerp method.

      /// How long that blend lasts.
      themeAnimationDuration: s.themeAnimationDuration,

      /// Which easing curve it follows.
      themeAnimationCurve: Curves.easeInOutCubic,

      /// Alternate high-contrast themes. Flutter switches to them ONLY when
      /// the user enables "high contrast" in the system accessibility
      /// settings. Almost nobody defines them, and they should: here it is
      /// just the same theme rebuilt with contrastLevel at 1.0.
      highContrastTheme: AppThemeBuilder.build(
        s,
        Brightness.light,
        contrastOverride: 1.0,
      ),
      highContrastDarkTheme: AppThemeBuilder.build(
        s,
        Brightness.dark,
        contrastOverride: 1.0,
      ),

      home: const HomeShell(),
    );
  }
}
