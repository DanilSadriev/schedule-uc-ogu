// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:raspisanie/feature/presentation/bloc/name_groups_bloc/name_groups_bloc.dart';
import 'package:raspisanie/feature/presentation/bloc/name_groups_bloc/name_groups_event.dart';
import 'package:raspisanie/feature/presentation/widgets/loading_widget.dart';
import 'package:raspisanie/utils/groups_utils.dart';

import '../../../bloc/name_groups_bloc/name_groups_state.dart';

String selectValue = '';

// виджет выпадающего списка
class AutocompleteGroupSelector extends StatefulWidget {
  const AutocompleteGroupSelector({Key? key}) : super(key: key);

  @override
  _AutocompleteGroupSelectorState createState() =>
      _AutocompleteGroupSelectorState();
}

class _AutocompleteGroupSelectorState extends State<AutocompleteGroupSelector> {
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    context.read<NameGroupsBloc>().add(GetNameGroups());
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameGroupsBloc, NameGroupsState>(
        builder: (context, state) {
      if (state is NameGroupsLoading) {
        return LoadingWidget().loading(context);
      } else if (state is NameGroupsLoaded) {
        return TypeAheadField(
          hideOnError: false,
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: FocusNode(),
            controller: _inputController,
            autofocus: false,
            style: Theme.of(context).textTheme.titleMedium,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Введите',
            ),
          ),
          itemBuilder: (context, suggestion) => Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                suggestion.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          noItemsFoundBuilder: (context) => Container(
            alignment: Alignment.center,
            color: Theme.of(context).cardColor,
            child: Text('Ничего не нашлось',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          suggestionsCallback: (pattern) async {
            return GroupsUtils.getSuggestions(
                pattern, state.groups, state.teachers);
          },
          keepSuggestionsOnSuggestionSelected: false,
          onSuggestionSelected: (String suggestion) {
            _inputController.text = suggestion;
            selectValue = suggestion;
          },
        );
      } else if (state is NameGroupsError) {
        return const Text('Ошибка');
      } else {
        return Container();
      }
    });
  }
}
