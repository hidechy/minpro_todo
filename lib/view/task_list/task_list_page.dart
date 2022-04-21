import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style.dart';

import '../../util/constants.dart';
import '../../view_model/view_model.dart';

import '../side_menu/side_menu_page.dart';

import '../common/show_add_new_task.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future(() {
      final viewModel = context.read<ViewModel>();
      viewModel.getTaskList();
    });

    return Consumer<ViewModel>(
      builder: (context, vm, child) {
        final screenSize = vm.screenSize;
        final selectedTaskList = vm.selectedTaskList;

        return Scaffold(
          backgroundColor: PageColor.taskListBgColor,
          appBar: AppBar(
            title: Text(StringR.taskList),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _sort(context: context),
                icon: const Icon(Icons.sort),
              ),
            ],
          ),
          floatingActionButton: (screenSize == ScreenSize.LARGE)
              ? null
              : FloatingActionButton(
                  onPressed: () => _addNewTask(context: context),
                  child: const Icon(Icons.add),
                ),
          drawer: (screenSize == ScreenSize.LARGE)
              ? null
              : const Drawer(
                  child: SideMenuPage(),
                ),
          body: ListView.builder(
            itemCount: selectedTaskList.length,
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              final task = selectedTaskList[index];
              return Card(
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.limitDateTime.toString()),
                ),
              );
            },
          ),
        );
      },
    );
  }

  ///
  _sort({required BuildContext context}) {}

  ///
  _addNewTask({required BuildContext context}) {
    showAddNewTask(context: context);
  }
}
