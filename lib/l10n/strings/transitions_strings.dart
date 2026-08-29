import 'package:flutter/foundation.dart';

// Copy for the "Transitions" page.

/// One of the lerp helpers listed on the page. The name is an API identifier.
typedef LerpEntry = ({String name, String description});

@immutable
abstract class TransitionsStrings {
  const TransitionsStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get routeHeading;
  String get routeDescription;
  String get routeDefault;
  String get routeTip;
  String get navigateButton;

  String get themeAnimationHeading;
  String get durationDescription;
  String get durationDefault;
  String get durationTip;
  String get toggleButton;
  String get curveDescription;
  String get styleDescription;

  String get lerpHeading;
  String get lerpIntro;
  List<LerpEntry> get lerpEntries;

  String get accessibilityHeading;
  String get disableAnimationsDescription;
  String get disableAnimationsTip;

  String get demoRouteTitle;
  String get demoRouteBody;
  String get demoRouteHint;
  String get backButton;
}

class TransitionsStringsEn extends TransitionsStrings {
  const TransitionsStringsEn();

  @override
  String get badge => 'MOTION';
  @override
  String get title => 'Transitions and animation';
  @override
  String get subtitle =>
      'The theme also defines how the app MOVES: how a new screen enters, and '
      'how one theme blends into another.';

  @override
  String get routeHeading => 'PageTransitionsTheme';
  @override
  String get routeDescription =>
      'A TargetPlatform → PageTransitionsBuilder map. It is keyed per platform '
      'because the usual goal is each system\'s native animation: a lateral '
      'slide on iOS, a zoom on Android.';
  @override
  String get routeDefault => 'Zoom on Android, Cupertino on iOS and macOS';
  @override
  String get routeTip =>
      'The transition only applies to MaterialPageRoute (and to go_router '
      'routes built on it). A PageRouteBuilder with its own transitionsBuilder '
      'ignores the theme.';
  @override
  String get navigateButton => 'Navigate to a new screen';

  @override
  String get themeAnimationHeading => 'The theme-change animation';
  @override
  String get durationDescription =>
      'When you change theme, Flutter does not snap: it INTERPOLATES between '
      'the old ThemeData and the new one, property by property, using each '
      'type\'s lerp method. Here you decide how long that blend lasts.';
  @override
  String get durationDefault => 'kThemeAnimationDuration (200 ms)';
  @override
  String get durationTip =>
      'Set it to 0 ms for instant changes, or raise it to 1500 to watch, in '
      'slow motion, colours, radii and spacings interpolating at once.';
  @override
  String get toggleButton => 'Switch light / dark and watch';
  @override
  String get curveDescription =>
      'The easing curve of that blend. Material recommends Curves.easeInOut '
      'for state changes and the emphasized curves for motion that should draw '
      'attention.';
  @override
  String get styleDescription =>
      'Bundles duration and curve into one object. AnimationStyle.noAnimation '
      'disables the transition entirely, which is what you want when a system '
      'setting is what triggered the theme change.';

  @override
  String get lerpHeading => 'The widgets that animate the theme';
  @override
  String get lerpIntro =>
      'Theme interpolation works because almost every Flutter type knows how '
      'to blend with itself. These are the ones doing the work:';

  @override
  List<LerpEntry> get lerpEntries => const <LerpEntry>[
    (
      name: 'ThemeData.lerp',
      description:
          'Interpolates two complete themes. It is what AnimatedTheme uses '
          'internally.',
    ),
    (name: 'ColorScheme.lerp', description: 'Blends the 45 roles one by one.'),
    (
      name: 'TextTheme.lerp',
      description: 'Blends the 15 styles: size, weight, colour, spacing.',
    ),
    (
      name: 'Color.lerp',
      description: 'Interpolates in colour space, channel by channel.',
    ),
    (
      name: 'ShapeBorder.lerp',
      description:
          'Lets you go from one radius to another, or circle to rectangle.',
    ),
    (
      name: 'EdgeInsets.lerp / BorderRadius.lerp',
      description: 'Spacings and corners.',
    ),
    (
      name: 'AnimatedTheme',
      description:
          'The widget MaterialApp inserts to do all of this automatically.',
    ),
  ];

  @override
  String get accessibilityHeading => 'Respecting the user';
  @override
  String get disableAnimationsDescription =>
      'The user may have turned animations off in the system accessibility '
      'settings, usually because of motion sickness or sensitivity. When it is '
      'true, cut the durations to zero rather than ignoring it.';
  @override
  String get disableAnimationsTip =>
      'A simple pattern: themeAnimationDuration: '
      'MediaQuery.disableAnimationsOf(context) ? Duration.zero : '
      'const Duration(milliseconds: 300).';

  @override
  String get demoRouteTitle => 'Destination screen';
  @override
  String get demoRouteBody =>
      'This route entered with the animation dictated by '
      'ThemeData.pageTransitionsTheme.';
  @override
  String get demoRouteHint =>
      'Go back and try another: pick Cupertino and the drag-from-the-left-edge '
      'gesture will work too.';
  @override
  String get backButton => 'Back';
}

