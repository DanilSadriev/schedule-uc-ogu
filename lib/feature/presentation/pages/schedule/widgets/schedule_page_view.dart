// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raspisanie/feature/domain/entities/lesson.dart';
import 'package:raspisanie/feature/domain/entities/schedule_settings.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_event.dart';
import 'package:raspisanie/feature/presentation/bloc/schedule_bloc/schedule_state.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/break_card.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/lesson_card.dart';
import 'package:raspisanie/feature/presentation/widgets/loading_widget.dart';
import 'package:raspisanie/utils/time_utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../../common/theme/colors.dart';

// отображаемые элементы экрана с расписанием
DateTime nowDate = DateTime.now();

class SchedulePageView extends StatefulWidget {
  const SchedulePageView({Key? key, required this.activeGroup})
      : super(key: key);
  final String? activeGroup;
  @override
  _SchedulePageViewState createState() => _SchedulePageViewState();
}

class _SchedulePageViewState extends State<SchedulePageView> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // DateTime focusedDay = DateTime.now();
  // late bool breakLecture;
  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(ScheduleView(nowDate, widget.activeGroup));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TableCalendar(
            pageJumpingEnabled: true,
            weekendDays: const [DateTime.sunday],
            calendarFormat: format,
            firstDay: DateTime(2010),
            lastDay: DateTime(2100),
            focusedDay: focusedDay,
            sixWeekMonthsEnforced: true,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              headerPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leftChevronVisible: false,
              rightChevronVisible: false,
              formatButtonShowsNext: false,
              titleTextStyle:
                  Theme.of(context).textTheme.titleMedium ?? const TextStyle(),
              formatButtonVisible: false,
              titleTextFormatter: (DateTime date, dynamic locale) {
                String dateStr =
                    '${DateFormat.yMMMM(locale).format(date)}\n${widget.activeGroup}';
                return dateStr;
              },
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: DarkThemeColors.gray) ??
                  const TextStyle(),
              weekendStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: DarkThemeColors.lightGray) ??
                  const TextStyle(),
            ),
            // availableCalendarFormats: const {
            //   CalendarFormat.month: 'Месяц',
            //   CalendarFormat.twoWeeks: '2 недели',
            //   CalendarFormat.week: 'Неделя'
            // },
            locale: 'ru_RU',
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            //day changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
                context
                    .read<ScheduleBloc>()
                    .add(ScheduleView(selectDay, widget.activeGroup));
              });
            },
            // onFormatChanged: (CalendarFormat format) {
            //   setState(() {
            //     format = format;
            //   });
            // },
            formatAnimationDuration: const Duration(milliseconds: 400),
            formatAnimationCurve: Curves.easeInOutSine,
            calendarStyle: CalendarStyle(
              rangeStartDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              rangeEndDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              withinRangeDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              disabledDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              holidayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              todayDecoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              todayTextStyle:
                  Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
              selectedTextStyle: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white) ??
                  const TextStyle(),
              defaultTextStyle:
                  Theme.of(context).textTheme.labelLarge ?? const TextStyle(),
            ),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                return Center(
                  child: Text(
                    DateFormat.E('ru_RU').format(day),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Theme.of(context).disabledColor),
                  ),
                );
              },
            ),
          ),
        ),
        BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            List<Lesson> schedule = [];
            ScheduleSettings scheduleSettings;
            if (state is ScheduleLoading) {
              return Expanded(child: LoadingWidget().loading(context));
            } else if (state is ScheduleLoaded) {
              schedule = state.schedules;
              scheduleSettings = state.scheduleSettings;
              if (schedule.isNotEmpty) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          child: Text(
                            'Занятия:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (index != schedule.length - 1 &&
                                state.scheduleSettings.lectureBreaks) {
                              return Column(
                                children: [
                                  LessonCard(
                                    lesson: schedule[index],
                                    colored: scheduleSettings.colorfulLecture,
                                    finished: scheduleSettings.finishedLecture
                                        ? TimeUtils().finishedLecture(
                                            schedule[index].time.last,
                                            selectedDay,
                                            true)
                                        : false,
                                  ),
                                  BreakCard(
                                    time: TimeUtils().timeInterval(
                                        schedule[index].time[3],
                                        schedule[index + 1].time[0]),
                                  ),
                                ],
                              );
                            } else {
                              return LessonCard(
                                lesson: schedule[index],
                                colored: scheduleSettings.colorfulLecture,
                                finished: scheduleSettings.finishedLecture
                                    ? TimeUtils().finishedLecture(
                                        schedule[index].time.last,
                                        selectedDay,
                                        true)
                                    : false,
                              );
                            }
                          },
                          itemCount: schedule.length,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: _buildEmptyLessons(),
                );
              }
            } else if (state is ScheduleError) {
              return Expanded(
                child: _buildErrorLessons(),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  // отрисовка элемента при отсутствии пар
  Widget _buildEmptyLessons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/images/Saly-18.png'),
          height: 225.0,
        ),
        Text('Пар нет!', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  Widget _buildErrorLessons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/images/Saly-9.png'),
          height: 300.0,
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text(
          'Что-то пошло не так. Проверьте подключение к интернету.',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
