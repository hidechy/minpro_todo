import 'package:flutter/material.dart';

import '../common/task_content_part.dart';

import '../../util/constants.dart';

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
      ),
    );
  }

  ///
  _onDoneAddNewTask({required BuildContext context}) {
    final taskContentState = taskContentKey.currentState;
    if (taskContentState == null) return;

    if (taskContentState.formKey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }
}
