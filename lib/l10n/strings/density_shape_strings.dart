import 'package:flutter/foundation.dart';

// Copy for the "Shape & density" page.

@immutable
abstract class DensityShapeStrings {
  const DensityShapeStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get densityHeading;
  String get densityDescription;
  String get densityDefault;
  String get densityTip;
  String get adaptiveSwitchTitle;
  String get adaptiveSwitchSubtitle;
  String get axisHorizontal;
  String get axisVertical;
  String get demoButton;
  String get demoChip;
  String get demoCard;
  String get listTileTitle;
  String get listTileSubtitle;

  String get tapTargetHeading;
  String get tapTargetDescription;
  String get tapTargetTip;

  String get shapeHeading;
  String get shapeName;
  String get shapeDescription;
  String get shapeTip;

  String get elevationHeading;
  String get elevationBody;

  String get splashHeading;
  String get splashDescription;
  String get splashDefault;
  String get splashTip;
  String get splashHint;
  String get splashZone;

  String get platformHeading;
  String get platformDescription;
  String get adaptationsDescription;
  String get cupertinoOverrideDescription;
  String get scrollbarDescription;
}

class DensityShapeStringsEn extends DensityShapeStrings {
  const DensityShapeStringsEn();

  @override
  String get badge => 'SPACE AND SHAPE';
  @override
  String get title => 'Density, shape and touch';
  @override
  String get subtitle =>
      'The properties that are neither colour nor text: how much room things '
      'take, what shape they have, and what happens when you touch them.';

  @override
  String get densityHeading => 'VisualDensity';
  @override
  String get densityDescription =>
      'Tightens or loosens the INTERNAL spacing of components. It changes '
      'neither font nor icon sizes: it changes padding. Each unit is worth 4 '
      'logical pixels per side, and the useful range runs from -4.0 to 4.0.';
  @override
  String get densityDefault => 'VisualDensity.standard (0, 0)';
  @override
  String get densityTip =>
      'Predefined values: VisualDensity.standard (0,0), '
      'VisualDensity.comfortable (-1,-1), VisualDensity.compact (-2,-2) and '
      'VisualDensity.adaptivePlatformDensity.';
  @override
  String get adaptiveSwitchTitle => 'Use adaptivePlatformDensity';
  @override
  String get adaptiveSwitchSubtitle =>
      'Compact on desktop, standard on mobile. The right choice for '
      'cross-platform apps.';
  @override
  String get axisHorizontal => 'horizontal';
  @override
  String get axisVertical => 'vertical';
  @override
  String get demoButton => 'Button';
  @override
  String get demoChip => 'Chip';
  @override
  String get demoCard => 'Card';
  @override
  String get listTileTitle => 'ListTile';
  @override
  String get listTileSubtitle => 'Its height depends on the density';

  @override
  String get tapTargetHeading => 'Touch target';
  @override
  String get tapTargetDescription =>
      'padded enforces a minimum tappable area of 48x48 dp even when the '
      'widget is smaller: an accessibility requirement of Material and of both '
      'the Android and iOS guidelines. shrinkWrap leaves the widget at its '
      'natural size, which gives more compact UIs but ones that are harder to '
      'hit with a finger.';
  @override
  String get tapTargetTip =>
      'On desktop, shrinkWrap plus a compact density is common. On mobile, '
      'never go below 48 dp: that is the average width of a finger.';

  @override
  String get shapeHeading => 'Shape';
  @override
  String get shapeName => 'Global shape (simulated)';
  @override
  String get shapeDescription =>
      'ThemeData has NO global "borderRadius" property. Shape is defined '
      'component by component: cardTheme.shape, dialogTheme.shape, the '
      'ButtonStyle\'s shape… Here we apply the same radius to all of them to '
      'simulate such a global property.';
  @override
  String get shapeTip =>
      'A pattern that works very well: define a constant with your radii '
      '(small: 8, medium: 16, large: 28) and a function that builds the '
      'ThemeData from it. That keeps the design system in one place.';

