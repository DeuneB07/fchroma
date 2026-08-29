import 'package:flutter/foundation.dart';

// Copy for the shared widget showcase.
//
// It lives in its own strings class rather than under a page because two pages
// render the same gallery: "Component themes" and the M2/M3 comparison.
//
// Widget names used as button captions — Filled, Tonal, Elevated, Outlined,
// Text, Extended — are NOT here. They are the names of the widgets on screen,
// which is the entire point of the labels.

@immutable
abstract class GalleryStrings {
  const GalleryStrings();

  String get buttons;
  String get iconButtons;
  String get selectionControls;
  String get chips;
  String get textFields;
  String get surfaces;
  String get tabs;
  String get progress;
  String get listsAndDialogs;
  String get navigation;

  String get disabled;
  String get action;
  String filter(int index);

  String get fieldLabel;
  String get fieldHint;
  String get fieldWithError;
  String get fieldErrorText;

  String get tabOne;
  String get tabTwo;
  String get tabThree;

  String get listTileTitle;
  String get listTileSubtitle;
  String get dialogBody;
  String get close;
  String get openDialog;
  String get snackBarContent;
  String get showSnackBar;

  String get navHome;
  String get navSearch;
  String get navSettings;
}

class GalleryStringsEn extends GalleryStrings {
  const GalleryStringsEn();

  @override
  String get buttons => 'Buttons';
  @override
  String get iconButtons => 'Icon buttons and FAB';
  @override
  String get selectionControls => 'Selection controls';
  @override
  String get chips => 'Chips';
  @override
  String get textFields => 'Text fields';
  @override
  String get surfaces => 'Surfaces and elevation';
  @override
  String get tabs => 'Tabs';
  @override
  String get progress => 'Progress indicators';
  @override
  String get listsAndDialogs => 'Lists and dialogs';
  @override
  String get navigation => 'Navigation bar';

  @override
  String get disabled => 'Disabled';
  @override
  String get action => 'Action';
  @override
  String filter(int index) => 'Filter $index';

  @override
  String get fieldLabel => 'Label';
  @override
  String get fieldHint => 'Helper text';
  @override
  String get fieldWithError => 'With an error';
  @override
  String get fieldErrorText => 'This field is required';

  @override
  String get tabOne => 'One';
  @override
  String get tabTwo => 'Two';
  @override
  String get tabThree => 'Three';

  @override
  String get listTileTitle => 'ListTile title';
  @override
  String get listTileSubtitle => 'Uses bodyMedium and onSurfaceVariant';
  @override
  String get dialogBody =>
      'Its shape comes from ThemeData.dialogTheme.shape and its background '
      'from colorScheme.surfaceContainerHigh.';
  @override
  String get close => 'Close';
  @override
  String get openDialog => 'Open a dialog';
  @override
  String get snackBarContent => 'Styled by ThemeData.snackBarTheme';
  @override
  String get showSnackBar => 'Show a SnackBar';

  @override
  String get navHome => 'Home';
  @override
  String get navSearch => 'Search';
  @override
  String get navSettings => 'Settings';
}

class GalleryStringsEs extends GalleryStrings {
  const GalleryStringsEs();

  @override
  String get buttons => 'Botones';
  @override
  String get iconButtons => 'Icon buttons y FAB';
  @override
  String get selectionControls => 'Controles de selección';
  @override
  String get chips => 'Chips';
  @override
  String get textFields => 'Campos de texto';
  @override
  String get surfaces => 'Superficies y elevación';
  @override
  String get tabs => 'Pestañas';
  @override
  String get progress => 'Indicadores de progreso';
  @override
  String get listsAndDialogs => 'Listas y diálogos';
  @override
  String get navigation => 'Barra de navegación';

  @override
  String get disabled => 'Disabled';
  @override
  String get action => 'Acción';
  @override
  String filter(int index) => 'Filtro $index';

  @override
  String get fieldLabel => 'Etiqueta';
  @override
  String get fieldHint => 'Texto de ayuda';
  @override
  String get fieldWithError => 'Con error';
  @override
  String get fieldErrorText => 'Este campo es obligatorio';

  @override
  String get tabOne => 'Uno';
  @override
  String get tabTwo => 'Dos';
  @override
  String get tabThree => 'Tres';

  @override
  String get listTileTitle => 'Título del ListTile';
  @override
  String get listTileSubtitle => 'Usa bodyMedium y onSurfaceVariant';
  @override
  String get dialogBody =>
      'Su forma sale de ThemeData.dialogTheme.shape y su color de fondo de '
      'colorScheme.surfaceContainerHigh.';
  @override
  String get close => 'Cerrar';
  @override
  String get openDialog => 'Abrir diálogo';
  @override
  String get snackBarContent => 'Estilo de ThemeData.snackBarTheme';
  @override
  String get showSnackBar => 'Mostrar SnackBar';

  @override
  String get navHome => 'Inicio';
  @override
  String get navSearch => 'Buscar';
  @override
  String get navSettings => 'Ajustes';
}
