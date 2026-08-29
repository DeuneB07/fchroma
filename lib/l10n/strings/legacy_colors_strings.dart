import 'package:flutter/foundation.dart';

// Copy for the "Legacy colours" page.
//
// The property names themselves (`scaffoldBackgroundColor`, `canvasColor`, and
// the fallbacks like `colorScheme.outlineVariant`) stay in the page: they are
// API identifiers. Only the explanations live here.

@immutable
abstract class LegacyColorsStrings {
  const LegacyColorsStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get ruleOfThumb;
  String get applyOverridesTitle;
  String get applyOverridesSubtitle;
  String get notApplied;

  String get backgroundsHeading;
  String get scaffoldBackgroundDescription;
  String get canvasDescription;
  String get cardColorDescription;

  String get dividersHeading;
  String get dividerDescription;
  String get aboveDivider;
  String get belowDivider;

  String get interactionHeading;
  String get disabledDescription;
  String get disabledFallback;
  String get disabledDemoLabel;
  String get hintDescription;
  String get hintDemoText;
  String get inkStatesDescription;
  String get inkStatesTip;

  String get shadowsHeading;
  String get shadowDescription;
  String get shadowFallback;

  String get removedHeading;
  String get removedDescription;
  String get primaryColorDescription;
  String get primarySwatchDescription;

  String get swatchScaleHeading;
  String get swatchScaleBody;
}

class LegacyColorsStringsEn extends LegacyColorsStrings {
  const LegacyColorsStringsEn();

  @override
  String get badge => 'M2 LEGACY';

  @override
  String get title => 'ThemeData\'s loose colours';

  @override
  String get subtitle =>
      'Before the ColorScheme, ThemeData had one property per colour. Many are '
      'still alive and still take priority over the scheme. Knowing them is '
      'unavoidable when debugging an inherited theme.';

  @override
  String get ruleOfThumb =>
      'Rule of thumb: do NOT use these properties in new code. Configure the '
      'colorScheme alone and let the widgets derive from it. They are exposed '
      'here so you can see exactly what each one affects and recognise them in '
      'an older project.';

  @override
  String get applyOverridesTitle => 'Apply the loose overrides';

  @override
  String get applyOverridesSubtitle =>
      'Turn it on and watch which parts of the app stop following the '
      'ColorScheme';

  @override
  String get notApplied => 'not applied';

  @override
  String get backgroundsHeading => 'Backgrounds';

  @override
  String get scaffoldBackgroundDescription =>
      'The background of EVERY Scaffold in the app. Left as null, '
      'colorScheme.surface is used. It is the legacy property still most in '
      'use, because sometimes you do want a background distinct from the cards.';

  @override
  String get canvasDescription =>
      'The background of "canvases": Drawer, DropdownButton menus, and any '
      'Material without an explicit colour.';

  @override
  String get cardColorDescription =>
      'The background of Cards. Material 3 ignores it: cardTheme.color wins, '
      'and failing that colorScheme.surfaceContainerLow.';

  @override
  String get dividersHeading => 'Lines and separators';

  @override
  String get dividerDescription =>
      'The colour of Divider and VerticalDivider, and also of DataTable '
      'borders, the TabBar underline and ListTiles with a divider.';

  @override
  String get aboveDivider => 'Above the divider';

  @override
  String get belowDivider => 'Below the divider';

  @override
  String get interactionHeading => 'Interaction states';

  @override
  String get disabledDescription =>
      'The colour disabled widgets are painted with. In M3 most components use '
      'onSurface at 38 % opacity instead, defined in their own defaults.';

  @override
  String get disabledFallback => 'onSurface at 38 %';

  @override
  String get disabledDemoLabel => 'Disabled';

  @override
  String get hintDescription =>
      'The colour of a text field\'s hintText — the placeholder that '
      'disappears once you type.';

  @override
  String get hintDemoText => 'This is the hintText';

  @override
  String get inkStatesDescription =>
      'The four state colours of the classic InkWell: keyboard focus, mouse '
      'hover, held down, and the ink wave itself. Material 3 replaces them '
      'with WidgetStateProperty on each component theme, which is far more '
      'precise.';

  @override
  String get inkStatesTip =>
      'The modern equivalent: ButtonStyle(overlayColor: '
      'WidgetStateProperty.resolveWith((states) => ...)), where you can return '
      'a different colour for each WidgetState.';

  @override
  String get shadowsHeading => 'Shadows and elevation';

  @override
  String get shadowDescription =>
      'The colour of the shadow elevated widgets cast. Material 3 shadows are '
      'much subtler, because elevation is mostly communicated with the surface '
      'tint instead.';

  @override
  String get shadowFallback => 'colorScheme.shadow (black)';

  @override
  String get removedHeading => 'Removed from the SDK';

  @override
  String get removedDescription =>
      'All REMOVED. If a tutorial or an old project uses them, it will not '
      'compile. Their replacements: accentColor → colorScheme.secondary, '
      'backgroundColor → colorScheme.surface, errorColor → colorScheme.error, '
      'toggleableActiveColor → the Checkbox/Radio/Switch themes.';

  @override
  String get primaryColorDescription =>
      'They still exist, but practically no M3 widget reads them. They are '
      'derived automatically from primarySwatch when you use it. Set them by '
      'hand with M3 on and you will be surprised how little changes.';

  @override
  String get primarySwatchDescription =>
      'The classic Material 2 approach: a colour with 10 shades (50, 100, '
      '200 … 900). primaryColor, primaryColorLight, primaryColorDark and an '
      'approximate ColorScheme came out of it. It still works, but it does not '
      'generate M3\'s tonal roles (containers, fixed), so with useMaterial3 on '
      'some components look washed out.';

