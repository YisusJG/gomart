import 'package:flutter/cupertino.dart';

import '../../../Constants/app_colors.dart';
import '../../../Helpers/get_color_hexadecimal.dart';

class TriangleBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(getColorHexadecimal(primaryColor4)),
        Color(getColorHexadecimal(primaryColor)),
        Color(getColorHexadecimal(primaryColor2)),
      ],
    ).createShader(Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    final Path path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width - 600, size.height)
      ..lineTo(size.width, 90)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}