import 'package:flutter/foundation.dart';

// Copy for the "ColorScheme" page.
//
// The bulk of this file is one usage note per colour role. They are explicit
// getters rather than a Map keyed by role name, and that is the whole point:
// a map would turn a forgotten translation into a runtime null, while a
// missing getter here fails to compile.
//
// Role names themselves (`primary`, `onSurfaceVariant`, `surfaceContainerHigh`)
// never appear in this file. They are API identifiers and the page prints them
// verbatim in every language.

@immutable
abstract class ColorSchemeStrings {
  const ColorSchemeStrings();

  // ── Page header and generation section ─────────────────────────────────
  String get badge;
  String get title;
  String get subtitle;

  String get generationHeading;
  String get seedDescription;
  String get variantDescription;
  String get variantTip;
  String get contrastDescription;
  String get contrastTip;

  // ── The colour + "on" rule ─────────────────────────────────────────────
  String get pairingHeading;
  String get pairingBody;

  // ── Role group headings and descriptions ───────────────────────────────
  String get primaryHeading;
  String get primaryGroupDescription;
  String get secondaryHeading;
  String get secondaryGroupDescription;
  String get tertiaryHeading;
  String get tertiaryGroupDescription;
  String get errorHeading;
  String get errorGroupDescription;
  String get surfacesHeading;
  String get surfacesGroupDescription;
  String get outlinesHeading;
  String get outlinesGroupDescription;

  // ── Retired roles and the code section ─────────────────────────────────
  String get retiredHeading;
  String get retiredDescription;
  String get codeHeading;

  // ── Per-role usage notes ───────────────────────────────────────────────
  String get rolePrimary;
  String get roleOnPrimary;
  String get rolePrimaryContainer;
  String get roleOnPrimaryContainer;
  String get rolePrimaryFixed;
  String get rolePrimaryFixedDim;
  String get roleOnPrimaryFixed;
  String get roleOnPrimaryFixedVariant;
  String get roleInversePrimary;

  String get roleSecondary;
  String get roleOnSecondary;
  String get roleSecondaryContainer;
  String get roleOnSecondaryContainer;
  String get roleSecondaryFixed;
  String get roleSecondaryFixedDim;
  String get roleOnSecondaryFixed;
  String get roleOnSecondaryFixedVariant;

  String get roleTertiary;
  String get roleOnTertiary;
  String get roleTertiaryContainer;
  String get roleOnTertiaryContainer;
  String get roleTertiaryFixed;
  String get roleTertiaryFixedDim;
  String get roleOnTertiaryFixed;
  String get roleOnTertiaryFixedVariant;

  String get roleError;
  String get roleOnError;
  String get roleErrorContainer;
  String get roleOnErrorContainer;

  String get roleSurface;
  String get roleOnSurface;
  String get roleOnSurfaceVariant;
  String get roleSurfaceDim;
  String get roleSurfaceBright;
  String get roleSurfaceContainerLowest;
  String get roleSurfaceContainerLow;
  String get roleSurfaceContainer;
  String get roleSurfaceContainerHigh;
  String get roleSurfaceContainerHighest;
  String get roleSurfaceTint;
  String get roleInverseSurface;
  String get roleOnInverseSurface;

  String get roleOutline;
  String get roleOutlineVariant;
  String get roleShadow;
  String get roleScrim;
}

class ColorSchemeStringsEn extends ColorSchemeStrings {
  const ColorSchemeStringsEn();

  @override
  String get badge => 'COLOUR';

  @override
  String get title => 'ColorScheme: the semantic palette';

  @override
  String get subtitle =>
      'Do not think "blue": think "primary". Widgets read roles, not colours. '
      'Swapping the scheme recolours the entire app without touching a single '
      'screen.';

  @override
  String get generationHeading => 'How it is generated';

  @override
  String get seedDescription =>
      'The input colour for Material\'s HCT algorithm. It does NOT necessarily '
      'end up as "primary": Flutter moves it into HCT colour space, extracts '
      'five tonal palettes (primary, secondary, tertiary, neutral and neutral '
      'variant) and derives the 45 roles from those, with contrast guaranteed.';

  @override
  String get variantDescription =>
      'The algorithm\'s "character": how much saturation it keeps, how much '
      'contrast there is between roles, and how far the secondary and tertiary '
      'accents drift from the seed.';

  @override
  String get variantTip =>
      'tonalSpot is the Material You standard. fidelity and content keep your '
      'brand colour almost exactly as given — those are the ones you want when '
      'your design lead insists on the precise hex value.';

  @override
  String get contrastDescription =>
      'From -1.0 (low contrast) to 1.0 (high contrast), with 0.0 as the '
      'standard. It widens the luminance gap between each colour and its '
      'matching "on" colour.';

