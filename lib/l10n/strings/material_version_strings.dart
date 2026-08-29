import 'package:flutter/foundation.dart';

// Copy for the "Material 2 vs 3" page.

/// One row of the difference table: what aspect, how M2 did it, how M3 does it.
typedef VersionDifference = ({String aspect, String m2, String m3});

@immutable
abstract class MaterialVersionStrings {
  const MaterialVersionStrings();

  String get badge;
  String get title;
  String get subtitle;

  String get useMaterial3Description;
  String get useMaterial3Tip;

  String get differencesHeading;
  String get sideBySideHeading;
  String get sideBySideIntro;
  String get migrationHeading;

  String get elevationOverlayDescription;

  /// Column headers of the difference table.
  String get columnAspect;
  String get columnM2;
  String get columnM3;

  /// The table itself. A list rather than one getter per cell: these rows are
  /// homogeneous data, they are only ever rendered as a group, and a missing
  /// row is visible the moment you open the page — none of which is true of
  /// the prose elsewhere in the app.
  List<VersionDifference> get differences;
}

class MaterialVersionStringsEn extends MaterialVersionStrings {
  const MaterialVersionStringsEn();

  @override
  String get badge => 'M2 vs M3';

  @override
  String get title => 'useMaterial3: the switch that changes everything';

  @override
  String get subtitle =>
      'A single ThemeData boolean rewrites the app\'s shapes, sizes, '
      'elevations, typography and colour model.';

  @override
  String get useMaterial3Description =>
      'Turns on the Material Design 3 specifications. It has defaulted to true '
      'since Flutter 3.16. Material 2 still works, but it is in maintenance '
      'mode: it gets no new components and will eventually be retired.';

  @override
  String get useMaterial3Tip =>
      'useMaterial3 is resolved in ThemeData\'s CONSTRUCTOR. Changing it with '
      'copyWith() does not recompute the defaults: the whole theme has to be '
      'rebuilt.';

  @override
  String get differencesHeading => 'What changes, exactly';

  @override
  String get sideBySideHeading => 'The same showcase, both themes';

  @override
  String get sideBySideIntro =>
      'Both columns share the seed colour, typography, density and corner '
      'radius. The only difference is useMaterial3.';

  @override
  String get migrationHeading => 'Migrating from M2 to M3';

  @override
  String get elevationOverlayDescription =>
      'Material 2 with a dark theme only. It lays a translucent white veil over '
      'surfaces according to their elevation, to simulate them catching more '
      'light. M3 ignores it, because colorScheme.surfaceTint plays that role.';

  @override
  String get columnAspect => 'Aspect';
  @override
  String get columnM2 => 'Material 2';
  @override
  String get columnM3 => 'Material 3';

  @override
  List<VersionDifference> get differences => const <VersionDifference>[
    (
      aspect: 'Colour model',
      m2: 'primarySwatch + accentColor',
      m3: 'A 45-role ColorScheme generated from a seed',
    ),
    (
      aspect: 'Elevated surface',
      m2: 'A white veil (elevation overlay)',
      m3: 'A surfaceTint proportional to the elevation',
    ),
    (
      aspect: 'Corners',
      m2: 'A 4 dp radius on almost everything',
      m3: 'Large and varied radii: 12, 16, 28 dp',
    ),
    (
      aspect: 'AppBar',
      m2: 'primary background, elevation 4, a shadow',
      m3: 'surface background, elevation 0, tints itself on scroll',
    ),
    (
      aspect: 'Buttons',
      m2: 'RaisedButton / FlatButton / OutlineButton',
      m3: 'Elevated / Filled / FilledTonal / Outlined / Text',
    ),
    (
      aspect: 'Typography',
      m2: '13 styles: headline1…6, subtitle, body, caption',
      m3: '15 styles: display / headline / title / body / label',
    ),
    (
      aspect: 'Ripple',
      m2: 'InkRipple: a circular wave',
      m3: 'InkSparkle: a diffuse glow',
    ),
    (
      aspect: 'Bottom navigation',
      m2: 'BottomNavigationBar',
      m3: 'NavigationBar with a pill indicator',
    ),
    (
      aspect: 'FAB',
      m2: 'A circle, one size that matters',
      m3: 'A rounded rectangle, 4 sizes and colour variants',
    ),
    (
      aspect: 'Switch',
      m2: 'Plain thumb, thin track',
      m3: 'Thumb with an icon, thick track with a border',
    ),
  ];
}

