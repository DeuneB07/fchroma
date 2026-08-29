import 'package:flutter/foundation.dart';

// Copy for the "Typography" page.

/// One row of the TextStyle anatomy: the property, its type, what it does.
/// Name and type are API identifiers and stay untranslated inside the record.
typedef TextStyleProperty = ({String name, String type, String description});

@immutable
abstract class TypographyStrings {
  const TypographyStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get baseScaleHeading;
  String get typographyDescription;
  String get typographyDefault;
  String get typographyTip;

  String get blackWhiteHeading;
  String get blackWhiteBody;

  String get familiesHeading;
  String get fontFamilyDescription;
  String get fontFamilyDefault;
  String get fontFamilyTip;
  String get fallbackDescription;

  String get anatomyHeading;
  String get liveExamplesHeading;

  String get onPrimaryHeading;
  String get primaryTextThemeDescription;
  String get primaryTextThemeDefault;
  String get primaryTextThemeTip;

  String get iconsHeading;
  String get iconThemeDescription;
  String get iconThemeDefault;
  String get primaryIconThemeDescription;

  String get defaultTextStyleHeading;
  String get defaultTextStyleBody;
  String get inheritsItalic;
  String get inheritsItalicToo;

  String get accessibilityHeading;
  String get textScalerDescription;
  String get textScalerTip;

  List<TextStyleProperty> get styleProperties;
}

class TypographyStringsEn extends TypographyStrings {
  const TypographyStringsEn();

  @override
  String get badge => 'TYPOGRAPHY';

  @override
  String get title => 'Typography, fonts and icons';

  @override
  String get subtitle =>
      'Where the default sizes come from, how to change the font across the '
      'whole app, and what happens to text on dark backgrounds.';

  @override
  String get baseScaleHeading => 'The base scale';

  @override
  String get typographyDescription =>
      'Defines the starting sizes, weights and spacings of the 15 roles. It '
      'ships three generations: material2021 (M3), material2018 (M2) and '
      'material2014 (M1). It is what applies BEFORE your textTheme.';

  @override
  String get typographyDefault =>
      'material2021 with useMaterial3, material2014 without';

  @override
  String get typographyTip =>
      'material2021 needs the colorScheme in order to colour the styles. That '
      'is why the builder calls Typography.material2021(colorScheme: scheme) '
      'and not the empty constructor.';

  @override
  String get blackWhiteHeading => 'black vs white';

  @override
  String get blackWhiteBody =>
      'A Typography holds TWO complete sets of styles: one with dark text '
      '(black), meant for light backgrounds, and one with light text (white), '
      'for dark ones. Picking the wrong one is the classic "I can\'t read '
      'anything in dark mode" bug.';

  @override
  String get familiesHeading => 'Font families';

  @override
  String get fontFamilyDescription =>
      'Applies one family to ALL the theme\'s styles at once: textTheme, '
      'primaryTextTheme and the component styles. It is the shortcut for "my '
      'whole app uses this font".';

  @override
  String get fontFamilyDefault => 'null (the system font)';

  @override
  String get fontFamilyTip =>
      'The names here (serif, monospace, cursive) are generic aliases resolved '
      'by the operating system, so they work without declaring anything. For a '
      'font of your own you have to declare it in pubspec.yaml or use a '
      'package like google_fonts.';

  @override
  String get fallbackDescription =>
      'Fallback families for when the main one lacks the glyph being painted: '
      'emoji, Chinese, Arabic, mathematical symbols… Without a fallback you '
      'get the empty rectangle (tofu).';

  @override
  String get anatomyHeading => 'Anatomy of a TextStyle';

  @override
  String get liveExamplesHeading => 'Live examples';

  @override
  String get onPrimaryHeading => 'Text on the primary colour';

  @override
  String get primaryTextThemeDescription =>
      'A second set of 15 styles meant for painting ON the primary colour. It '
      'is a relic of Material 2, where the AppBar was always primary and the '
      'text therefore had to be the opposite colour.';

