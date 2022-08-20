import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/entities/added _groups.dart';
import '../bloc/added_groups_bloc/added_groups_bloc.dart';
import '../bloc/added_groups_bloc/added_groups_event.dart';
import '../bloc/schedule_bloc/schedule_bloc.dart';
import '../bloc/schedule_bloc/schedule_event.dart';

class GroupButton extends StatefulWidget {
  const GroupButton({
    Key? key,
    required this.group,
    required this.activeGroup,
    required this.isActive,
    required this.selectDate,
  }) : super(key: key);

  final Group group;
  final Group activeGroup;
  final bool isActive;
  final DateTime selectDate;
  @override
  State<GroupButton> createState() => _GroupButtonState();
}

class _GroupButtonState extends State<GroupButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isActive) {
      return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Theme.of(context).backgroundColor,
              onPressed: (context) {
                TextEditingController textFieldController =
                    TextEditingController();
                textFieldController.text = widget.activeGroup.name;

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Редактирование'),
                        content: TextField(
                          controller: textFieldController,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              hintText: 'Введите название'),
                          onSubmitted: (name) =>
                              textFieldController.text = name,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AddedGroupsBloc>().add(
                                    UpdateGroupNameAddedGroups(
                                      group: Group(
                                          name: textFieldController.text,
                                          group: widget.activeGroup.group),
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                            child: const Text('Изменить'),
                          ),
                        ],
                      );
                    });
              },
              icon: Icons.edit,
              label: 'Редактирование',
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).selectedRowColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            title: Text(
              widget.activeGroup.name == ''
                  ? widget.activeGroup.group
                  : widget.activeGroup.name,
            ),
            subtitle: widget.activeGroup.name == ''
                ? null
                : Text(
                    widget.activeGroup.group,
                  ),
          ),
        ),
      );
    } else {
      return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Theme.of(context).backgroundColor,
              onPressed: (context) {
                context
                    .read<AddedGroupsBloc>()
                    .add(DeleteGroupToAddedGroups(group: widget.group));
              },
              icon: Icons.delete,
              foregroundColor: Theme.of(context).errorColor,
              label: 'Удалить',
            ),
            SlidableAction(
              backgroundColor: Theme.of(context).backgroundColor,
              onPressed: (context) {
                TextEditingController textFieldController =
                    TextEditingController();
                textFieldController.text = widget.group.name;

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Редактирование'),
                        content: TextField(
                          controller: textFieldController,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              hintText: 'Введите название'),
                          onSubmitted: (name) =>
                              textFieldController.text = name,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AddedGroupsBloc>().add(
                                    UpdateGroupNameAddedGroups(
                                      group: Group(
                                          name: textFieldController.text,
                                          group: widget.group.group),
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                            child: const Text('Изменить'),
                          ),
                        ],
                      );
                    });
              },
              icon: Icons.edit,
              label: 'Редактирование',
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).disabledColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            title: Text(
              widget.group.name == '' ? widget.group.group : widget.group.name,
            ),
            subtitle: widget.group.name == ''
                ? null
                : Text(
                    widget.group.group,
                  ),
            onTap: () {
              context
                  .read<AddedGroupsBloc>()
                  .add(UpdateActiveGroupAddedGroups(group: widget.group));
              context
                  .read<ScheduleBloc>()
                  .add(ScheduleView(widget.selectDate, widget.group.group));
            },
          ),
        ),
      );
    }
  }
}
