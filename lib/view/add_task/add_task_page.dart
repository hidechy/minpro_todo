import 'package:flutter/material.dart';

import '../common/task_content_part.dart';

import '../../util/constants.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

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
      body: const TaskContentPart(),
    );
  }

  ///
  _onDoneAddNewTask({required BuildContext context}) {}
}
