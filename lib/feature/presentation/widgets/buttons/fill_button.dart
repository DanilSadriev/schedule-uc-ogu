import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  const FillButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      focusNode: FocusNode(),
      onPressed: () {
        onClick();
      },
      // style: Theme.of(context).elevatedButtonTheme.style,
      child: Text(
        text,
        // style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
