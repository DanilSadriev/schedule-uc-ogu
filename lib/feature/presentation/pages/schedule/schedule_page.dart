import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_event.dart';
import 'package:raspisanie/feature/presentation/bloc/added_groups_bloc/added_groups_state.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/schedule_page_view.dart';
import 'package:raspisanie/feature/presentation/pages/schedule/widgets/schedule_settings_modal.dart';
import 'package:raspisanie/feature/presentation/widgets/group_button.dart';
import 'package:raspisanie/feature/presentation/widgets/loading_widget.dart';

import '../../../../common/theme/colors.dart';

// отрисовка экрана с расписанием
class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _modalShown = false;

  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    context
        .read<AddedGroupsBloc>()
        .add(LoadAddedGroups()); //загрузка активных групп
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // отрисовка бокового меню
      child: InnerDrawer(
        key: _innerDrawerKey,
        offset: IDOffset.horizontal(
            (100 / (MediaQuery.of(context).size.width / 250)) / 100),
        swipeChild: true,
        onTapClose: true,
        borderRadius: 16.0,
        boxShadow: const [],
        rightChild: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Управление расписанием',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(width: 16),
                          Text('Добавить',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (!_modalShown) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              const ScheduleSettingsModal(isFirstRun: false),
                        ).whenComplete(
                          () {
                            _modalShown = false;
                          },
                        );
                      }
                      _modalShown = true;
                    },
                  ),
                ),
                const Divider(
                  color: DarkThemeColors.white,
                ),
                BlocBuilder<AddedGroupsBloc, AddedGroupsState>(
                    builder: (context, state) {
                  if (state is AddedGroupsLoading) {
                    return LoadingWidget().loading(context);
                  } else if (state is AddedGroupsLoaded) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Активные'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: DarkThemeColors.gray),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 8),
                          state.activeGroup.group != ''
                              ? GroupButton(
                                  group: state.activeGroup,
                                  activeGroup: state.activeGroup,
                                  isActive: true,
                                  selectDate: nowDate,
                                )
                              : Container(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.groups.length,
                              itemBuilder: (context, index) {
                                if (state.groups[index].group !=
                                    state.activeGroup.group) {
                                  return GroupButton(
                                    group: state.groups[index],
                                    activeGroup: state.activeGroup,
                                    isActive: false,
                                    selectDate: nowDate,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
        // отрисовка окна с рассписанием
        scaffold: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Расписание',
            ),
            // backgroundColor: DarkThemeColors.background,
            actions: [
              IconButton(
                icon: const Icon(Icons.dehaze),
                onPressed: () {
                  _innerDrawerKey.currentState!.toggle();
                },
              ),
            ],
          ),
          body: SafeArea(
              bottom: false,
              child: BlocConsumer<AddedGroupsBloc, AddedGroupsState>(
                  builder: (context, state) {
                if (state is AddedGroupsLoading) {
                  return LoadingWidget().loading(context);
                } else if (state is AddedGroupsLoaded) {
                  if (_modalShown) {
                    _modalShown = false;
                    Navigator.of(context).pop();
                  }
                  return SchedulePageView(
                    activeGroup: state.activeGroup.group,
                  );
                } else {
                  return Container();
                }
              }, listener: (context, state) {
                if (state is AddedGroupsNotItems) {
                  if (!_modalShown) {
                    showModalBottomSheet(
                      useRootNavigator: false,
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          const ScheduleSettingsModal(isFirstRun: true),
                    ).whenComplete(() {
                      _modalShown = false;
                    });
                  }
                  _modalShown = true;
                }
              })),
        ),
      ),
    );
  }
}