  @override
  String get primaryTextThemeDefault =>
      'derived from textTheme with the onPrimary colour';

  @override
  String get primaryTextThemeTip =>
      'In Material 3 you will almost never need it: the AppBar is surface and '
      'uses the normal textTheme. If you are migrating and the bar\'s text is '
      'invisible, look here.';

  @override
  String get iconsHeading => 'Icons';

  @override
  String get iconThemeDescription =>
      'The default colour, size, opacity, weight, fill and optical grade of '
      'every Icon(). The last three only work with variable icon fonts such as '
      'Material Symbols.';

  @override
  String get iconThemeDefault => 'color: onSurfaceVariant, size: 24';

  @override
  String get primaryIconThemeDescription =>
      'The icon equivalent of primaryTextTheme: the ones painted on surfaces '
      'of the primary colour.';

  @override
  String get defaultTextStyleHeading => 'DefaultTextStyle';

  @override
  String get defaultTextStyleBody =>
      'An unstyled Text() does not read the theme directly: it reads the '
      'nearest [DefaultTextStyle], which the Material/Scaffold fills in with '
      'textTheme.bodyMedium. That is how you can restyle a whole branch '
      'without touching the theme:';

  @override
  String get inheritsItalic => 'I inherit the italics from DefaultTextStyle';

  @override
  String get inheritsItalicToo => 'So do I, declaring nothing';

  @override
  String get accessibilityHeading => 'Text accessibility';

  @override
  String get textScalerDescription =>
      'The USER\'s text size preference, set in the system settings. It is '
      'multiplied ON TOP of your theme: not something you control, something '
      'your design has to withstand.';

  @override
  String get textScalerTip =>
      'Never wrap text in a SizedBox with a fixed height. If the user has '
      'scaling at 200 %, the text will overflow. Use padding and let the '
      'content determine the height.';

  @override
  List<TextStyleProperty> get styleProperties => const <TextStyleProperty>[
    (
      name: 'fontFamily',
      type: 'String?',
      description:
          'Which font is used. It must be declared, or be a system alias.',
    ),
    (
      name: 'fontSize',
      type: 'double?',
      description: 'Size in logical pixels. 14 is the default body size.',
    ),
    (
      name: 'fontWeight',
      type: 'FontWeight?',
      description: 'Weight from w100 to w900. w400 = normal, w700 = bold.',
    ),
    (name: 'fontStyle', type: 'FontStyle?', description: 'normal or italic.'),
    (
      name: 'letterSpacing',
      type: 'double?',
      description: 'Extra space between letters, in pixels. May be negative.',
    ),
    (
      name: 'wordSpacing',
      type: 'double?',
      description: 'Extra space between words.',
    ),
    (
      name: 'height',
      type: 'double?',
      description: 'Line height as a MULTIPLE of fontSize, not in pixels.',
    ),
    (
      name: 'color',
      type: 'Color?',
      description: 'Text colour. Mutually exclusive with foreground.',
    ),
    (
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Colour behind the text, highlighter style.',
    ),
    (
      name: 'decoration',
      type: 'TextDecoration?',
      description: 'underline, lineThrough, overline or none.',
    ),
    (
      name: 'decorationColor',
      type: 'Color?',
      description: 'Colour of that line, if it should differ from the text.',
    ),
    (
      name: 'decorationStyle',
      type: 'TextDecorationStyle?',
      description: 'solid, dotted, dashed, double or wavy.',
    ),
    (
      name: 'decorationThickness',
      type: 'double?',
      description: 'Multiplier for the line\'s thickness.',
    ),
    (
      name: 'shadows',
      type: 'List<Shadow>?',
      description: 'Text shadows. Useful over images.',
    ),
    (
      name: 'overflow',
      type: 'TextOverflow?',
      description: 'clip, fade, ellipsis or visible when it does not fit.',
    ),
    (
      name: 'fontFeatures',
      type: 'List<FontFeature>?',
      description: 'OpenType features: tabular figures, ligatures, small caps.',
    ),
    (
      name: 'fontVariations',
      type: 'List<FontVariation>?',
      description: 'Axes of a variable font: weight, width, optical size.',
    ),
    (
      name: 'leadingDistribution',
      type: 'TextLeadingDistribution?',
      description: 'How leftover line height is split above and below.',
    ),
  ];
}

