import 'package:flutter/foundation.dart';

import '../../theme/text_theme_presets.dart';

// Copy for the "TextTheme" page.

/// One of the five style families, with the sizes Material assigns it.
typedef TextFamily = ({String name, String purpose, String sizes});

@immutable
abstract class TextThemeStrings {
  const TextThemeStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get familiesHeading;
  String get rolesLiveHeading;
  String get rolesLiveIntro;
  String get presetsHeading;
  String get transformHeading;
  String get migrationHeading;
  String get whoUsesHeading;

  String get textThemeDescription;
  String get applyDescription;
  String get applyTip;
  String get sizeFactorDescription;
  String get sizeFactorTip;
  String get letterSpacingDescription;
  String get lineHeightDescription;

  /// Filler paragraph whose only job is to be long enough to wrap, so the
  /// line-height slider has something to act on.
  String get lineHeightSample;

  String get fontWeightDescription;
  String get fontWeightTip;

  String get migrationBody;

  /// The five families. A list because they are homogeneous data rendered as
  /// one block; see the note in `material_version_strings.dart`.
  List<TextFamily> get families;

  /// Who actually uses each role inside Flutter.
  ///
  /// A switch rather than 15 getters: exhaustive switches on an enum are
  /// checked by the analyzer just as strictly, and this keeps the note next to
  /// the role it describes.
  String usedBy(TextRoleId role);
}

class TextThemeStringsEn extends TextThemeStrings {
  const TextThemeStringsEn();

  @override
  String get badge => 'TYPOGRAPHY';

  @override
  String get title => 'TextTheme: 15 named styles';

  @override
  String get subtitle =>
      'Material widgets do not pick sizes: they pick ROLES. An AppBar uses '
      'titleLarge, a button uses labelLarge, an unstyled Text() uses '
      'bodyMedium. Change the TextTheme and everything changes.';

  @override
  String get familiesHeading => 'The five families';

  @override
  String get rolesLiveHeading => 'The 15 roles, live';

  @override
  String get rolesLiveIntro =>
      'Each row is painted in its own style from the current theme. Move the '
      'sliders in the control panel and watch them react.';

  @override
  String get presetsHeading => 'Scale presets';

  @override
  String get transformHeading => 'Transforming the scale';

  @override
  String get migrationHeading => 'Name migration, M2 → M3';

  @override
  String get whoUsesHeading => 'Who uses each role';

  @override
  String get textThemeDescription =>
      'The set of 15 styles the widgets will read. The normal thing is NOT to '
      'build it from scratch — you would lose the default colours and heights '
      '— but to start from what Typography gives you and transform that.';

  @override
  String get applyDescription =>
      'The shortcut for transforming all 15 styles at once. It takes '
      'fontFamily, fontSizeFactor (a multiplier), fontSizeDelta (an addition), '
      'bodyColor, displayColor and decoration. It respects styles that are '
      'null, which makes it safer than going one by one.';

  @override
  String get applyTip =>
      'apply() distinguishes bodyColor from displayColor: the first reaches '
      'body/label/title, the second display/headline. That is why you '
      'sometimes change "the text colour" and the headlines ignore you.';

  @override
  String get sizeFactorDescription =>
      'Multiplies the fontSize of all 15 styles. This changes the DESIGN. Do '
      'not confuse it with MediaQuery.textScaler, which is the USER\'s '
      'accessibility preference and is multiplied on top.';

  @override
  String get sizeFactorTip =>
      'Your design has to survive a textScaler of 2.0. Try pushing the '
      'multiplier to its maximum: if something overflows here, it will '
      'overflow on the phone of a user with low vision too.';

  @override
  String get letterSpacingDescription =>
      'EXTRA space between letters, in logical pixels. Material uses it '
      'positive on small labels, to let them breathe, and slightly negative on '
      'the large display styles.';

  @override
  String get lineHeightDescription =>
      'Line height, expressed as a MULTIPLE of fontSize rather than in pixels. '
      'height: 1.5 with fontSize: 16 gives 24 px lines. It is what you notice '
      'most in long text.';

  @override
  String get lineHeightSample =>
      'This paragraph exists so the line height is visible. Once text runs to '
      'several lines, line height governs how dense it feels more than the '
      'font size does. Move the slider and compare.';

  @override
  String get fontWeightDescription =>
      'Stroke weight, from w100 (thin) to w900 (black). w400 is "normal" and '
      'w700 is "bold". Here it is applied to display, headline and title.';

  @override
  String get fontWeightTip =>
      'With a variable font every weight exists. With a static font that only '
      'ships Regular and Bold, the engine SIMULATES the intermediate weights '
      'and they look worse.';