  @override
  String get contrastTip =>
      'Wire it to MediaQuery.highContrastOf(context) to follow the system '
      'accessibility setting automatically.';

  @override
  String get pairingHeading => 'The golden rule: a colour and its "on"';

  @override
  String get pairingBody =>
      'Every background role has a paired "on" role, which is the colour that '
      'stays legible ON TOP of it. Paint a container with primary and the text '
      'goes in onPrimary. Never mix pairs: that is exactly where contrast and '
      'accessibility break.';

  @override
  String get primaryHeading => 'Primary accent';

  @override
  String get primaryGroupDescription =>
      'The app\'s main action colour. Used by FilledButton, '
      'FloatingActionButton, the active Switch, the tab indicator and the text '
      'field cursor.';

  @override
  String get secondaryHeading => 'Secondary accent';

  @override
  String get secondaryGroupDescription =>
      'A supporting accent, less loud. Selected FilterChip, elements that '
      'accompany without competing with the main action.';

  @override
  String get tertiaryHeading => 'Tertiary accent';

  @override
  String get tertiaryGroupDescription =>
      'The big addition in M3. No widget uses it by default: it is there for '
      'YOU to build contrast and balance with, or to distinguish content '
      'inside a product (categories, tags).';

  @override
  String get errorHeading => 'Error';

  @override
  String get errorGroupDescription =>
      'The ONLY semantic state role Material ships. There is no "success" and '
      'no "warning": if you need them, you will have to add them with a '
      'ThemeExtension.';

  @override
  String get surfacesHeading => 'Surfaces';

  @override
  String get surfacesGroupDescription =>
      'The scale of backgrounds. In M3 elevation is no longer expressed with '
      'shadows alone: it is expressed by moving up a surface level. The '
      '"higher" an element sits, the higher the container it uses.';

  @override
  String get outlinesHeading => 'Outlines and shadows';

  @override
  String get outlinesGroupDescription =>
      'The utility roles. outline is the visible border; outlineVariant is a '
      'much fainter separator.';

  @override
  String get retiredHeading => 'Retired roles';

  @override
  String get retiredDescription =>
      'These existed in the first versions of M3 and are deprecated. '
      'background merged into surface, onBackground into onSurface, and '
      'surfaceVariant was replaced by surfaceContainerHighest. If you see them '
      'in an older tutorial, now you know why they do not compile.';

  @override
  String get codeHeading => 'The equivalent code';

  @override
  String get rolePrimary => 'Main action, FAB, FilledButton';
  @override
  String get roleOnPrimary => 'Text and icons on primary';
  @override
  String get rolePrimaryContainer =>
      'The soft version: selected chips, highlighted cards';
  @override
  String get roleOnPrimaryContainer => 'Content on primaryContainer';
  @override
  String get rolePrimaryFixed =>
      'Identical in light and dark: useful for shared elements';
  @override
  String get rolePrimaryFixedDim => 'A dimmer variant of primaryFixed';
  @override
  String get roleOnPrimaryFixed => 'Maximum contrast on the fixed roles';
  @override
  String get roleOnPrimaryFixedVariant => 'Medium contrast on the fixed roles';
  @override
  String get roleInversePrimary => 'Primary, legible on inverseSurface';

  @override
  String get roleSecondary => 'Supporting accent';
  @override
  String get roleOnSecondary => 'On secondary';
  @override
  String get roleSecondaryContainer => 'The NavigationBar indicator in M3';
  @override
  String get roleOnSecondaryContainer => 'On secondaryContainer';
  @override
  String get roleSecondaryFixed => 'Constant across modes';
  @override
  String get roleSecondaryFixedDim => 'Dimmer variant';
  @override
  String get roleOnSecondaryFixed => 'On the fixed roles';
  @override
  String get roleOnSecondaryFixedVariant => 'Medium contrast';

  @override
  String get roleTertiary => 'A third accent, free for your own design';
  @override
  String get roleOnTertiary => 'On tertiary';
  @override
  String get roleTertiaryContainer => 'The soft version';
  @override
  String get roleOnTertiaryContainer => 'On tertiaryContainer';
  @override
  String get roleTertiaryFixed => 'Constant across modes';
  @override
  String get roleTertiaryFixedDim => 'Dimmer variant';
  @override
  String get roleOnTertiaryFixed => 'On the fixed roles';
  @override
  String get roleOnTertiaryFixedVariant => 'Medium contrast';

  @override
  String get roleError => 'Invalid TextField border, error text';
  @override
  String get roleOnError => 'On error';
  @override
  String get roleErrorContainer => 'Soft banners and warnings';
  @override
  String get roleOnErrorContainer => 'On errorContainer';

