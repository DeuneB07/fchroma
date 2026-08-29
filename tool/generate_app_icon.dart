import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  APP ICON GENERATOR
// ───────────────────────────────────────────────────────────────────────────
//  Paints the launcher icon with Flutter's own canvas and writes it to disk,
//  so the icon lives in the repository as CODE rather than as an opaque
//  binary somebody has to open a design tool to change. Want a different hue
//  sweep or a bigger logo? Edit the numbers below and re-run.
//
//  Run it with:
//
//      flutter test tool/generate_app_icon.dart
//
//  It is a test, oddly enough, for a practical reason: encoding a picture to
//  PNG needs a live Flutter engine (`Picture.toImage` and
//  `Image.toByteData`), and `flutter test` is the cheapest way to get one
//  headless. A plain `dart run` has no engine and would fail.
//
//  Outputs (all 1024x1024, git-tracked):
//    assets/icon/app_icon.png             rounded, for web and as the default
//    assets/icon/app_icon_ios.png         square and opaque, for iOS
//    assets/icon/app_icon_background.png  the wheel alone   ┐ Android
//    assets/icon/app_icon_foreground.png  the logo alone    ┘ adaptive layers
//
//  Android adaptive icons are two independent layers that the launcher masks
//  and parallaxes separately, which is why the wheel and the logo have to be
//  rendered apart as well as together.
//
//  `flutter_launcher_icons` then resizes these into every platform's assets;
//  see the flutter_launcher_icons section of pubspec.yaml.
// ═══════════════════════════════════════════════════════════════════════════

/// Native size of the source images. 1024 is what the app stores expect, and
/// everything else is downscaled from it.
const double kIconSize = 1024;

/// Corner radius of the plain icon. Roughly iOS's superellipse proportion;
/// Android masks the adaptive icon itself and ignores this.
const double kCornerRadius = kIconSize * 0.22;

void main() {
  test('generate app icon PNGs', () async {
    await _write('assets/icon/app_icon.png', _paintFullIcon);
    await _write('assets/icon/app_icon_ios.png', _paintIosIcon);
    await _write('assets/icon/app_icon_background.png', _paintBackground);
    await _write('assets/icon/app_icon_foreground.png', _paintForeground);
  });
}

// ── The chromatic wheel ─────────────────────────────────────────────────────

/// The hue sweep, sampled every 30° around the circle.
///
/// A [SweepGradient] interpolates in RGB, so handing it only red/green/blue
/// would cut straight through the middle of the colour space and produce muddy
/// bands. Sampling twelve evenly spaced hues keeps every step short enough
/// that the interpolation stays on the outside of the wheel.
///
/// The last entry repeats the first so the sweep closes without a seam.
List<Color> _chromaticWheel() {
  return <Color>[
    for (int i = 0; i <= 12; i++)
      HSVColor.fromAHSV(1, (i % 12) * 30.0, 0.82, 1.0).toColor(),
  ];
}

void _paintFullIcon(Canvas canvas) {
  _paintWheel(canvas, rounded: true);
  _paintFlutterLogo(canvas, scale: 0.46);
}

/// The iOS icon: square, full bleed, no transparency.
///
/// iOS masks the icon with its own superellipse, and that shape reaches
/// further into the corners than a rounded rectangle does. Supplying the
/// rounded artwork left the flattened-alpha corners showing as white slivers
/// outside our radius but inside Apple's mask. Full bleed is what Apple's
/// guidelines ask for, and it sidesteps the problem entirely.
void _paintIosIcon(Canvas canvas) {
  _paintWheel(canvas, rounded: false);
  _paintFlutterLogo(canvas, scale: 0.46);
}

/// The Android adaptive background layer: the wheel, no logo, and no rounding.
///
/// Square on purpose — the launcher applies its own mask (circle, squircle,
/// teardrop, whatever the device uses), so rounding it here would show as a
/// gap between the icon's corners and the mask.
void _paintBackground(Canvas canvas) {
  _paintWheel(canvas, rounded: false);
}

/// Android adaptive icons put the foreground on its own layer, over a
/// transparent background, and crop it with a system mask.
///
/// The scale looks large for a layer whose safe zone is only the middle ~66 %,
/// and it is deliberate: `flutter_launcher_icons` wraps this drawable in a
/// 16 % inset, shrinking it to 68 % of the layer. Drawn at 0.34 the logo
/// arrived at roughly 23 % of the finished icon and looked lost. 0.50 lands
/// near 34 %, which reads correctly next to the wheel.
void _paintForeground(Canvas canvas) {
  _paintFlutterLogo(canvas, scale: 0.50);
}