  @override
  String get migrationBody =>
      'The Material 2 names NO LONGER exist in the current SDK. If a tutorial '
      'talks about headline6, this is its translation:';

  @override
  List<TextFamily> get families => const <TextFamily>[
    (
      name: 'display',
      purpose:
          'HUGE single words and numerals. Covers, splash screens, one figure '
          'on a dashboard. Never for paragraphs.',
      sizes: '57 / 45 / 36 sp',
    ),
    (
      name: 'headline',
      purpose:
          'Section headlines. High hierarchy, little text. It is what an '
          'AlertDialog uses for its title in M3.',
      sizes: '32 / 28 / 24 sp',
    ),
    (
      name: 'title',
      purpose:
          'Component titles: AppBar, Card, ListTile. titleLarge is the '
          'AppBar\'s.',
      sizes: '22 / 16 / 14 sp',
    ),
    (
      name: 'body',
      purpose:
          'Running text. 90 % of the real text in an app. bodyMedium is the '
          'default style of Text().',
      sizes: '16 / 14 / 12 sp',
    ),
    (
      name: 'label',
      purpose:
          'Text INSIDE components: buttons, chips, tabs, navigation labels. It '
          'usually carries more letter-spacing.',
      sizes: '14 / 12 / 11 sp',
    ),
  ];

  @override
  String usedBy(TextRoleId role) => switch (role) {
    TextRoleId.displayLarge => 'Giant figures, welcome screens. 57 sp in M3.',
    TextRoleId.displayMedium => 'Covers and heroes. 45 sp.',
    TextRoleId.displaySmall => 'A prominent headline. 36 sp.',
    TextRoleId.headlineLarge => 'Header of a large screen. 32 sp.',
    TextRoleId.headlineMedium => 'Section header. 28 sp.',
    TextRoleId.headlineSmall => 'Dialog title in M3. 24 sp.',
    TextRoleId.titleLarge => 'The AppBar title. AppBar.title reads it. 22 sp.',
    TextRoleId.titleMedium => 'ListTile and Card titles. 16 sp.',
    TextRoleId.titleSmall => 'Subtitles and metadata. 14 sp.',
    TextRoleId.bodyLarge => 'Main text. ListTile.title uses it. 16 sp.',
    TextRoleId.bodyMedium => 'The DEFAULT style of every Text(). 14 sp.',
    TextRoleId.bodySmall => 'Secondary text, captions. 12 sp.',
    TextRoleId.labelLarge => 'Button text. Every *Button reads it. 14 sp.',
    TextRoleId.labelMedium => 'NavigationBar labels and chips. 12 sp.',
    TextRoleId.labelSmall => 'The smallest: badges, overlines. 11 sp.',
  };
}

class TextThemeStringsEs extends TextThemeStrings {
  const TextThemeStringsEs();

  @override
  String get badge => 'TIPOGRAFÍA';

  @override
  String get title => 'TextTheme: 15 estilos con nombre';

  @override
  String get subtitle =>
      'Los widgets de Material no eligen tamaños: eligen ROLES. Un AppBar usa '
      'titleLarge, un botón usa labelLarge, un Text() sin estilo usa '
      'bodyMedium. Cambia el TextTheme y cambia todo.';

  @override
  String get familiesHeading => 'Las cinco familias';

  @override
  String get rolesLiveHeading => 'Los 15 roles, en vivo';

  @override
  String get rolesLiveIntro =>
      'Cada fila se pinta con su propio estilo del tema actual. Toca los '
      'sliders del panel de control para verlos reaccionar.';

  @override
  String get presetsHeading => 'Presets de escala';

  @override
  String get transformHeading => 'Transformar la escala';

  @override
  String get migrationHeading => 'Migración de nombres M2 → M3';

  @override
  String get whoUsesHeading => 'Quién usa cada rol';

  @override
  String get textThemeDescription =>
      'El juego de 15 estilos que usarán los widgets. Lo normal NO es '
      'construirlo desde cero (perderías colores y alturas por defecto), sino '
      'partir del que da Typography y transformarlo.';

  @override
  String get applyDescription =>
      'El atajo para transformar los 15 estilos de golpe. Acepta fontFamily, '
      'fontSizeFactor (multiplicador), fontSizeDelta (suma), bodyColor, '
      'displayColor y decoración. Respeta los estilos que sean null, así que es '
      'más seguro que ir uno a uno.';

  @override
  String get applyTip =>
      'apply() distingue bodyColor y displayColor: el primero afecta a '
      'body/label/title, el segundo a display/headline. Por eso a veces '
      'cambias "el color del texto" y los titulares no se enteran.';

