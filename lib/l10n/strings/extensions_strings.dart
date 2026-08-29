import 'package:flutter/foundation.dart';

// Copy for the "ThemeExtension" page.

@immutable
abstract class ExtensionsStrings {
  const ExtensionsStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get problemHeading;
  String get problemBody;
  String get solutionHeading;

  String get liveHeading;
  String get spacingDescription;
  String get accentDescription;
  String get statesDescription;
  String get statesTip;

  String get branchHeading;
  String get branchBody;
  String get branchLabel;

  String get practicesHeading;
  String get helperDescription;
  String get oneOrManyName;
  String get oneOrManyType;
  String get oneOrManyDescription;
}

class ExtensionsStringsEn extends ExtensionsStrings {
  const ExtensionsStringsEn();

  @override
  String get badge => 'EXTENSIBILITY';
  @override
  String get title => 'ThemeExtension';
  @override
  String get subtitle =>
      'ThemeData has ~150 properties, but none of them is called '
      '"successColor" or "cardSpacing". Extensions are the official way to add '
      'your own.';

  @override
  String get problemHeading => 'The problem';
  @override
  String get problemBody =>
      'Material 3 defines only one semantic state role: error. There is no '
      'success, no warning, no info. Nor is there a spacing scale. This used '
      'to be solved with global constants:';

  @override
  String get solutionHeading => 'The solution';

  @override
  String get liveHeading => 'This app\'s extension, live';
  @override
  String get spacingDescription =>
      'A spacing scale of your own. Material defines none, so every team '
      'invents theirs; putting it in the theme keeps magic numbers from '
      'scattering across the screens.';
  @override
  String get accentDescription =>
      'A corporate colour that fits no ColorScheme role. Note that it brings '
      'its own "on" colour too: following Material\'s convention is what keeps '
      'the contrast from breaking.';
  @override
  String get statesDescription =>
      'The semantic states Material does not cover. And the important part: '
      'they are worth something DIFFERENT in light and dark, which a global '
      'constant could never do.';
  @override
  String get statesTip =>
      'Switch between light and dark in the top bar: the first two colours are '
      'recomputed — and so is the third, because all three live inside the '
      'theme.';

  @override
  String get branchHeading => 'Overriding for one branch';
  @override
  String get branchBody =>
      'Because extensions live inside the ThemeData, a nested Theme() can '
      'change them for its branch alone:';
  @override
  String get branchLabel => 'This branch has a different accent';

  @override
  String get practicesHeading => 'Good practice';
  @override
  String get helperDescription =>
      'Always add a static helper with a fallback value. extension<T>() '
      'returns null if nobody registered the extension, and a blind "!" blows '
      'the app up the moment somebody uses your widget under a Theme that does '
      'not include it.';
  @override
  String get oneOrManyName => 'One extension or several';
  @override
  String get oneOrManyType => 'design';
  @override
  String get oneOrManyDescription =>
      'They are retrieved by TYPE, so you can have several small, well-named '
      'ones (BrandColors, BrandSpacing, BrandRadii) rather than one giant one. '
      'It reads better and avoids needless rebuilds.';
}

class ExtensionsStringsEs extends ExtensionsStrings {
  const ExtensionsStringsEs();

  @override
  String get badge => 'EXTENSIBILIDAD';
  @override
  String get title => 'ThemeExtension';
  @override
  String get subtitle =>
      'ThemeData tiene ~150 propiedades, pero ninguna se llama "colorDeExito" '
      'ni "espaciadoDeTarjeta". Las extensiones son la forma oficial de añadir '
      'las tuyas.';

  @override
  String get problemHeading => 'El problema';
  @override
  String get problemBody =>
      'Material 3 solo define un rol semántico de estado: error. No hay '
      'success, ni warning, ni info. Y tampoco hay una escala de espaciado. '
      'Antes esto se resolvía con constantes globales:';

  @override
  String get solutionHeading => 'La solución';

  @override
  String get liveHeading => 'La extensión de esta app, en vivo';
  @override
  String get spacingDescription =>
      'Una escala de espaciado propia. Material no define ninguna, así que cada '
      'equipo se inventa la suya; meterla en el tema evita tener números '
      'mágicos repartidos por las pantallas.';
  @override
  String get accentDescription =>
      'Un color corporativo que no encaja en ningún rol del ColorScheme. '
      'Fíjate en que también trae su color "on": conviene seguir la misma '
      'convención que Material para no romper el contraste.';
  @override
  String get statesDescription =>
      'Los estados semánticos que Material no cubre. Y lo importante: valen '
      'algo DISTINTO en claro y en oscuro, cosa que una constante global nunca '
      'podría hacer.';
  @override
  String get statesTip =>
      'Cambia entre modo claro y oscuro en la barra superior: los dos primeros '
      'colores se recalculan; el tercero también, porque los tres viven dentro '
      'del tema.';

  @override
  String get branchHeading => 'Sobreescribir en una rama';
  @override
  String get branchBody =>
      'Como las extensiones viven dentro del ThemeData, un Theme() anidado '
      'puede cambiarlas solo para su rama:';
  @override
  String get branchLabel => 'Esta rama tiene otro accent';

  @override
  String get practicesHeading => 'Buenas prácticas';
  @override
  String get helperDescription =>
      'Añade siempre un helper estático con un valor de respaldo. extension<T>() '
      'devuelve null si nadie registró la extensión, y un "!" a ciegas revienta '
      'la app en cuanto alguien use tu widget bajo un Theme que no la incluya.';
  @override
  String get oneOrManyName => 'Una extensión o varias';
  @override
  String get oneOrManyType => 'diseño';
  @override
  String get oneOrManyDescription =>
      'Se recuperan por TIPO, así que puedes tener varias pequeñas y bien '
      'nombradas (BrandColors, BrandSpacing, BrandRadii) en vez de una '
      'gigante. Es más legible y evita reconstrucciones innecesarias.';
}