  @override
  String get roleSurface => 'Default background of Scaffold, Card and AppBar';
  @override
  String get roleOnSurface => 'Primary text';
  @override
  String get roleOnSurfaceVariant =>
      'Secondary text and icons. Replaces using opacity';
  @override
  String get roleSurfaceDim => 'The darkest background in the scale';
  @override
  String get roleSurfaceBright => 'The lightest background in the scale';
  @override
  String get roleSurfaceContainerLowest => 'Container level 0';
  @override
  String get roleSurfaceContainerLow => 'Level 1';
  @override
  String get roleSurfaceContainer => 'Level 2: the default container';
  @override
  String get roleSurfaceContainerHigh => 'Level 3: dialogs, menus';
  @override
  String get roleSurfaceContainerHighest => 'Level 4: the most elevated';
  @override
  String get roleSurfaceTint =>
      'The tint M3 applies according to elevation (usually = primary)';
  @override
  String get roleInverseSurface => 'Inverted background: SnackBar and Tooltip';
  @override
  String get roleOnInverseSurface => 'On inverseSurface';

  @override
  String get roleOutline => 'Border of OutlinedButton and TextField';
  @override
  String get roleOutlineVariant => 'Dividers and discreet separators';
  @override
  String get roleShadow => 'Colour of the cast shadow';
  @override
  String get roleScrim => 'The dark veil behind dialogs and drawers';
}

class ColorSchemeStringsEs extends ColorSchemeStrings {
  const ColorSchemeStringsEs();

  @override
  String get badge => 'COLOR';

  @override
  String get title => 'ColorScheme: la paleta semántica';

  @override
  String get subtitle =>
      'No pienses en "azul": piensa en "primary". Los widgets leen roles, no '
      'colores. Cambiar el esquema recolorea la app entera sin tocar una sola '
      'pantalla.';

  @override
  String get generationHeading => 'Cómo se genera';

  @override
  String get seedDescription =>
      'El color de entrada del algoritmo HCT de Material. NO acaba siendo '
      'necesariamente "primary": Flutter lo lleva al espacio de color HCT, '
      'extrae cinco paletas tonales (primaria, secundaria, terciaria, neutra y '
      'neutra variante) y de ahí saca los 45 roles con contrastes garantizados.';

  @override
  String get variantDescription =>
      'El "carácter" del algoritmo: cuánta saturación conserva, cuánto '
      'contraste hay entre roles y cómo de lejos se van los acentos secundario '
      'y terciario respecto de la semilla.';

  @override
  String get variantTip =>
      'tonalSpot es el estándar de Material You. fidelity y content respetan tu '
      'color de marca casi tal cual: son los que quieres si tu jefe de diseño '
      'exige el hexadecimal exacto.';

  @override
  String get contrastDescription =>
      'De -1.0 (contraste bajo) a 1.0 (contraste alto), con 0.0 como valor '
      'estándar. Sube la separación de luminancia entre cada color y su "on" '
      'correspondiente.';

  @override
  String get contrastTip =>
      'Enlázalo con MediaQuery.highContrastOf(context) para respetar '
      'automáticamente el ajuste de accesibilidad del sistema.';

  @override
  String get pairingHeading => 'La regla de oro: color + su "on"';

  @override
  String get pairingBody =>
      'Cada rol de fondo tiene un rol "on" emparejado, que es el color legible '
      'ENCIMA de él. Si pintas un contenedor con primary, el texto va en '
      'onPrimary. Nunca mezcles parejas: ahí es donde se rompe el contraste y '
      'la accesibilidad.';

  @override
  String get primaryHeading => 'Acento primario';

  @override
  String get primaryGroupDescription =>
      'El color de acción principal de la app. Lo usan FilledButton, '
      'FloatingActionButton, el Switch activo, el indicador de las pestañas y '
      'el cursor de los campos de texto.';

  @override
  String get secondaryHeading => 'Acento secundario';

  @override
  String get secondaryGroupDescription =>
      'Acento de apoyo, menos llamativo. FilterChip seleccionado, elementos que '
      'acompañan sin competir con la acción principal.';

  @override
  String get tertiaryHeading => 'Acento terciario';

  @override
  String get tertiaryGroupDescription =>
      'La gran novedad de M3. No lo usa ningún widget por defecto: está ahí '
      'para que TÚ crees contrastes y equilibrios, o para destacar contenido '
      'dentro de un producto (categorías, tags).';

  @override
  String get errorHeading => 'Error';

  @override
  String get errorGroupDescription =>
      'El ÚNICO rol semántico de estado que trae Material. No hay "success" ni '
      '"warning": si los necesitas, tendrás que añadirlos con una '
      'ThemeExtension.';

  @override
  String get surfacesHeading => 'Superficies';