class TransitionsStringsEs extends TransitionsStrings {
  const TransitionsStringsEs();

  @override
  String get badge => 'MOVIMIENTO';
  @override
  String get title => 'Transiciones y animación';
  @override
  String get subtitle =>
      'El tema también define cómo se MUEVE la app: cómo entra una pantalla '
      'nueva y cómo se funde un tema con otro.';

  @override
  String get routeHeading => 'PageTransitionsTheme';
  @override
  String get routeDescription =>
      'Un mapa TargetPlatform → PageTransitionsBuilder. Se define por '
      'plataforma porque lo normal es querer la animación nativa de cada '
      'sistema: deslizamiento lateral en iOS, zoom en Android.';
  @override
  String get routeDefault => 'Zoom en Android, Cupertino en iOS y macOS';
  @override
  String get routeTip =>
      'La transición solo se aplica a MaterialPageRoute (y a las rutas de '
      'go_router que la usan por debajo). Una PageRouteBuilder con '
      'transitionsBuilder propio ignora el tema.';
  @override
  String get navigateButton => 'Navegar a una pantalla nueva';

  @override
  String get themeAnimationHeading => 'Animación del cambio de tema';
  @override
  String get durationDescription =>
      'Cuando cambias de tema, Flutter no salta: INTERPOLA entre el ThemeData '
      'viejo y el nuevo, propiedad a propiedad, usando los métodos lerp de cada '
      'tipo. Aquí decides cuánto dura esa fusión.';
  @override
  String get durationDefault => 'kThemeAnimationDuration (200 ms)';
  @override
  String get durationTip =>
      'Ponlo a 0 ms si quieres cambios instantáneos, o súbelo a 1500 para ver '
      'con lupa cómo se interpolan colores, radios y espaciados a la vez.';
  @override
  String get toggleButton => 'Cambiar claro / oscuro y observar';
  @override
  String get curveDescription =>
      'La curva de aceleración de esa fusión. Material recomienda '
      'Curves.easeInOut para cambios de estado y las curvas emphasized para '
      'movimientos que deben llamar la atención.';
  @override
  String get styleDescription =>
      'Agrupa duración y curva en un solo objeto. AnimationStyle.noAnimation '
      'desactiva la transición por completo, que es lo que quieres si el '
      'cambio de tema lo dispara un ajuste del sistema.';

  @override
  String get lerpHeading => 'Widgets que animan el tema';
  @override
  String get lerpIntro =>
      'La interpolación del tema funciona porque casi todos los tipos de '
      'Flutter saben fundirse consigo mismos. Estos son los que hacen el '
      'trabajo:';

  @override
  List<LerpEntry> get lerpEntries => const <LerpEntry>[
    (
      name: 'ThemeData.lerp',
      description:
          'Interpola dos temas completos. Es lo que usa AnimatedTheme por '
          'dentro.',
    ),
    (name: 'ColorScheme.lerp', description: 'Funde los 45 roles uno a uno.'),
    (
      name: 'TextTheme.lerp',
      description: 'Funde los 15 estilos: tamaño, peso, color, espaciado.',
    ),
    (
      name: 'Color.lerp',
      description: 'Interpola en el espacio de color, canal a canal.',
    ),
    (
      name: 'ShapeBorder.lerp',
      description:
          'Permite pasar de un radio a otro, o de círculo a rectángulo.',
    ),
    (
      name: 'EdgeInsets.lerp / BorderRadius.lerp',
      description: 'Espaciados y esquinas.',
    ),
    (
      name: 'AnimatedTheme',
      description:
          'El widget que MaterialApp inserta para hacer todo esto '
          'automáticamente.',
    ),
  ];

  @override
  String get accessibilityHeading => 'Respetar al usuario';
  @override
  String get disableAnimationsDescription =>
      'El usuario puede haber desactivado las animaciones en los ajustes de '
      'accesibilidad del sistema, normalmente por mareos o sensibilidad al '
      'movimiento. Si es true, reduce las duraciones a cero en lugar de '
      'ignorarlo.';
  @override
  String get disableAnimationsTip =>
      'Un patrón simple: themeAnimationDuration: '
      'MediaQuery.disableAnimationsOf(context) ? Duration.zero : '
      'const Duration(milliseconds: 300).';

  @override
  String get demoRouteTitle => 'Pantalla de destino';
  @override
  String get demoRouteBody =>
      'Esta ruta ha entrado con la animación que dicta '
      'ThemeData.pageTransitionsTheme.';
  @override
  String get demoRouteHint =>
      'Vuelve atrás y prueba otra: si eliges Cupertino, también funcionará el '
      'gesto de arrastrar desde el borde izquierdo.';
  @override
  String get backButton => 'Volver';
}
