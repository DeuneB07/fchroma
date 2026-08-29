import 'package:flutter/foundation.dart';

// Copy for the "Component themes" page.

/// One entry of the sub-theme catalogue. `property` and `type` are API
/// identifiers and stay identical in every language; only `description` is
/// translated.
typedef ComponentThemeEntry = ({
  String property,
  String type,
  String description,
});

@immutable
abstract class ComponentThemesStrings {
  const ComponentThemesStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get applySwitchTitle;
  String get applySwitchSubtitle;

  String get patternHeading;
  String get widgetStateHeading;
  String get widgetStateBody;
  String get widgetStateHint;
  String get hoverMeLabel;
  String get normalState;

  String get catalogueHeading;
  String get catalogueIntro;

  String get liveHeading;
  String get centerTitleDescription;
  String get centerTitleDefault;
  String get elevationDescription;
  String get elevationDefault;

  String get galleryHeading;
  String get galleryIntro;

  List<ComponentThemeEntry> get catalogue;
}

class ComponentThemesStringsEn extends ComponentThemesStrings {
  const ComponentThemesStringsEn();

  @override
  String get badge => 'COMPONENTS';

  @override
  String get title => 'Component themes';

  @override
  String get subtitle =>
      'ThemeData has around 50 sub-themes, one per widget family. They all '
      'follow the same pattern: XxxThemeData with the same property names as '
      'the Xxx widget.';

  @override
  String get applySwitchTitle => 'Apply the lab\'s component themes';

  @override
  String get applySwitchSubtitle =>
      'Turn it off to see Material\'s own defaults with no customisation at all';

  @override
  String get patternHeading => 'The pattern';

  @override
  String get widgetStateHeading => 'WidgetStateProperty';

  @override
  String get widgetStateBody =>
      'A button does not have ONE colour: it has a colour per state. '
      'WidgetStateProperty<T> is a function that receives the set of active '
      'states and returns the value that applies. It used to be called '
      'MaterialStateProperty; it was renamed so it could be used outside '
      'Material too.';

  @override
  String get widgetStateHint =>
      'Try it: hover over the button and hold it down.';

  @override
  String get hoverMeLabel => 'Hover over me';

  @override
  String get normalState => '(normal state)';

  @override
  String get catalogueHeading => 'Catalogue of sub-themes';

  @override
  String get catalogueIntro =>
      'The most common sub-themes. Every one of them is a named parameter of '
      'the ThemeData constructor.';

  @override
  String get liveHeading => 'Live settings';

  @override
  String get centerTitleDescription =>
      'Centres the AppBar title. In Material 3 the default is false (left '
      'aligned); on iOS and in Material 2 centring it was the norm.';

  @override
  String get centerTitleDefault => 'false on Android, true on iOS';

  @override
  String get elevationDescription =>
      'The first is the resting shadow (0 in M3: bars are flat). The second is '
      'the elevation while content is scrolled UNDERNEATH the bar, which is '
      'what makes it tint itself on scroll.';

  @override
  String get elevationDefault => '0.0 and 3.0 in M3; 4.0 in M2';

  @override
  String get galleryHeading => 'The full showcase';

  @override
  String get galleryIntro =>
      'All of these widgets are painted purely from what the theme says. '
      'Change any option in the control panel and watch them react.';