class MaterialVersionStringsEs extends MaterialVersionStrings {
  const MaterialVersionStringsEs();

  @override
  String get badge => 'M2 vs M3';

  @override
  String get title => 'useMaterial3: el interruptor que lo cambia todo';

  @override
  String get subtitle =>
      'Un único booleano de ThemeData reescribe formas, tamaños, elevaciones, '
      'tipografía y el modelo de color de la app.';

  @override
  String get useMaterial3Description =>
      'Activa las especificaciones de Material Design 3. Desde Flutter 3.16 '
      'vale true por defecto. Material 2 sigue funcionando, pero está en modo '
      'mantenimiento: no recibirá componentes nuevos y acabará retirándose.';

  @override
  String get useMaterial3Tip =>
      'useMaterial3 se resuelve en el CONSTRUCTOR de ThemeData. Cambiarlo con '
      'copyWith() no recalcula los defaults: hay que reconstruir el tema '
      'entero.';

  @override
  String get differencesHeading => 'Qué cambia exactamente';

  @override
  String get sideBySideHeading => 'El mismo muestrario, los dos temas';

  @override
  String get sideBySideIntro =>
      'Ambas columnas comparten color semilla, tipografía, densidad y radio de '
      'esquina. La única diferencia es useMaterial3.';

  @override
  String get migrationHeading => 'Migrar de M2 a M3';

  @override
  String get elevationOverlayDescription =>
      'Solo Material 2 + tema oscuro. Superpone un velo blanco translúcido '
      'sobre las superficies según su elevación, para simular que reciben más '
      'luz. En M3 se ignora, porque ese papel lo cumple colorScheme.surfaceTint.';

  @override
  String get columnAspect => 'Aspecto';
  @override
  String get columnM2 => 'Material 2';
  @override
  String get columnM3 => 'Material 3';

  @override
  List<VersionDifference> get differences => const <VersionDifference>[
    (
      aspect: 'Modelo de color',
      m2: 'primarySwatch + accentColor',
      m3: 'ColorScheme de 45 roles generado desde una semilla',
    ),
    (
      aspect: 'Superficie elevada',
      m2: 'Velo blanco (elevation overlay)',
      m3: 'Tinte con surfaceTint proporcional a la elevación',
    ),
    (
      aspect: 'Esquinas',
      m2: 'Radio 4 dp casi en todo',
      m3: 'Radios grandes y variados: 12, 16, 28 dp',
    ),
    (
      aspect: 'AppBar',
      m2: 'Fondo primary, elevación 4, sombra',
      m3: 'Fondo surface, elevación 0, se tiñe al hacer scroll',
    ),
    (
      aspect: 'Botones',
      m2: 'RaisedButton / FlatButton / OutlineButton',
      m3: 'Elevated / Filled / FilledTonal / Outlined / Text',
    ),
    (
      aspect: 'Tipografía',
      m2: '13 estilos: headline1…6, subtitle, body, caption',
      m3: '15 estilos: display / headline / title / body / label',
    ),
    (
      aspect: 'Ripple',
      m2: 'InkRipple: onda circular',
      m3: 'InkSparkle: destello difuminado',
    ),
    (
      aspect: 'Navegación inferior',
      m2: 'BottomNavigationBar',
      m3: 'NavigationBar con indicador de píldora',
    ),
    (
      aspect: 'FAB',
      m2: 'Círculo, un solo tamaño relevante',
      m3: 'Rectángulo redondeado, 4 tamaños y variantes de color',
    ),
    (
      aspect: 'Switch',
      m2: 'Pulgar liso, pista fina',
      m3: 'Pulgar con icono, pista gruesa con borde',
    ),
  ];
}
