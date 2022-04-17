import 'package:flutter/material.dart';

import '../style.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PageColor.taskListBgColor,
    );
  }
}
