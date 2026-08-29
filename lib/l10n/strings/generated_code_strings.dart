import 'package:flutter/foundation.dart';

// Copy for the "Export" page.

/// A tool recommendation. The name is a product or package name and is never
/// translated.
typedef ToolEntry = ({String name, String description});

@immutable
abstract class GeneratedCodeStrings {
  const GeneratedCodeStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get generatedHeading;
  String get howToUseHeading;
  String get structureHeading;
  String get structureIntro;
  String get structureLabel;
  String get closingRule;

  String get checklistHeading;
  List<String> get checklist;

  String get toolsHeading;
  List<ToolEntry> get tools;
}

class GeneratedCodeStringsEn extends GeneratedCodeStrings {
  const GeneratedCodeStringsEn();

  @override
  String get badge => 'EXPORT';
  @override
  String get title => 'Your theme, as code';
  @override
  String get subtitle =>
      'Everything you touched in the control panel, translated into Dart ready '
      'to paste into your project.';

  @override
  String get generatedHeading => 'The generated ThemeData';
  @override
  String get howToUseHeading => 'How to use it';
  @override
  String get structureHeading => 'A recommended structure';
  @override
  String get structureIntro => 'How to organise the theme in a real project:';
  @override
  String get structureLabel => 'structure';
  @override
  String get closingRule =>
      'The rule that sums it all up: if a colour or a size is written by hand '
      'inside a screen, it is a bug waiting for somebody to ask for dark mode.';

  @override
  String get checklistHeading => 'A checklist';

  @override
  List<String> get checklist => const <String>[
    'The light and dark themes are built by the SAME function.',
    'No screen contains a hand-written Color(0xFF...).',
    'No Text() has a hand-written fontSize: they all use a TextTheme role.',
    'Every background colour is used with its paired "on".',
    'The design survives a textScaler of 2.0 without overflowing.',
    'Touch targets are at least 48x48 dp on mobile.',
    'Colours Material does not cover (success, warning) live in a '
        'ThemeExtension.',
    'Radii and spacings come from constants, not loose numbers.',
    'The app has been tested with system animations turned off.',
    'It has been tested in high contrast and with the system dark theme.',
  ];

  @override
  String get toolsHeading => 'Useful tools';

  @override
  List<ToolEntry> get tools => const <ToolEntry>[
    (
      name: 'Material Theme Builder',
      description:
          'Google\'s official tool. Generate the palette from a seed and '
          'export the complete ColorScheme for Flutter.',
    ),
    (
      name: 'flex_color_scheme',
      description:
          'The most used theming package: dozens of ready-made schemes and a '
          'great deal of control over the component themes.',
    ),
    (
      name: 'google_fonts',
      description:
          'Google fonts without adding assets. Careful: by default it '
          'downloads them at runtime.',
    ),
    (
      name: 'Flutter DevTools',
      description:
          'The inspector tab shows the resolved ThemeData of any widget: the '
          'fastest way to find out where a colour comes from.',
    ),
    (
      name: 'dynamic_color',
      description:
          'Reads the palette from the user\'s wallpaper (Material You) on '
          'Android 12+.',
    ),
  ];
}

class GeneratedCodeStringsEs extends GeneratedCodeStrings {
  const GeneratedCodeStringsEs();

  @override
  String get badge => 'EXPORTAR';
  @override
  String get title => 'Tu tema, en código';
  @override
  String get subtitle =>
      'Todo lo que has tocado en el panel de control, traducido a Dart listo '
      'para pegar en tu proyecto.';

  @override
  String get generatedHeading => 'ThemeData generado';
  @override
  String get howToUseHeading => 'Cómo usarlo';
  @override
  String get structureHeading => 'Estructura recomendada';
  @override
  String get structureIntro => 'Cómo organizar el tema en un proyecto real:';
  @override
  String get structureLabel => 'estructura';
  @override
  String get closingRule =>
      'La regla que lo resume todo: si un color o un tamaño aparece escrito a '
      'mano dentro de una pantalla, es un bug esperando a que alguien pida modo '
      'oscuro.';

  @override
  String get checklistHeading => 'Lista de comprobación';

  @override
  List<String> get checklist => const <String>[
    'El tema claro y el oscuro se construyen con la MISMA función.',
    'Ninguna pantalla contiene un Color(0xFF...) escrito a mano.',
    'Ningún Text() tiene fontSize escrito a mano: todos usan un rol del '
        'TextTheme.',
    'Cada color de fondo se usa con su "on" emparejado.',
    'El diseño aguanta un textScaler de 2.0 sin desbordarse.',
    'Las áreas táctiles miden al menos 48x48 dp en móvil.',
    'Los colores que Material no cubre (success, warning) están en una '
        'ThemeExtension.',
    'Los radios y espaciados salen de constantes, no de números sueltos.',
    'Se ha probado la app con las animaciones del sistema desactivadas.',
    'Se ha probado en alto contraste y con el tema oscuro del sistema.',
  ];

  @override
  String get toolsHeading => 'Herramientas útiles';

  @override
  List<ToolEntry> get tools => const <ToolEntry>[
    (
      name: 'Material Theme Builder',
      description:
          'La herramienta oficial de Google. Generas la paleta desde una '
          'semilla y exportas el ColorScheme completo para Flutter.',
    ),
    (
      name: 'flex_color_scheme',
      description:
          'El paquete más usado para temas: decenas de esquemas listos y '
          'muchísimo control sobre los component themes.',
    ),
    (
      name: 'google_fonts',
      description:
          'Fuentes de Google sin añadir assets. Ojo: por defecto las descarga '
          'en tiempo de ejecución.',
    ),
    (
      name: 'Flutter DevTools',
      description:
          'La pestaña de inspección muestra el ThemeData resuelto de cualquier '
          'widget: la forma más rápida de saber de dónde sale un color.',
    ),
    (
      name: 'dynamic_color',
      description:
          'Lee la paleta del fondo de pantalla del usuario (Material You) en '
          'Android 12+.',
    ),
  ];
}
