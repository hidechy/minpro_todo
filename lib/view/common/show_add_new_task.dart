import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../view_model/view_model.dart';

import '../style.dart';

import '../add_task/add_task_screen.dart';

import '../add_task/add_task_page.dart';

showAddNewTask({required BuildContext context}) {
  final viewModel = context.read<ViewModel>();
  final screenSize = viewModel.screenSize;

  if (screenSize == ScreenSize.SMALL) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTaskScreen(),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: SizedBox(
          width: WidgetSize.addTaskDialogWidth,
          height: WidgetSize.addTaskDialogHeight,
          child: AddTaskPage(),
        ),
      ),
    );
  }
}