  @override
  String get surfacesGroupDescription =>
      'La escala de fondos. En M3 la elevación ya no se expresa solo con '
      'sombras: se expresa cambiando de nivel de superficie. Cuanto más "alto" '
      'está un elemento, más contenedor usa.';

  @override
  String get outlinesHeading => 'Bordes y sombras';

  @override
  String get outlinesGroupDescription =>
      'Los roles utilitarios. outline es el borde visible; outlineVariant, un '
      'separador muy tenue.';

  @override
  String get retiredHeading => 'Roles retirados';

  @override
  String get retiredDescription =>
      'Existían en las primeras versiones de M3 y están obsoletos. background '
      'se fusionó con surface, onBackground con onSurface, y surfaceVariant se '
      'sustituyó por surfaceContainerHighest. Si los ves en un tutorial '
      'antiguo, ya sabes por qué no compilan.';

  @override
  String get codeHeading => 'Código equivalente';

  @override
  String get rolePrimary => 'Acción principal, FAB, FilledButton';
  @override
  String get roleOnPrimary => 'Texto e iconos sobre primary';
  @override
  String get rolePrimaryContainer =>
      'Versión suave: chips seleccionados, tarjetas destacadas';
  @override
  String get roleOnPrimaryContainer => 'Contenido sobre primaryContainer';
  @override
  String get rolePrimaryFixed =>
      'Igual en claro y oscuro: útil para elementos compartidos';
  @override
  String get rolePrimaryFixedDim => 'Variante más apagada de primaryFixed';
  @override
  String get roleOnPrimaryFixed => 'Máximo contraste sobre los fixed';
  @override
  String get roleOnPrimaryFixedVariant => 'Contraste medio sobre los fixed';
  @override
  String get roleInversePrimary => 'Primary legible sobre inverseSurface';

  @override
  String get roleSecondary => 'Acento de apoyo';
  @override
  String get roleOnSecondary => 'Sobre secondary';
  @override
  String get roleSecondaryContainer => 'Indicador de NavigationBar en M3';
  @override
  String get roleOnSecondaryContainer => 'Sobre secondaryContainer';
  @override
  String get roleSecondaryFixed => 'Constante entre modos';
  @override
  String get roleSecondaryFixedDim => 'Variante apagada';
  @override
  String get roleOnSecondaryFixed => 'Sobre los fixed';
  @override
  String get roleOnSecondaryFixedVariant => 'Contraste medio';

  @override
  String get roleTertiary => 'Tercer acento, libre para tu diseño';
  @override
  String get roleOnTertiary => 'Sobre tertiary';
  @override
  String get roleTertiaryContainer => 'Versión suave';
  @override
  String get roleOnTertiaryContainer => 'Sobre tertiaryContainer';
  @override
  String get roleTertiaryFixed => 'Constante entre modos';
  @override
  String get roleTertiaryFixedDim => 'Variante apagada';
  @override
  String get roleOnTertiaryFixed => 'Sobre los fixed';
  @override
  String get roleOnTertiaryFixedVariant => 'Contraste medio';

  @override
  String get roleError => 'Borde de TextField inválido, texto de error';
  @override
  String get roleOnError => 'Sobre error';
  @override
  String get roleErrorContainer => 'Banners y avisos suaves';
  @override
  String get roleOnErrorContainer => 'Sobre errorContainer';

  @override
  String get roleSurface => 'Fondo por defecto de Scaffold, Card y AppBar';
  @override
  String get roleOnSurface => 'Texto principal';
  @override
  String get roleOnSurfaceVariant =>
      'Texto e iconos secundarios. Sustituye a la opacidad';
  @override
  String get roleSurfaceDim => 'El fondo más oscuro de la escala';
  @override
  String get roleSurfaceBright => 'El fondo más claro de la escala';
  @override
  String get roleSurfaceContainerLowest => 'Nivel 0 de contenedor';
  @override
  String get roleSurfaceContainerLow => 'Nivel 1';
  @override
  String get roleSurfaceContainer => 'Nivel 2: el contenedor por defecto';
  @override
  String get roleSurfaceContainerHigh => 'Nivel 3: diálogos, menús';
  @override
  String get roleSurfaceContainerHighest => 'Nivel 4: lo más elevado';
  @override
  String get roleSurfaceTint =>
      'El tinte que M3 aplica según la elevación (suele ser = primary)';
  @override
  String get roleInverseSurface => 'Fondo invertido: SnackBar y Tooltip';
  @override
  String get roleOnInverseSurface => 'Sobre inverseSurface';

  @override
  String get roleOutline => 'Borde de OutlinedButton y TextField';
  @override
  String get roleOutlineVariant => 'Divisores y separadores discretos';
  @override
  String get roleShadow => 'Color de la sombra proyectada';
  @override
  String get roleScrim => 'El velo oscuro tras diálogos y drawers';
}
