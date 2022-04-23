import 'package:flutter/material.dart';

import '../common/task_content_part.dart';

import '../../util/constants.dart';

import 'package:provider/provider.dart';

import '../../view_model/view_model.dart';

import '../common/show_snack_bar.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final taskContentKey = GlobalKey<TaskContentPartState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(StringR.addNewTask),
        actions: [
          IconButton(
            onPressed: () => _onDoneAddNewTask(context: context),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: TaskContentPart(
        key: taskContentKey,
        isEditMode: false,
      ),
    );
  }

  ///
  _onDoneAddNewTask({required BuildContext context}) {
    final taskContentState = taskContentKey.currentState;
    if (taskContentState == null) return;

    if (taskContentState.formKey.currentState!.validate()) {
      final viewModel = context.read<ViewModel>();
      viewModel.addNewTask(
        taskContentState.titleController.text,
        taskContentState.detailController.text,
        taskContentState.limitDateTime,
        taskContentState.isImportant,
      );

      Navigator.pop(context);

      showSnackBar(
        context: context,
        contentText: StringR.addTaskCompleted,
        isSnackBarActionNeeded: false,
      );
    }
  }
}