  @override
  String get swatchScaleHeading => 'The scale of a MaterialColor';

  @override
  String get swatchScaleBody =>
      'A MaterialColor is a Color with 10 variants reachable by index. Shade '
      '500 is the "base colour". Material 2 built the whole theme from this '
      'scale; Material 3 replaced it with the 13-step tonal palettes the HCT '
      'algorithm generates.';
}

class LegacyColorsStringsEs extends LegacyColorsStrings {
  const LegacyColorsStringsEs();

  @override
  String get badge => 'HERENCIA M2';

  @override
  String get title => 'Los colores sueltos de ThemeData';

  @override
  String get subtitle =>
      'Antes del ColorScheme, ThemeData tenía una propiedad por cada color. '
      'Muchas siguen vivas y tienen prioridad sobre el esquema. Conocerlas es '
      'imprescindible para depurar temas heredados.';

  @override
  String get ruleOfThumb =>
      'Regla práctica: en código nuevo NO uses estas propiedades. Configura '
      'solo el colorScheme y deja que los widgets deriven de él. Aquí las '
      'exponemos para que veas exactamente a qué afecta cada una y puedas '
      'reconocerlas en un proyecto antiguo.';

  @override
  String get applyOverridesTitle => 'Aplicar los overrides sueltos';

  @override
  String get applyOverridesSubtitle =>
      'Actívalo y observa qué partes de la app dejan de seguir al ColorScheme';

  @override
  String get notApplied => 'no aplicado';

  @override
  String get backgroundsHeading => 'Fondos';

  @override
  String get scaffoldBackgroundDescription =>
      'El fondo de TODOS los Scaffold de la app. Si lo dejas en null, se usa '
      'colorScheme.surface. Es la propiedad legacy que más se sigue '
      'utilizando, porque a veces quieres un fondo distinto del de las '
      'tarjetas.';

  @override
  String get canvasDescription =>
      'El fondo de los "lienzos": Drawer, menús desplegables de DropdownButton '
      'y cualquier Material sin color explícito.';

  @override
  String get cardColorDescription =>
      'El fondo de las Card. En Material 3 lo ignoran: mandan cardTheme.color '
      'y, en su defecto, colorScheme.surfaceContainerLow.';

  @override
  String get dividersHeading => 'Líneas y separadores';

  @override
  String get dividerDescription =>
      'El color de Divider y VerticalDivider, y también de los bordes de '
      'DataTable, de la línea inferior de TabBar y de los ListTile con divisor.';

  @override
  String get aboveDivider => 'Encima del divisor';

  @override
  String get belowDivider => 'Debajo del divisor';

  @override
  String get interactionHeading => 'Estados de interacción';

  @override
  String get disabledDescription =>
      'El color con el que se pintan los widgets deshabilitados. En M3 la '
      'mayoría de componentes usan en su lugar onSurface con un 38 % de '
      'opacidad, definido en sus propios defaults.';

  @override
  String get disabledFallback => 'onSurface al 38 %';

  @override
  String get disabledDemoLabel => 'Deshabilitado';

  @override
  String get hintDescription =>
      'El color del hintText de los campos de texto (el placeholder que '
      'desaparece al escribir).';

  @override
  String get hintDemoText => 'Este es el hintText';

  @override
  String get inkStatesDescription =>
      'Los cuatro colores de estado del InkWell clásico: cuando el widget '
      'tiene el foco de teclado, cuando el ratón está encima, cuando se '
      'mantiene pulsado y el color de la onda de tinta. En Material 3 se '
      'sustituyen por WidgetStateProperty en cada component theme, que es '
      'mucho más preciso.';

  @override
  String get inkStatesTip =>
      'El equivalente moderno: ButtonStyle(overlayColor: '
      'WidgetStateProperty.resolveWith((states) => ...)), donde puedes '
      'devolver un color distinto por cada WidgetState.';

  @override
  String get shadowsHeading => 'Sombras y elevación';

  @override
  String get shadowDescription =>
      'El color de la sombra que proyectan los widgets elevados. En Material 3 '
      'las sombras son mucho más sutiles porque la elevación se comunica sobre '
      'todo con el tinte de superficie.';

  @override
  String get shadowFallback => 'colorScheme.shadow (negro)';

  @override
  String get removedHeading => 'Retiradas del SDK';

  @override
  String get removedDescription =>
      'Todas ELIMINADAS. Si un tutorial o un proyecto viejo las usa, no '
      'compilará. Sus sustitutos: accentColor → colorScheme.secondary, '
      'backgroundColor → colorScheme.surface, errorColor → colorScheme.error, '
      'toggleableActiveColor → los themes de Checkbox/Radio/Switch.';

  @override
  String get primaryColorDescription =>
      'Siguen existiendo pero prácticamente ningún widget de M3 los lee. Se '
      'derivan automáticamente del primarySwatch cuando lo usas. Si los pones '
      'a mano con M3 activo, te sorprenderá lo poco que cambia.';

  @override
  String get primarySwatchDescription =>
      'La forma clásica de Material 2: un color con 10 tonos (50, 100, '
      '200 … 900). De él salían primaryColor, primaryColorLight, '
      'primaryColorDark y un ColorScheme aproximado. Sigue funcionando, pero '
      'no genera los roles tonales de M3 (containers, fixed), así que con '
      'useMaterial3 algunos componentes se ven apagados.';

  @override
  String get swatchScaleHeading => 'La escala de un MaterialColor';

  @override
  String get swatchScaleBody =>
      'Un MaterialColor es un Color con 10 variantes accesibles por índice. El '
      'tono 500 es el "color base". Material 2 construía todo el tema a partir '
      'de esta escala; Material 3 la sustituyó por las paletas tonales de 13 '
      'pasos que genera el algoritmo HCT.';
}