  @override
  String get sizeFactorDescription =>
      'Multiplica el fontSize de los 15 estilos. Esto cambia el DISEÑO. No lo '
      'confundas con MediaQuery.textScaler, que es la preferencia de '
      'accesibilidad del USUARIO y se multiplica encima.';

  @override
  String get sizeFactorTip =>
      'Tu diseño debe sobrevivir a un textScaler de 2.0. Prueba a poner el '
      'multiplicador al máximo: si algo se desborda aquí, se desbordará '
      'también en el móvil de un usuario con baja visión.';

  @override
  String get letterSpacingDescription =>
      'Espacio EXTRA entre letras, en píxeles lógicos. Material lo usa positivo '
      'en las etiquetas pequeñas (para que respiren) y ligeramente negativo en '
      'los display grandes.';

  @override
  String get lineHeightDescription =>
      'El interlineado, expresado como MÚLTIPLO del fontSize (no en píxeles). '
      'height: 1.5 con fontSize: 16 da líneas de 24 px. Es lo que más se nota '
      'en textos largos.';

  @override
  String get lineHeightSample =>
      'Este párrafo existe para que se aprecie el interlineado. Cuando el texto '
      'ocupa varias líneas, la altura de línea manda sobre la sensación de '
      'densidad más que el propio tamaño de fuente. Mueve el slider y '
      'compáralo.';

  @override
  String get fontWeightDescription =>
      'Grosor del trazo, de w100 (thin) a w900 (black). w400 es "normal" y '
      'w700 es "bold". Aquí se aplica a display, headline y title.';

  @override
  String get fontWeightTip =>
      'Si usas una fuente variable, todos los pesos existen. Con una fuente '
      'estática que solo trae Regular y Bold, los pesos intermedios los SIMULA '
      'el motor y quedan peor.';

  @override
  String get migrationBody =>
      'Los nombres de Material 2 ya NO existen en el SDK actual. Si un tutorial '
      'habla de headline6, esta es su traducción:';

  @override
  List<TextFamily> get families => const <TextFamily>[
    (
      name: 'display',
      purpose:
          'Números y palabras sueltas ENORMES. Portadas, splash, una cifra de '
          'dashboard. Nunca para párrafos.',
      sizes: '57 / 45 / 36 sp',
    ),
    (
      name: 'headline',
      purpose:
          'Titulares de sección. Alta jerarquía, poco texto. Es lo que usa un '
          'AlertDialog para su título en M3.',
      sizes: '32 / 28 / 24 sp',
    ),
    (
      name: 'title',
      purpose:
          'Títulos de componentes: AppBar, Card, ListTile. titleLarge es el '
          'del AppBar.',
      sizes: '22 / 16 / 14 sp',
    ),
    (
      name: 'body',
      purpose:
          'Texto corrido. El 90 % del texto real de una app. bodyMedium es el '
          'estilo por defecto de Text().',
      sizes: '16 / 14 / 12 sp',
    ),
    (
      name: 'label',
      purpose:
          'Texto DENTRO de componentes: botones, chips, pestañas, etiquetas de '
          'navegación. Suele llevar más letter-spacing.',
      sizes: '14 / 12 / 11 sp',
    ),
  ];

  @override
  String usedBy(TextRoleId role) => switch (role) {
    TextRoleId.displayLarge =>
      'Cifras gigantes, pantallas de bienvenida. 57 sp en M3.',
    TextRoleId.displayMedium => 'Portadas y héroes. 45 sp.',
    TextRoleId.displaySmall => 'Titular destacado. 36 sp.',
    TextRoleId.headlineLarge => 'Cabecera de pantalla grande. 32 sp.',
    TextRoleId.headlineMedium => 'Cabecera de sección. 28 sp.',
    TextRoleId.headlineSmall => 'Título de diálogo en M3. 24 sp.',
    TextRoleId.titleLarge => 'Título del AppBar. Lo lee AppBar.title. 22 sp.',
    TextRoleId.titleMedium => 'Título de ListTile y de Card. 16 sp.',
    TextRoleId.titleSmall => 'Subtítulos y metadatos. 14 sp.',
    TextRoleId.bodyLarge => 'Texto principal. Lo usa ListTile.title. 16 sp.',
    TextRoleId.bodyMedium => 'El estilo POR DEFECTO de todo Text(). 14 sp.',
    TextRoleId.bodySmall => 'Texto secundario, pies de foto. 12 sp.',
    TextRoleId.labelLarge =>
      'Texto de los botones. Lo leen todos los *Button. 14 sp.',
    TextRoleId.labelMedium => 'Etiquetas de NavigationBar y chips. 12 sp.',
    TextRoleId.labelSmall => 'Lo más pequeño: badges, overlines. 11 sp.',
  };
}