  @override
  List<ComponentThemeEntry> get catalogue => const <ComponentThemeEntry>[
    (
      property: 'appBarTheme',
      type: 'AppBarThemeData',
      description: 'Colour, elevation, centring, height, title style and icons of the top bar.',
    ),
    (
      property: 'cardTheme',
      type: 'CardThemeData',
      description:
          'Elevation, shape, margin, colour and surface tint of Cards.',
    ),
    (
      property: 'elevatedButtonTheme',
      type: 'ElevatedButtonThemeData',
      description: 'The default ButtonStyle for ElevatedButtons.',
    ),
    (
      property: 'filledButtonTheme',
      type: 'FilledButtonThemeData',
      description: 'The same for FilledButton and FilledButton.tonal. M3 only.',
    ),
    (
      property: 'outlinedButtonTheme',
      type: 'OutlinedButtonThemeData',
      description: 'The same for OutlinedButton, border colour included.',
    ),
    (
      property: 'textButtonTheme',
      type: 'TextButtonThemeData',
      description: 'The same for TextButton.',
    ),
    (
      property: 'iconButtonTheme',
      type: 'IconButtonThemeData',
      description: 'IconButtons and their filled, tonal and outlined variants.',
    ),
    (
      property: 'segmentedButtonTheme',
      type: 'SegmentedButtonThemeData',
      description: 'The M3 segmented selector.',
    ),
    (
      property: 'floatingActionButtonTheme',
      type: 'FloatingActionButtonThemeData',
      description: 'Colour, shape, elevation and size of the FAB.',
    ),
    (
      property: 'inputDecorationTheme',
      type: 'InputDecorationThemeData',
      description: 'EVERYTHING visual about TextFields: fill, per-state borders, padding, label, hint and error styles.',
    ),
    (
      property: 'textSelectionTheme',
      type: 'TextSelectionThemeData',
      description:
          'Colour of the cursor, the selected text and the selection handles.',
    ),
    (
      property: 'chipTheme',
      type: 'ChipThemeData',
      description: 'Every kind of Chip: filter, choice, action, input.',
    ),
    (
      property: 'dialogTheme',
      type: 'DialogThemeData',
      description: 'Shape, elevation, colour and text styles of dialogs.',
    ),
    (
      property: 'bottomSheetTheme',
      type: 'BottomSheetThemeData',
      description:
          'Shape, colour, elevation and maximum size of bottom sheets.',
    ),
    (
      property: 'snackBarTheme',
      type: 'SnackBarThemeData',
      description: 'Behaviour (fixed/floating), shape, colours and width.',
    ),
    (
      property: 'tooltipTheme',
      type: 'TooltipThemeData',
      description: 'Decoration, appearance delay, duration and position.',
    ),
    (
      property: 'dividerTheme',
      type: 'DividerThemeData',
      description:
          'Colour, thickness, space occupied and indents of the Divider.',
    ),
    (
      property: 'listTileTheme',
      type: 'ListTileThemeData',
      description: 'Padding, shape, density, icon and text colours.',
    ),
    (
      property: 'navigationBarTheme',
      type: 'NavigationBarThemeData',
      description: 'The M3 bottom bar: indicator, labels and height.',
    ),
    (
      property: 'navigationRailTheme',
      type: 'NavigationRailThemeData',
      description: 'The side rail for wide screens.',
    ),
    (
      property: 'navigationDrawerTheme',
      type: 'NavigationDrawerThemeData',
      description: 'The M3 side menu.',
    ),
    (
      property: 'drawerTheme',
      type: 'DrawerThemeData',
      description: 'The classic Drawer: colour, shape, width and elevation.',
    ),
    (
      property: 'tabBarTheme',
      type: 'TabBarThemeData',
      description: 'Indicator, label colours and divider of the tabs.',
    ),
    (
      property: 'checkboxTheme / radioTheme / switchTheme',
      type: 'XxxThemeData',
      description:
          'The selection controls, with WidgetStateProperty for each state.',
    ),
    (
      property: 'sliderTheme',
      type: 'SliderThemeData',
      description: 'The largest API of them all: track, thumb, ticks, value label and their shapes.',
    ),
    (
      property: 'progressIndicatorTheme',
      type: 'ProgressIndicatorThemeData',
      description: 'Colour, thickness and background colour of the indicators.',
    ),
    (
      property: 'dataTableTheme',
      type: 'DataTableThemeData',
      description: 'Row heights, heading and data styles, per-state colours.',
    ),
    (
      property: 'datePickerTheme / timePickerTheme',
      type: 'XxxThemeData',
      description: 'The date and time pickers, down to the last detail.',
    ),
    (
      property: 'menuTheme / menuBarTheme / menuButtonTheme',
      type: 'XxxThemeData',
      description: 'The desktop menus introduced in M3.',
    ),
    (
      property: 'dropdownMenuTheme',
      type: 'DropdownMenuThemeData',
      description:
          'The M3 DropdownMenu, which combines a text field and a menu.',
    ),
    (
      property: 'searchBarTheme / searchViewTheme',
      type: 'XxxThemeData',
      description: 'The M3 search bar and its expanded view.',
    ),
    (
      property: 'badgeTheme',
      type: 'BadgeThemeData',
      description: 'The little red counters over icons.',
    ),
    (
      property: 'bannerTheme',
      type: 'MaterialBannerThemeData',
      description: 'The persistent notice banner.',
    ),
    (
      property: 'expansionTileTheme',
      type: 'ExpansionTileThemeData',
      description: 'Colours and padding of collapsible rows.',
    ),
    (
      property: 'scrollbarTheme',
      type: 'ScrollbarThemeData',
      description:
          'Thickness, radius, visibility and colours of the scrollbar.',
    ),
    (
      property: 'carouselViewTheme',
      type: 'CarouselViewThemeData',
      description: 'The M3 expressive carousel.',
    ),
    (
      property: 'toggleButtonsTheme',
      type: 'ToggleButtonsThemeData',
      description: 'The M2 group of toggleable buttons.',
    ),
    (
      property: 'bottomNavigationBarTheme',
      type: 'BottomNavigationBarThemeData',
      description: 'The M2 bottom bar. In M3 use navigationBarTheme.',
    ),
    (
      property: 'bottomAppBarTheme',
      type: 'BottomAppBarThemeData',
      description: 'The bottom bar with a notch for the FAB.',
    ),
    (
      property: 'popupMenuTheme',
      type: 'PopupMenuThemeData',
      description: 'The three-dot context menu.',
    ),
    (
      property: 'actionIconTheme',
      type: 'ActionIconThemeData',
      description:
          'Lets you replace the "back", "close" and "menu" icons globally.',
    ),
  ];
}

