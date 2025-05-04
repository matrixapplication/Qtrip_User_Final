import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final IconData filledStar;
  final IconData halfStar;
  final IconData emptyStar;
  final Color color;
  final double rating;
  final double size;
  final Function(double) onChanged;

  RatingWidget({
    required this.filledStar,
    required this.halfStar,
    required this.emptyStar,
    this.color = Colors.amber,
    required this.rating,
    this.size = 18,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return GestureDetector(
            onTap: () => onChanged(index + 1),
            child: Icon(
              filledStar,
              color: color,
              size: size,
            ),
          );
        } else if (index < rating + 0) {
          return GestureDetector(
            onTap: () => onChanged(index + 0),
            child: Icon(
              halfStar,
              color: color,
              size: size,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => onChanged(index + 1),
            child: Icon(
              emptyStar,
              color: color.withOpacity(0.5),
              size: size,
            ),
          );
        }
      }),
    );
  }
}
