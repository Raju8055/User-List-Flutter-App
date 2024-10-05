import 'package:flutter/material.dart';

class CustomCircularLoader extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const CustomCircularLoader({
    Key? key,
    this.size = 50.0,
    this.color = Colors.blueAccent,
    this.strokeWidth = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 2),
          builder: (context, value, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Circular gradient effect
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.2), color.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Circular loader
                CircularProgressIndicator(
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  value: value, // smoothly animating value
                ),
                // Rotation for smooth animation
                Positioned.fill(
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(value),
                    child: Icon(
                      Icons.autorenew,
                      size: size * 0.4,
                      color: color.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