class ComponentThemesStringsEs extends ComponentThemesStrings {
  const ComponentThemesStringsEs();

  @override
  String get badge => 'COMPONENTES';

  @override
  String get title => 'Component themes';

  @override
  String get subtitle =>
      'ThemeData tiene unos 50 sub-temas, uno por familia de widget. Todos '
      'siguen el mismo patrón: XxxThemeData con los mismos nombres de '
      'propiedad que el widget Xxx.';

  @override
  String get applySwitchTitle => 'Aplicar los component themes del laboratorio';

  @override
  String get applySwitchSubtitle =>
      'Desactívalo para ver los valores por defecto de Material sin ninguna '
      'personalización';

  @override
  String get patternHeading => 'El patrón';

  @override
  String get widgetStateHeading => 'WidgetStateProperty';

  @override
  String get widgetStateBody =>
      'Un botón no tiene UN color: tiene un color por estado. '
      'WidgetStateProperty<T> es una función que recibe el conjunto de estados '
      'activos y devuelve el valor que toca. Antes se llamaba '
      'MaterialStateProperty; se renombró para que también sirviera fuera de '
      'Material.';

  @override
  String get widgetStateHint =>
      'Pruébalo: pasa el ratón por encima y mantén pulsado.';

  @override
  String get hoverMeLabel => 'Pásame el ratón';

  @override
  String get normalState => '(estado normal)';

  @override
  String get catalogueHeading => 'Catálogo de sub-temas';

  @override
  String get catalogueIntro =>
      'Los sub-temas más habituales. Todos van como parámetro con nombre del '
      'constructor de ThemeData.';

  @override
  String get liveHeading => 'Ajustes en vivo';

  @override
  String get centerTitleDescription =>
      'Centra el título de la AppBar. En Material 3 el valor por defecto es '
      'false (alineado a la izquierda); en iOS y en Material 2 lo habitual era '
      'centrarlo.';

