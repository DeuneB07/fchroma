import 'package:flutter/foundation.dart';

// Copy for the "Fundamentals" page.
//
// Both languages sit in the same file on purpose: a translation is easiest to
// review, and hardest to let drift, when the two versions are a screen apart
// rather than in two files you have to diff side by side.
//
// Property names, type names and code fragments are NOT here. Things like
// `MaterialApp.darkTheme` or `ThemeData.light()` are API identifiers and stay
// verbatim in the page, in every language — the point of showing them is that
// you can search for them in the Flutter source.

@immutable
abstract class OverviewStrings {
  const OverviewStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get colorJourneyHeading;
  String get colorJourneyIntro;

  String get step1Title;
  String get step1Detail;
  String get step2Title;
  String get step2Detail;
  String get step3Title;
  String get step3Detail;
  String get step4Title;
  String get step4Detail;

  String get readingHeading;
  String get threeLevelsHeading;

  String get themeDescription;
  String get darkThemeDescription;
  String get darkThemeTip;
  String get themeModeDescription;
  String get nestedThemeDescription;
  String get nestedThemeTip;

  String get nestedLiveHeading;
  String get appThemeLabel;
  String get nestedThemeLabel;
  String get miniCardSurfaceText;
  String get miniCardAction;

  String get pitfallsHeading;
  String get pitfallContextName;
  String get pitfallContextDescription;
  String get pitfallCopyWithDescription;
}

class OverviewStringsEn extends OverviewStrings {
  const OverviewStringsEn();

  @override
  String get badge => 'FUNDAMENTALS';

  @override
  String get title => 'Anatomy of a Flutter theme';

  @override
  String get subtitle =>
      'ThemeData is an immutable object holding every style default in the '
      'app. It draws nothing: the widgets look it up.';

  @override
  String get colorJourneyHeading => 'How a colour is resolved';

  @override
  String get colorJourneyIntro =>
      'When an ElevatedButton asks itself "what colour am I?", it looks in '
      'this order and takes the FIRST answer:';

  @override
  String get step1Title => 'The widget\'s own parameter';

  @override
  String get step1Detail =>
      'Always wins. It is local to that one instance. Use it only for genuine '
      'exceptions.';

  @override
  String get step2Title => 'The component theme';

  @override
  String get step2Detail =>
      'The default for EVERY button of that type in the app. This is where '
      'your design system lives.';

  @override
  String get step3Title => 'The ColorScheme';

  @override
  String get step3Detail =>
      'The semantic palette. Unless something says otherwise, a FilledButton '
      'paints itself with primary on onPrimary.';

  @override
  String get step4Title => 'Material\'s built-in default';

  @override
  String get step4Detail =>
      'Constants written inside the framework. This is what you see in a '
      'freshly created app.';

  @override
  String get readingHeading => 'Reading the theme';

  @override
  String get threeLevelsHeading => 'The three levels';

  @override
  String get themeDescription =>
      'The theme used while the app is in light mode. It is the root theme: '
      'every widget without a closer Theme inherits it.';

  @override
  String get darkThemeDescription =>
      'The alternate theme for dark mode. Leave it null and the app uses '
      '"theme" in dark mode too, and becomes unreadable. ALWAYS build it with '
      'the same function, changing only the brightness.';

  @override
  String get darkThemeTip =>
      'Flutter interpolates between theme and darkTheme when the mode '
      'changes. That is why both need the same structure: if one defines a '
      'cardTheme and the other does not, the animation jumps.';

  @override
  String get themeModeDescription =>
      'Decides which of the two applies: light, dark, or system (follow the '
      'operating system setting).';

  @override
  String get nestedThemeDescription =>
      'Overrides the theme for a BRANCH of the tree. This is how you give one '
      'section its own style — a player that is always dark, a white-label '
      'form, and so on.';

  @override
  String get nestedThemeTip =>
      'You almost always want to start from the current theme rather than a '
      'new one: Theme(data: Theme.of(context).copyWith(...), ...). Building a '
      'ThemeData() from scratch throws away everything inherited.';

  @override
  String get nestedLiveHeading => 'A nested theme, live';

  @override
  String get appThemeLabel => 'The app\'s theme';

  @override
  String get nestedThemeLabel => 'Nested Theme()';

  @override
  String get miniCardSurfaceText => 'Text on surface';

  @override
  String get miniCardAction => 'Action';

  @override
  String get pitfallsHeading => 'Common mistakes';

  @override
  String get pitfallContextName =>
      'Theme.of(context) in the build that creates the Theme';

