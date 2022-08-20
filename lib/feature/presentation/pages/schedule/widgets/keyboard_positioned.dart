import 'package:flutter/cupertino.dart';

// позиционирование отрисованного элемента относительно экрана
/// Widget to make content always be above keyboard
class KeyboardPositioned extends StatelessWidget {
  const KeyboardPositioned({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.95,
          left: 0,
          right: 0,
          child: child,
        )
      ],
    );
  }
}
