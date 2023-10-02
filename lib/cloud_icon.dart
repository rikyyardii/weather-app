import 'package:flutter/material.dart';

class CloudIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  CloudIcon({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: CloudPainter(color),
    );
  }
}

class CloudPainter extends CustomPainter {
  final Color color;

  CloudPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(20, 20)
      ..quadraticBezierTo(30, 10, 40, 20)
      ..quadraticBezierTo(50, 10, 60, 20)
      ..quadraticBezierTo(70, 10, 80, 20)
      ..lineTo(80, 40)
      ..lineTo(20, 40)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(30, 30), 10, paint);
    canvas.drawCircle(Offset(55, 30), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
