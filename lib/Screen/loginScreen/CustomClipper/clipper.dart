import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the top-left corner
    path.lineTo(0.0, size.height - 60); // Adjusted for deeper curve

    // Add the arc to create the deeper circular bottom effect
    path.quadraticBezierTo(
      size.width / 2, size.height + 30, // Deeper curve
      size.width, size.height - 60,     // Adjusted for deeper curve
    );

    // Bottom-right corner
    path.lineTo(size.width, 0.0);

    // Top-right corner
    path.lineTo(0.0, 0.0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
