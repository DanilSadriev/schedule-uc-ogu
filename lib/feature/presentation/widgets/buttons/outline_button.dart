import 'package:flutter/material.dart';

import '../../../../common/theme/colors.dart';

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      focusNode: FocusNode(),
      onPressed: () {
        onClick();
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(DarkThemeColors.gray),
        side: MaterialStateProperty.all(
          const BorderSide(
            color: DarkThemeColors.gray,
            width: 1,
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: DarkThemeColors.gray),
      ),
    );
    // return ElevatedButton(
    //   focusNode: FocusNode(),
    //   onPressed: () {
    //     onClick();
    //   },
    //   style: ButtonStyle(
    //       elevation: MaterialStateProperty.all(0),
    //       overlayColor:
    //           MaterialStateProperty.all(DarkThemeColors.grayDarker),
    //       backgroundColor: MaterialStateProperty.all(Colors.transparent),
    //       shape: MaterialStateProperty.all()),
    //   child: Text(
    //     text,
    //     S,
    //   ),
    // );
  }
}
