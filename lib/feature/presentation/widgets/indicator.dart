import 'package:flutter/material.dart';

import '../../../../../common/theme/colors.dart';

// индикатор страниц
class IndicatorPageView extends StatelessWidget {
  const IndicatorPageView({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.75),
      height: 8.0,
      width: isActive ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : DarkThemeColors.gray,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: <BoxShadow>[
          isActive
              ? BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0.0, 2.0),
                  blurRadius: 4.0,
                )
              : const BoxShadow(color: Colors.transparent),
        ],
      ),
    );
  }
}
