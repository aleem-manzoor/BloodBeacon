import 'package:flutter/material.dart';

class VerticalArrow extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const VerticalArrow({
    super.key,
    this.height = 100,
    this.width = 2,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _VerticalArrowPainter(color: color, width: width),
      ),
    );
  }
}

class _VerticalArrowPainter extends CustomPainter {
  final Color color;
  final double width;

  _VerticalArrowPainter({required this.color, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    // Draw the vertical line
    final startPoint = Offset(size.width / 2, 0); // Start from the top
    final endPoint =
        Offset(size.width / 2, size.height - 10); // End near the bottom
    canvas.drawLine(startPoint, endPoint, paint);

    // Draw the arrowhead (triangle)
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(
        size.width / 2, size.height); // Tip of the arrowhead (bottom)
    arrowHeadPath.lineTo(
        size.width / 2 - 5, size.height - 10); // Left corner of the arrowhead
    arrowHeadPath.lineTo(
        size.width / 2 + 5, size.height - 10); // Right corner of the arrowhead
    arrowHeadPath.close();

    canvas.drawPath(arrowHeadPath, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
