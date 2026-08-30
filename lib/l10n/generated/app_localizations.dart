import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Application title shown in the task switcher and browser tab.
  ///
  /// In en, this message translates to:
  /// **'FChroma · ThemeData lab'**
  String get appTitle;

  /// No description provided for @navFundamentals.
  ///
  /// In en, this message translates to:
  /// **'Fundamentals'**
  String get navFundamentals;

  /// No description provided for @navFundamentalsShort.
  ///
  /// In en, this message translates to:
  /// **'Basics'**
  String get navFundamentalsShort;

  /// No description provided for @navMaterialVersion.
  ///
  /// In en, this message translates to:
  /// **'Material 2 vs 3'**
  String get navMaterialVersion;

  /// No description provided for @navMaterialVersionShort.
  ///
  /// In en, this message translates to:
  /// **'M2/M3'**
  String get navMaterialVersionShort;

  /// No description provided for @navColorScheme.
  ///
  /// In en, this message translates to:
  /// **'ColorScheme'**
  String get navColorScheme;

  /// No description provided for @navColorSchemeShort.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get navColorSchemeShort;

  /// No description provided for @navLegacyColors.
  ///
  /// In en, this message translates to:
  /// **'Legacy colours'**
  String get navLegacyColors;

  /// No description provided for @navLegacyColorsShort.
  ///
  /// In en, this message translates to:
  /// **'Legacy'**
  String get navLegacyColorsShort;

  /// No description provided for @navTextTheme.
  ///
  /// In en, this message translates to:
  /// **'TextTheme'**
  String get navTextTheme;

  /// No description provided for @navTextThemeShort.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get navTextThemeShort;

  /// No description provided for @navTypography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get navTypography;

  /// No description provided for @navTypographyShort.
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get navTypographyShort;

  /// No description provided for @navComponents.
  ///
  /// In en, this message translates to:
  /// **'Component themes'**
  String get navComponents;

  /// No description provided for @navComponentsShort.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get navComponentsShort;

  /// No description provided for @navShapeDensity.
  ///
  /// In en, this message translates to:
  /// **'Shape & density'**
  String get navShapeDensity;

  /// No description provided for @navShapeDensityShort.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get navShapeDensityShort;

  /// No description provided for @navExtensions.
  ///
  /// In en, this message translates to:
  /// **'ThemeExtension'**
  String get navExtensions;

  /// No description provided for @navExtensionsShort.
  ///
  /// In en, this message translates to:
  /// **'Extension'**
  String get navExtensionsShort;

  /// No description provided for @navTransitions.
  ///
  /// In en, this message translates to:
  /// **'Transitions'**
  String get navTransitions;

  /// No description provided for @navTransitionsShort.
  ///
  /// In en, this message translates to:
  /// **'Motion'**
  String get navTransitionsShort;

  /// Navigation labels. The Short variants are used by the narrow navigation rail.
  ///
  /// In en, this message translates to:
  /// **'Export code'**
  String get navExport;

  /// No description provided for @navExportShort.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get navExportShort;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @sections.
  ///
  /// In en, this message translates to:
  /// **'Sections'**
  String get sections;

  /// No description provided for @controlPanel.
  ///
  /// In en, this message translates to:
  /// **'Control panel'**
  String get controlPanel;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset everything'**
  String get resetAll;

  /// No description provided for @groupPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get groupPresets;

  /// No description provided for @groupBasics.
  ///
  /// In en, this message translates to:
  /// **'Basics'**
  String get groupBasics;

  /// No description provided for @groupColour.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get groupColour;

  /// No description provided for @groupTypography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get groupTypography;

  /// No description provided for @groupShapeDensity.
  ///
  /// In en, this message translates to:
  /// **'Shape and density'**
  String get groupShapeDensity;

  /// No description provided for @groupMotion.
  ///
  /// In en, this message translates to:
  /// **'Motion'**
  String get groupMotion;

  /// No description provided for @groupExtension.
  ///
  /// In en, this message translates to:
  /// **'Your own extension'**
  String get groupExtension;

  /// No description provided for @groupLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get groupLanguage;

  /// No description provided for @presetM2.
  ///
  /// In en, this message translates to:
  /// **'Classic M2'**
  String get presetM2;

  /// No description provided for @presetM3.
  ///
  /// In en, this message translates to:
  /// **'Modern M3'**
  String get presetM3;

  /// No description provided for @material2.
  ///
  /// In en, this message translates to:
  /// **'Material 2'**
  String get material2;

  /// No description provided for @material3.
  ///
  /// In en, this message translates to:
  /// **'Material 3'**
  String get material3;

  /// No description provided for @colorSchemeSource.
  ///
  /// In en, this message translates to:
  /// **'ColorScheme source'**
  String get colorSchemeSource;

  /// No description provided for @sourceSeed.
  ///
  /// In en, this message translates to:
  /// **'fromSeed (M3)'**
  String get sourceSeed;

  /// No description provided for @sourceSwatch.
  ///
  /// In en, this message translates to:
  /// **'primarySwatch (M2)'**
  String get sourceSwatch;

  /// No description provided for @sourceBaseline.
  ///
  /// In en, this message translates to:
  /// **'M3 baseline'**
  String get sourceBaseline;

  /// No description provided for @sourceManual.
  ///
  /// In en, this message translates to:
  /// **'manual'**
  String get sourceManual;

  /// No description provided for @legacyOverrides.
  ///
  /// In en, this message translates to:
  /// **'Loose overrides'**
  String get legacyOverrides;

  /// No description provided for @legacyOverridesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'scaffoldBackground, canvas, divider…'**
  String get legacyOverridesSubtitle;

  /// No description provided for @elevationOverlaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'M2 + dark only'**
  String get elevationOverlaySubtitle;

  /// No description provided for @fontFamilyLabel.
  ///
  /// In en, this message translates to:
  /// **'fontFamily'**
  String get fontFamilyLabel;

  /// No description provided for @textThemePreset.
  ///
  /// In en, this message translates to:
  /// **'TextTheme preset'**
  String get textThemePreset;

  /// No description provided for @sizeScale.
  ///
  /// In en, this message translates to:
  /// **'Size scale'**
  String get sizeScale;

  /// No description provided for @letterSpacingDelta.
  ///
  /// In en, this message translates to:
  /// **'letterSpacing (delta)'**
  String get letterSpacingDelta;

  /// No description provided for @lineHeightScale.
  ///
  /// In en, this message translates to:
  /// **'height (multiplier)'**
  String get lineHeightScale;

  /// No description provided for @titleWeight.
  ///
  /// In en, this message translates to:
  /// **'Headline fontWeight'**
  String get titleWeight;

  /// No description provided for @cornerRadius.
  ///
  /// In en, this message translates to:
  /// **'Corner radius'**
  String get cornerRadius;

  /// No description provided for @componentThemes.
  ///
  /// In en, this message translates to:
  /// **'Component themes'**
  String get componentThemes;

  /// No description provided for @componentThemesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Apply the lab\'s sub-themes'**
  String get componentThemesSubtitle;

  /// No description provided for @densityHorizontal.
  ///
  /// In en, this message translates to:
  /// **'horizontal density'**
  String get densityHorizontal;

  /// No description provided for @densityVertical.
  ///
  /// In en, this message translates to:
  /// **'vertical density'**
  String get densityVertical;

  /// No description provided for @tapTargetPadded.
  ///
  /// In en, this message translates to:
  /// **'padded'**
  String get tapTargetPadded;

  /// No description provided for @tapTargetShrink.
  ///
  /// In en, this message translates to:
  /// **'shrink'**
  String get tapTargetShrink;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get followSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @transitionPerPlatform.
  ///
  /// In en, this message translates to:
  /// **'Per platform'**
  String get transitionPerPlatform;

  /// No description provided for @transitionZoom.
  ///
  /// In en, this message translates to:
  /// **'Zoom (Android)'**
  String get transitionZoom;

  /// No description provided for @transitionFadeForwards.
  ///
  /// In en, this message translates to:
  /// **'FadeForwards (M3)'**
  String get transitionFadeForwards;

  /// No description provided for @transitionCupertino.
  ///
  /// In en, this message translates to:
  /// **'Cupertino (iOS)'**
  String get transitionCupertino;

  /// No description provided for @transitionPredictiveBack.
  ///
  /// In en, this message translates to:
  /// **'PredictiveBack'**
  String get transitionPredictiveBack;

  /// No description provided for @fontDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get fontDefault;

  /// No description provided for @presetFramework.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get presetFramework;

  /// No description provided for @presetCompact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get presetCompact;

  /// No description provided for @presetEditorial.
  ///
  /// In en, this message translates to:
  /// **'Editorial'**
  String get presetEditorial;

  /// No description provided for @presetMono.
  ///
  /// In en, this message translates to:
  /// **'Monospaced'**
  String get presetMono;

  /// No description provided for @toggleLightDark.
  ///
  /// In en, this message translates to:
  /// **'Toggle light / dark'**
  String get toggleLightDark;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get codeCopied;

  /// No description provided for @defaultValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultValueLabel;

  /// No description provided for @currentValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get currentValueLabel;

  /// No description provided for @deprecatedBadge.
  ///
  /// In en, this message translates to:
  /// **'deprecated / M2'**
  String get deprecatedBadge;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
