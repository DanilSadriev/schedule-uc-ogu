// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/theme/colors.dart';
import '../../bloc/call_schedule/call_bloc.dart';
import '../../bloc/call_schedule/call_event.dart';
import '../../bloc/call_schedule/call_state.dart';
import '../../widgets/loading_widget.dart';

// отрисовка экрана с расписанием звонков
class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallState createState() => _CallState();
}

class _CallState extends State<CallPage> with TickerProviderStateMixin {
  late int selectedPage;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    controller = TabController(length: 3, vsync: this);
    context.read<CallBloc>().add(const CallView(false));
  }

  List<Widget> tabs = [
    const Tab(
      text: 'Понедельник - пятница',
    ),
    const Tab(
      text: 'Суббота',
    ),
    const Tab(
      text: 'Сокращенный день',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        if (state is CallLoading) {
          return LoadingWidget().loading(context);
        } else if (state is CallLoaded) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Расписание звонков',
                ),
                bottom: TabBar(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  indicatorColor: Theme.of(context).primaryColor,
                  isScrollable: true,
                  tabs: tabs,
                ),
              ),
              body: TabBarView(
                children: [
                  _listView(getListViewItems(state.calls.callWorkDays)),
                  _listView(getListViewItems(state.calls.callSaturday)),
                  _listView(getListViewItems(state.calls.callAbreviated)),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                )
              ],
            ),
          );
        }
      },
    );
  }

  ListView _listView(List<Widget> children) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: children,
    );
  }

  Card _listTile(int index, List<String>? list) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        enabled: false,
        contentPadding: const EdgeInsets.only(
          left: 0.0,
          right: 16.0,
        ),
        leading: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              color: DarkThemeColors.blue,
            ),
            child: Center(
              child: Text(
                '$index',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: DarkThemeColors.white),
              ),
            ),
          ),
        ),
        title: _text(list!),
      ),
    );
  }

  Widget _text(List<String> list) {
    if (list.length > 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${list[0]} - ${list[1]}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: 32.0),
          Text(
            '${list[2]} - ${list[3]}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    } else {
      return Center(
        child: Text(
          '${list[0]} - ${list[1]}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
  }

  List<Widget> getListViewItems(Map<String, dynamic> map) {
    List<Widget> list = [];
    for (int i = 1; i <= 7; i++) {
      list.addAll([
        _listTile(i, map['$i']),
      ]);
    }
    return list;
  }
}