  @override
  String get pitfallContextDescription =>
      'Calling Theme.of(context) in the build where you created the '
      'MaterialApp gives you the ANCESTOR\'s theme, not yours. You need a '
      'Builder or a child widget.';

  @override
  String get pitfallCopyWithDescription =>
      'copyWith does NOT recompute derived values. useMaterial3 changes dozens '
      'of defaults that are resolved in the ThemeData() constructor, so the '
      'whole theme has to be rebuilt.';
}

class OverviewStringsEs extends OverviewStrings {
  const OverviewStringsEs();

  @override
  String get badge => 'FUNDAMENTOS';

  @override
  String get title => 'Anatomía de un tema en Flutter';

  @override
  String get subtitle =>
      'ThemeData es un objeto inmutable con los valores por defecto de estilo '
      'de toda la app. No pinta nada: lo consultan los widgets.';

  @override
  String get colorJourneyHeading => 'El recorrido de un color';

  @override
  String get colorJourneyIntro =>
      'Cuando un ElevatedButton se pregunta "¿de qué color me pinto?", busca '
      'en este orden y se queda con la PRIMERA respuesta:';

  @override
  String get step1Title => 'El parámetro del widget';

  @override
  String get step1Detail =>
      'Gana siempre. Es local a esa instancia concreta. Úsalo solo para '
      'excepciones puntuales.';

  @override
  String get step2Title => 'El component theme';

  @override
  String get step2Detail =>
      'El valor por defecto para TODOS los botones de ese tipo en la app. Aquí '
      'es donde vive tu sistema de diseño.';

  @override
  String get step3Title => 'El ColorScheme';

  @override
  String get step3Detail =>
      'La paleta semántica. Si nadie dice lo contrario, un FilledButton se '
      'pinta con primary sobre onPrimary.';

  @override
  String get step4Title => 'El default de Material';

  @override
  String get step4Detail =>
      'Constantes escritas dentro del framework. Es lo que ves en una app '
      'recién creada.';

  @override
  String get readingHeading => 'Cómo se lee el tema';

  @override
  String get threeLevelsHeading => 'Los tres niveles de aplicación';

  @override
  String get themeDescription =>
      'El tema que se usa cuando la app está en modo claro. Es el tema raíz: '
      'todo widget que no tenga un Theme más cercano lo hereda.';

  @override
  String get darkThemeDescription =>
      'El tema alternativo para modo oscuro. Si lo dejas en null, la app usará '
      '"theme" también en oscuro y quedará ilegible. Constrúyelo SIEMPRE con '
      'la misma función, cambiando el brillo.';

  @override
  String get darkThemeTip =>
      'Flutter interpola entre theme y darkTheme al cambiar de modo. Por eso '
      'ambos deben tener la misma estructura: si uno define un cardTheme y el '
      'otro no, la animación da saltos.';

  @override
  String get themeModeDescription =>
      'Decide cuál de los dos se aplica: light, dark o system (sigue el ajuste '
      'del sistema operativo).';

  @override
  String get nestedThemeDescription =>
      'Sobreescribe el tema para una RAMA del árbol. Es la forma de tener una '
      'sección con estilo propio (un reproductor siempre oscuro, un formulario '
      'de marca blanca...).';

  @override
  String get nestedThemeTip =>
      'Casi siempre querrás partir del tema actual en vez de crear uno nuevo: '
      'Theme(data: Theme.of(context).copyWith(...), ...). Si construyes un '
      'ThemeData() desde cero pierdes todo lo heredado.';

  @override
  String get nestedLiveHeading => 'Tema anidado en vivo';

  @override
  String get appThemeLabel => 'Tema de la app';

  @override
  String get nestedThemeLabel => 'Theme() anidado';

  @override
  String get miniCardSurfaceText => 'Texto sobre surface';

  @override
  String get miniCardAction => 'Acción';

  @override
  String get pitfallsHeading => 'Errores frecuentes';

  @override
  String get pitfallContextName =>
      'Theme.of(context) en el mismo build que crea el Theme';

  @override
  String get pitfallContextDescription =>
      'Si llamas a Theme.of(context) en el build donde has creado el '
      'MaterialApp, obtienes el tema del ANCESTRO, no el tuyo. Necesitas un '
      'Builder o un widget hijo.';

  @override
  String get pitfallCopyWithDescription =>
      'copyWith NO recalcula los valores derivados. useMaterial3 cambia '
      'decenas de defaults que se resuelven en el constructor ThemeData(), así '
      'que hay que reconstruir el tema entero.';
}
