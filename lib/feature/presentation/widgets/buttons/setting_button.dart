import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.enabled})
      : super(key: key);
  final String title;
  final Function onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        enabled: enabled,
        title: Text(
          title,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