  @override
  String get centerTitleDefault => 'false en Android, true en iOS';

  @override
  String get elevationDescription =>
      'La primera es la sombra en reposo (0 en M3: las barras son planas). La '
      'segunda es la elevación cuando hay contenido desplazado POR DEBAJO de '
      'la barra, que es lo que hace que se tiña al hacer scroll.';

  @override
  String get elevationDefault => '0.0 y 3.0 en M3; 4.0 en M2';

  @override
  String get galleryHeading => 'Muestrario completo';

  @override
  String get galleryIntro =>
      'Todos estos widgets se pintan solo con lo que dice el tema. Cambia '
      'cualquier opción del panel de control y observa la reacción.';

  @override
  List<ComponentThemeEntry> get catalogue => const <ComponentThemeEntry>[
    (
      property: 'appBarTheme',
      type: 'AppBarThemeData',
      description: 'Color, elevación, centrado, altura, estilo del título e iconos de la barra superior.',
    ),
    (
      property: 'cardTheme',
      type: 'CardThemeData',
      description:
          'Elevación, forma, margen, color y tinte de superficie de las Card.',
    ),
    (
      property: 'elevatedButtonTheme',
      type: 'ElevatedButtonThemeData',
      description: 'El ButtonStyle por defecto de los ElevatedButton.',
    ),
    (
      property: 'filledButtonTheme',
      type: 'FilledButtonThemeData',
      description: 'Ídem para FilledButton y FilledButton.tonal. Solo M3.',
    ),
    (
      property: 'outlinedButtonTheme',
      type: 'OutlinedButtonThemeData',
      description: 'Ídem para OutlinedButton, incluido el color del borde.',
    ),
    (
      property: 'textButtonTheme',
      type: 'TextButtonThemeData',
      description: 'Ídem para TextButton.',
    ),
    (
      property: 'iconButtonTheme',
      type: 'IconButtonThemeData',
      description: 'Los IconButton y sus variantes filled, tonal y outlined.',
    ),
    (
      property: 'segmentedButtonTheme',
      type: 'SegmentedButtonThemeData',
      description: 'El selector segmentado de M3.',
    ),
    (
      property: 'floatingActionButtonTheme',
      type: 'FloatingActionButtonThemeData',
      description: 'Color, forma, elevación y tamaño del FAB.',
    ),
    (
      property: 'inputDecorationTheme',
      type: 'InputDecorationThemeData',
      description: 'TODO lo visual de los TextField: relleno, bordes por estado, padding, estilos de label, hint y error.',
    ),
    (
      property: 'textSelectionTheme',
      type: 'TextSelectionThemeData',
      description: 'Color del cursor, del texto seleccionado y de los manejadores de selección.',
    ),
    (
      property: 'chipTheme',
      type: 'ChipThemeData',
      description: 'Todos los tipos de Chip: filter, choice, action, input.',
    ),
    (
      property: 'dialogTheme',
      type: 'DialogThemeData',
      description:
          'Forma, elevación, color y estilos de texto de los diálogos.',
    ),
    (
      property: 'bottomSheetTheme',
      type: 'BottomSheetThemeData',
      description:
          'Forma, color, elevación y tamaño máximo de los bottom sheets.',
    ),
    (
      property: 'snackBarTheme',
      type: 'SnackBarThemeData',
      description: 'Comportamiento (fixed/floating), forma, colores y anchura.',
    ),
    (
      property: 'tooltipTheme',
      type: 'TooltipThemeData',
      description: 'Decoración, retardo de aparición, duración y posición.',
    ),
    (
      property: 'dividerTheme',
      type: 'DividerThemeData',
      description: 'Color, grosor, espacio ocupado y sangrías del Divider.',
    ),
    (
      property: 'listTileTheme',
      type: 'ListTileThemeData',
      description: 'Padding, forma, densidad, colores de icono y de texto.',
    ),
    (
      property: 'navigationBarTheme',
      type: 'NavigationBarThemeData',
      description: 'La barra inferior de M3: indicador, etiquetas y altura.',
    ),
    (
      property: 'navigationRailTheme',
      type: 'NavigationRailThemeData',
      description: 'El carril lateral para pantallas anchas.',
    ),
    (
      property: 'navigationDrawerTheme',
      type: 'NavigationDrawerThemeData',
      description: 'El menú lateral de M3.',
    ),
    (
      property: 'drawerTheme',
      type: 'DrawerThemeData',
      description: 'El Drawer clásico: color, forma, anchura y elevación.',
    ),
    (
      property: 'tabBarTheme',
      type: 'TabBarThemeData',
      description: 'Indicador, colores de etiqueta y divisor de las pestañas.',
    ),
    (
      property: 'checkboxTheme / radioTheme / switchTheme',
      type: 'XxxThemeData',
      description: 'Los controles de selección, con WidgetStateProperty para cada estado.',
    ),
    (
      property: 'sliderTheme',
      type: 'SliderThemeData',
      description: 'La API más extensa: pista, pulgar, marcas, etiqueta de valor y sus formas.',
    ),
    (
      property: 'progressIndicatorTheme',
      type: 'ProgressIndicatorThemeData',
      description: 'Color, grosor y color de fondo de los indicadores.',
    ),
    (
      property: 'dataTableTheme',
      type: 'DataTableThemeData',
      description: 'Alturas de fila, estilos de cabecera y de datos, colores por estado.',
    ),
    (
      property: 'datePickerTheme / timePickerTheme',
      type: 'XxxThemeData',
      description: 'Los selectores de fecha y hora, hasta el último detalle.',
    ),
    (
      property: 'menuTheme / menuBarTheme / menuButtonTheme',
      type: 'XxxThemeData',
      description: 'Los menús de escritorio introducidos en M3.',
    ),
    (
      property: 'dropdownMenuTheme',
      type: 'DropdownMenuThemeData',
      description: 'El DropdownMenu de M3, que combina campo de texto y menú.',
    ),
    (
      property: 'searchBarTheme / searchViewTheme',
      type: 'XxxThemeData',
      description: 'La barra de búsqueda de M3 y su vista expandida.',
    ),
    (
      property: 'badgeTheme',
      type: 'BadgeThemeData',
      description: 'Los contadores rojos sobre los iconos.',
    ),
    (
      property: 'bannerTheme',
      type: 'MaterialBannerThemeData',
      description: 'El banner persistente de avisos.',
    ),
    (
      property: 'expansionTileTheme',
      type: 'ExpansionTileThemeData',
      description: 'Colores y padding de las filas plegables.',
    ),
    (
      property: 'scrollbarTheme',
      type: 'ScrollbarThemeData',
      description:
          'Grosor, radio, visibilidad y colores de la barra de scroll.',
    ),
    (
      property: 'carouselViewTheme',
      type: 'CarouselViewThemeData',
      description: 'El carrusel de M3 expressive.',
    ),
    (
      property: 'toggleButtonsTheme',
      type: 'ToggleButtonsThemeData',
      description: 'El grupo de botones alternables de M2.',
    ),
    (
      property: 'bottomNavigationBarTheme',
      type: 'BottomNavigationBarThemeData',
      description: 'La barra inferior de M2. En M3 usa navigationBarTheme.',
    ),
    (
      property: 'bottomAppBarTheme',
      type: 'BottomAppBarThemeData',
      description: 'La barra inferior con muesca para el FAB.',
    ),
    (
      property: 'popupMenuTheme',
      type: 'PopupMenuThemeData',
      description: 'El menú contextual de los tres puntos.',
    ),
    (
      property: 'actionIconTheme',
      type: 'ActionIconThemeData',
      description: 'Permite sustituir los iconos de "atrás", "cerrar" y "menú" globalmente.',
    ),
  ];
}