void _paintWheel(Canvas canvas, {required bool rounded}) {
  final Rect bounds = const Offset(0, 0) & const Size(kIconSize, kIconSize);

  canvas.save();
  if (rounded) {
    canvas.clipRRect(
      RRect.fromRectAndRadius(bounds, const Radius.circular(kCornerRadius)),
    );
  }

  // 1. The chromatic scale itself: a full hue revolution.
  canvas.drawRect(
    bounds,
    Paint()
      ..shader = SweepGradient(
        colors: _chromaticWheel(),
        // Start at the top so the red sits at 12 o'clock, which is how a
        // colour wheel is conventionally drawn.
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(bounds),
  );

  // 2. A soft radial scrim behind the logo.
  //
  // Not decoration: white-on-yellow is unreadable, and a hue wheel guarantees
  // a yellow region somewhere. This darkens the middle just enough to seat
  // the logo.
  //
  // Kept deliberately weak. The first attempt used 0.82 alpha over most of
  // the canvas and the result was a muddy dark square — the colour only
  // survived in the corners, which defeats the entire point of a chromatic
  // icon. The logo's own drop shadow does the rest of the contrast work, so
  // the scrim does not have to.
  canvas.drawRect(
    bounds,
    Paint()
      ..shader = RadialGradient(
        radius: 0.55,
        colors: <Color>[
          const Color(0xFF000000).withValues(alpha: 0.34),
          const Color(0xFF000000).withValues(alpha: 0.16),
          const Color(0x00000000),
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ).createShader(bounds),
  );

  canvas.restore();
}

// ── The Flutter logo ────────────────────────────────────────────────────────

/// Draws the Flutter mark, centred, in white.
///
/// The logo is entirely straight edges, so it is two closed polygons and no
/// curves. Coordinates come from the official mark on a 24x24 grid and are
/// scaled into place here, which keeps the proportions exact instead of
/// eyeballed.
///
/// [scale] is the logo height as a fraction of the icon's height.
void _paintFlutterLogo(Canvas canvas, {required double scale}) {
  // The mark is taller than it is wide on the 24-unit grid.
  const double gridW = 19.4; // x spans 2.3 .. 21.7
  const double gridH = 24.0;

  final double targetH = kIconSize * scale;
  final double unit = targetH / gridH;
  final double targetW = gridW * unit;

  // Centre it, remembering the grid's x origin is 2.3 and not 0.
  final double dx = (kIconSize - targetW) / 2 - 2.3 * unit;
  final double dy = (kIconSize - targetH) / 2;

  Offset p(double x, double y) => Offset(dx + x * unit, dy + y * unit);

  // Upper stroke: the diagonal descending to the left.
  final Path upper = Path()
    ..moveTo(p(14.314, 0).dx, p(14.314, 0).dy)
    ..lineTo(p(2.3, 12).dx, p(2.3, 12).dy)
    ..lineTo(p(6, 15.7).dx, p(6, 15.7).dy)
    ..lineTo(p(21.684, 0.013).dx, p(21.684, 0.013).dy)
    ..close();

  // Lower stroke: the folded chevron.
  final Path lower = Path()
    ..moveTo(p(14.328, 11.072).dx, p(14.328, 11.072).dy)
    ..lineTo(p(7.857, 17.53).dx, p(7.857, 17.53).dy)
    ..lineTo(p(14.327, 24).dx, p(14.327, 24).dy)
    ..lineTo(p(21.7, 24).dx, p(21.7, 24).dy)
    ..lineTo(p(15.24, 17.532).dx, p(15.24, 17.532).dy)
    ..lineTo(p(21.7, 11.072).dx, p(21.7, 11.072).dy)
    ..lineTo(p(14.33, 11.072).dx, p(14.33, 11.072).dy)
    ..close();

  final Path logo = Path.combine(PathOperation.union, upper, lower);

  // A soft shadow so the mark keeps an edge even where the wheel is pale.
  canvas.drawPath(
    logo,
    Paint()
      ..color = const Color(0xFF000000).withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
  );
  canvas.drawPath(logo, Paint()..color = const Color(0xFFFFFFFF));
}

// ── Encoding ────────────────────────────────────────────────────────────────

Future<void> _write(String path, void Function(Canvas canvas) paint) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  paint(Canvas(recorder));

  final ui.Image image = await recorder.endRecording().toImage(
    kIconSize.round(),
    kIconSize.round(),
  );
  final ByteData? png = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  if (png == null) {
    throw StateError('Could not encode $path to PNG.');
  }

  final File file = File(path);
  await file.parent.create(recursive: true);
  await file.writeAsBytes(png.buffer.asUint8List(), flush: true);

  // ignore: avoid_print
  print('wrote $path (${png.lengthInBytes} bytes)');
}