class TypographyStringsEs extends TypographyStrings {
  const TypographyStringsEs();

  @override
  String get badge => 'TIPOGRAFÍA';

  @override
  String get title => 'Typography, fuentes e iconos';

  @override
  String get subtitle =>
      'De dónde salen los tamaños por defecto, cómo se cambia la fuente de '
      'toda la app y qué pasa con el texto sobre fondos oscuros.';

  @override
  String get baseScaleHeading => 'La escala base';

  @override
  String get typographyDescription =>
      'Define los tamaños, pesos y espaciados de partida de los 15 roles. Trae '
      'tres generaciones: material2021 (M3), material2018 (M2) y material2014 '
      '(M1). Es lo que se aplica ANTES de tu textTheme.';

  @override
  String get typographyDefault =>
      'material2021 si useMaterial3, material2014 si no';

  @override
  String get typographyTip =>
      'material2021 necesita el colorScheme para colorear los estilos. Por eso '
      'en el builder se llama a Typography.material2021(colorScheme: scheme) y '
      'no al constructor vacío.';

  @override
  String get blackWhiteHeading => 'black vs white';

  @override
  String get blackWhiteBody =>
      'Un Typography contiene DOS juegos completos de estilos: uno con texto '
      'oscuro (black), pensado para fondos claros, y otro con texto claro '
      '(white), para fondos oscuros. Elegir el equivocado es el bug clásico de '
      '"no se ve nada en modo oscuro".';

  @override
  String get familiesHeading => 'Familias tipográficas';

  @override
  String get fontFamilyDescription =>
      'Aplica una familia a TODOS los estilos del tema de una vez: textTheme, '
      'primaryTextTheme y los estilos de los componentes. Es el atajo para '
      '"toda mi app usa esta fuente".';

  @override
  String get fontFamilyDefault => 'null (la fuente del sistema)';

  @override
  String get fontFamilyTip =>
      'Los nombres que ves aquí (serif, monospace, cursive) son alias '
      'genéricos que resuelve el sistema operativo, así que funcionan sin '
      'declarar nada. Para una fuente propia hay que declararla en '
      'pubspec.yaml o usar un paquete como google_fonts.';

  @override
  String get fallbackDescription =>
      'Familias de reserva por si la principal no tiene el glifo que toca '
      'pintar: emoji, chino, árabe, símbolos matemáticos... Sin fallback verás '
      'el rectángulo vacío (tofu).';

  @override
  String get anatomyHeading => 'Anatomía de un TextStyle';

  @override
  String get liveExamplesHeading => 'Ejemplos en vivo';

  @override
  String get onPrimaryHeading => 'Texto sobre color primario';

  @override
  String get primaryTextThemeDescription =>
      'Un segundo juego de 15 estilos pensado para pintar SOBRE el color '
      'primario. Es una reliquia de Material 2, donde la AppBar siempre iba de '
      'color primary y por tanto el texto tenía que ser del color contrario.';

  @override
  String get primaryTextThemeDefault =>
      'derivado de textTheme con color onPrimary';

  @override
  String get primaryTextThemeTip =>
      'En Material 3 casi nunca lo necesitarás: la AppBar va de color surface y '
      'usa el textTheme normal. Si estás migrando y ves texto invisible en la '
      'barra, mira aquí.';

  @override
  String get iconsHeading => 'Iconos';

  @override
  String get iconThemeDescription =>
      'Color, tamaño, opacidad, grosor (weight), relleno (fill) y grado óptico '
      'por defecto de todos los Icon(). Los tres últimos solo funcionan con '
      'fuentes de iconos variables como Material Symbols.';

  @override
  String get iconThemeDefault => 'color: onSurfaceVariant, size: 24';