  @override
  String get elevationHeading => 'Elevation';
  @override
  String get elevationBody =>
      'Material 2 communicated height with SHADOWS alone. Material 3 mostly '
      'does it by tinting the surface with surfaceTint: the higher the '
      'elevation, the stronger the tint. That is why an M3 Card at elevation 1 '
      'looks like a different colour rather than something "floating".';

  @override
  String get splashHeading => 'Touch feedback';
  @override
  String get splashDescription =>
      'The ink animation on press. Material 3 uses InkSparkle (a glow that '
      'fades out); Material 2 used InkRipple (a circular wave). NoSplash '
      'removes it entirely.';
  @override
  String get splashDefault => 'InkSparkle in M3, InkRipple in M2';
  @override
  String get splashTip =>
      'NoSplash is common in desktop apps, where the ripple feels out of '
      'place. Apps imitating an iOS style without giving up Material widgets '
      'use it too.';
  @override
  String get splashHint => 'Press and hold below to see the effect:';
  @override
  String get splashZone => 'Press zone';

  @override
  String get platformHeading => 'Platform and adaptation';
  @override
  String get platformDescription =>
      'Lies to Flutter about which system it is running on. It changes page '
      'transitions, scroll behaviour (iOS bounce vs Android overscroll glow), '
      'the "back" icons and the text selection menus. Very handy for checking '
      'the iOS look from a PC.';
  @override
  String get adaptationsDescription =>
      'A mechanism for making one theme type behave differently per platform. '
      'For instance an Adaptation<SwitchThemeData> that returns an iOS-like '
      'appearance only on iOS and macOS, without duplicating the whole theme.';
  @override
  String get cupertinoOverrideDescription =>
      'Cupertino widgets that appear inside a MaterialApp (a '
      'CupertinoAlertDialog, say) derive their style from the Material theme. '
      'This property lets you correct that derivation.';
  @override
  String get scrollbarDescription =>
      'Thickness, radius, margins, per-state colours and visibility of the '
      'scrollbar. On desktop and web it is one of the first things you will '
      'want to adjust, because the default looks very thin.';
}

class DensityShapeStringsEs extends DensityShapeStrings {
  const DensityShapeStringsEs();

  @override
  String get badge => 'ESPACIO Y FORMA';
  @override
  String get title => 'Densidad, forma y tacto';
  @override
  String get subtitle =>
      'Las propiedades que no son color ni texto: cuánto ocupan las cosas, qué '
      'forma tienen y qué pasa cuando las tocas.';

  @override
  String get densityHeading => 'VisualDensity';
  @override
  String get densityDescription =>
      'Aprieta o afloja el espaciado INTERNO de los componentes. No cambia '
      'tamaños de fuente ni de icono: cambia padding. Cada unidad equivale a 4 '
      'píxeles lógicos por lado, y el rango útil va de -4.0 a 4.0.';
  @override
  String get densityDefault => 'VisualDensity.standard (0, 0)';
  @override
  String get densityTip =>
      'Valores predefinidos: VisualDensity.standard (0,0), '
      'VisualDensity.comfortable (-1,-1), VisualDensity.compact (-2,-2) y '
      'VisualDensity.adaptivePlatformDensity.';
  @override
  String get adaptiveSwitchTitle => 'Usar adaptivePlatformDensity';
  @override
  String get adaptiveSwitchSubtitle =>
      'Compacto en desktop, estándar en móvil. Lo correcto para apps '
      'multiplataforma.';
  @override
  String get axisHorizontal => 'horizontal';
  @override
  String get axisVertical => 'vertical';
  @override
  String get demoButton => 'Botón';
  @override
  String get demoChip => 'Chip';
  @override
  String get demoCard => 'Card';
  @override
  String get listTileTitle => 'ListTile';
  @override
  String get listTileSubtitle => 'Su altura depende de la densidad';

