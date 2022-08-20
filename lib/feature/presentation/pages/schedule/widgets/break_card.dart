import 'package:flutter/material.dart';

class BreakCard extends StatelessWidget {
  const BreakCard({Key? key, required this.time}) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Перерыв',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 16.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  '$time мин.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: DarkThemeColors.gray),
    //       borderRadius: BorderRadius.circular(16.0)),
    //   child: ListTile(
    //     dense: true,
    //     title: Text(
    //       'Перерыв',
    //       style: Theme.of(context).textTheme.bodyMedium,
    //     ),
    //     trailing: Text(
    //       '$time мин.',
    //       style: Theme.of(context).textTheme.bodyMedium,
    //     ),
    //   ),
    // );
  }
}