  @override
  String get primaryIconThemeDescription =>
      'El equivalente de primaryTextTheme para iconos: los que se pintan sobre '
      'superficies de color primario.';

  @override
  String get defaultTextStyleHeading => 'DefaultTextStyle';

  @override
  String get defaultTextStyleBody =>
      'Un Text() sin estilo no lee el tema directamente: lee el '
      '[DefaultTextStyle] más cercano, que el Material/Scaffold rellena con '
      'textTheme.bodyMedium. Por eso puedes cambiar el estilo de toda una rama '
      'sin tocar el tema:';

  @override
  String get inheritsItalic => 'Heredo la cursiva del DefaultTextStyle';

  @override
  String get inheritsItalicToo => 'Yo también, sin declarar nada';

  @override
  String get accessibilityHeading => 'Accesibilidad del texto';

  @override
  String get textScalerDescription =>
      'La preferencia de tamaño de letra del USUARIO, definida en los ajustes '
      'del sistema. Se multiplica ENCIMA de tu tema: no es algo que controles, '
      'es algo que tu diseño debe aguantar.';

  @override
  String get textScalerTip =>
      'Nunca uses SizedBox con alturas fijas alrededor de texto. Si el usuario '
      'tiene el escalado al 200 %, el texto se desbordará. Usa padding y deja '
      'que la altura la calcule el contenido.';

  @override
  List<TextStyleProperty> get styleProperties => const <TextStyleProperty>[
    (
      name: 'fontFamily',
      type: 'String?',
      description:
          'Qué fuente se usa. Debe estar declarada o ser un alias del sistema.',
    ),
    (
      name: 'fontSize',
      type: 'double?',
      description: 'Tamaño en píxeles lógicos. 14 es el cuerpo por defecto.',
    ),
    (
      name: 'fontWeight',
      type: 'FontWeight?',
      description: 'Grosor de w100 a w900. w400 = normal, w700 = bold.',
    ),
    (name: 'fontStyle', type: 'FontStyle?', description: 'normal o italic.'),
    (
      name: 'letterSpacing',
      type: 'double?',
      description:
          'Espacio extra entre letras, en píxeles. Puede ser negativo.',
    ),
    (
      name: 'wordSpacing',
      type: 'double?',
      description: 'Espacio extra entre palabras.',
    ),
    (
      name: 'height',
      type: 'double?',
      description: 'Interlineado como MÚLTIPLO del fontSize, no en píxeles.',
    ),
    (
      name: 'color',
      type: 'Color?',
      description: 'Color del texto. Excluyente con foreground.',
    ),
    (
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Color detrás del texto, tipo rotulador.',
    ),
    (
      name: 'decoration',
      type: 'TextDecoration?',
      description: 'underline, lineThrough, overline o none.',
    ),
    (
      name: 'decorationColor',
      type: 'Color?',
      description: 'Color de esa línea, si quieres que difiera del texto.',
    ),
    (
      name: 'decorationStyle',
      type: 'TextDecorationStyle?',
      description: 'solid, dotted, dashed, double o wavy.',
    ),
    (
      name: 'decorationThickness',
      type: 'double?',
      description: 'Multiplicador del grosor de la línea.',
    ),
    (
      name: 'shadows',
      type: 'List<Shadow>?',
      description: 'Sombras del texto. Útil sobre imágenes.',
    ),
    (
      name: 'overflow',
      type: 'TextOverflow?',
      description: 'clip, fade, ellipsis o visible cuando no cabe.',
    ),
    (
      name: 'fontFeatures',
      type: 'List<FontFeature>?',
      description:
          'Características OpenType: cifras tabulares, ligaduras, versalitas.',
    ),
    (
      name: 'fontVariations',
      type: 'List<FontVariation>?',
      description: 'Ejes de una fuente variable: peso, anchura, grado óptico.',
    ),
    (
      name: 'leadingDistribution',
      type: 'TextLeadingDistribution?',
      description: 'Cómo se reparte el interlineado sobrante arriba y abajo.',
    ),
  ];
}