  @override
  String get tapTargetHeading => 'Área táctil';
  @override
  String get tapTargetDescription =>
      'padded fuerza un área pulsable mínima de 48x48 dp aunque el widget sea '
      'más pequeño: es un requisito de accesibilidad de Material y de las guías '
      'de Android e iOS. shrinkWrap deja el widget a su tamaño natural, lo que '
      'da UIs más compactas pero más difíciles de acertar con el dedo.';
  @override
  String get tapTargetTip =>
      'En desktop es habitual usar shrinkWrap + densidad compacta. En móvil, '
      'nunca bajes de 48 dp: es la anchura media de un dedo.';

  @override
  String get shapeHeading => 'Forma';
  @override
  String get shapeName => 'Forma global (simulada)';
  @override
  String get shapeDescription =>
      'ThemeData NO tiene una propiedad "borderRadius" global. La forma se '
      'define componente a componente: cardTheme.shape, dialogTheme.shape, el '
      'shape del ButtonStyle... Aquí aplicamos el mismo radio a todos para '
      'simular esa propiedad global.';
  @override
  String get shapeTip =>
      'Un patrón que funciona muy bien: definir una constante con tus radios '
      '(small: 8, medium: 16, large: 28) y una función que construya el '
      'ThemeData a partir de ella. Así el sistema de diseño queda en un solo '
      'sitio.';

  @override
  String get elevationHeading => 'Elevación';
  @override
  String get elevationBody =>
      'Material 2 comunicaba la altura solo con SOMBRAS. Material 3 lo hace '
      'sobre todo tiñendo la superficie con surfaceTint: cuanto más elevado, '
      'más tinte. Por eso una Card de M3 con elevación 1 parece de otro color, '
      'no "flotando".';

  @override
  String get splashHeading => 'Feedback táctil';
  @override
  String get splashDescription =>
      'La animación de "tinta" al pulsar. Material 3 usa InkSparkle (un '
      'destello que se difumina); Material 2 usaba InkRipple (una onda '
      'circular). NoSplash la elimina del todo.';
  @override
  String get splashDefault => 'InkSparkle en M3, InkRipple en M2';
  @override
  String get splashTip =>
      'NoSplash es habitual en apps de escritorio, donde el ripple se siente '
      'fuera de lugar. También lo usan las apps que imitan un estilo iOS sin '
      'renunciar a los widgets de Material.';
  @override
  String get splashHint => 'Pulsa aquí abajo y mantén para ver el efecto:';
  @override
  String get splashZone => 'Zona de pulsación';

  @override
  String get platformHeading => 'Plataforma y adaptación';
  @override
  String get platformDescription =>
      'Miente a Flutter sobre en qué sistema se está ejecutando. Cambia las '
      'transiciones de página, el comportamiento del scroll (rebote de iOS vs '
      'efecto de sobre-scroll de Android), los iconos de "atrás" y los menús de '
      'selección de texto. Muy útil para probar el look de iOS desde un PC.';
  @override
  String get adaptationsDescription =>
      'Mecanismo para que un tipo del tema se comporte distinto según la '
      'plataforma. Por ejemplo, una Adaptation<SwitchThemeData> que devuelva un '
      'aspecto tipo iOS solo en iOS y macOS, sin duplicar todo el tema.';
  @override
  String get cupertinoOverrideDescription =>
      'Los widgets de Cupertino que aparezcan dentro de un MaterialApp (un '
      'CupertinoAlertDialog, por ejemplo) derivan su estilo del tema de '
      'Material. Esta propiedad permite corregir esa derivación.';
  @override
  String get scrollbarDescription =>
      'Grosor, radio, márgenes, colores por estado y visibilidad de la barra de '
      'scroll. En desktop y web es de las primeras cosas que querrás ajustar, '
      'porque el default se ve muy fino.';
}
