// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';
import 'package:raspisanie/utils/lesson_card_utils.dart';

import '../../../../../common/theme/colors.dart';

// отрисовка карточек пары
class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard(
      {Key? key,
      required this.lesson,
      required this.colored,
      required this.finished})
      : super(key: key);
  final bool colored;
  final bool finished;

  @override
  Widget build(BuildContext context) {
    List<String> time = lesson.time;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Opacity(
        opacity: finished ? 0.4 : 1.0,
        child: ListTile(
          leading: Column(
            children: [
              Container(
                height: 32.0,
                width: 32.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Center(
                  child: Text(
                    lesson.nomer,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: DarkThemeColors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                '${time.first}\n${time.last}',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          title: Text(
            lesson.name,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            lesson.groupOrTeacher,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Container(
            alignment: Alignment.center,
            height: 32.0,
            width: 64.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: colored
                    ? LessonCardUtils().getColorsAudience(lesson.audience)
                    : Theme.of(context).primaryColor),
            child: Text(
              lesson.audience,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: DarkThemeColors.white),
            ),
          ),
          visualDensity: const VisualDensity(vertical: 4.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
