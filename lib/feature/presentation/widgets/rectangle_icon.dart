import 'package:flutter/material.dart';
import 'package:raspisanie/common/theme/colors.dart';

class RectangleIcon extends StatelessWidget {
  const RectangleIcon({Key? key, required this.icon, required this.color})
      : super(key: key);
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        icon,
        size: 20.0,
        color: DarkThemeColors.white,
      ),
    );
  }
}
