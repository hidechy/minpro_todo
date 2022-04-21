import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style.dart';

import '../../util/constants.dart';
import '../../view_model/view_model.dart';

import '../side_menu/side_menu_page.dart';

import '../common/show_add_new_task.dart';

import 'task_list_tile_part.dart';

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

        final isSorted = vm.isSorted;

        return Scaffold(
          backgroundColor: CustomColors.taskListBgColor,
          appBar: AppBar(
            title: Text(StringR.taskList),
            centerTitle: true,
            actions: [
              (isSorted)
                  ? IconButton(
                      onPressed: () => _sort(context: context, isSort: false),
                      icon: const Icon(Icons.undo),
                    )
                  : IconButton(
                      onPressed: () => _sort(context: context, isSort: true),
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

              final now = DateTime.now();
              final limit = task.limitDateTime;

              return Card(
                color: (now.compareTo(limit) > 0)
                    ? CustomColors.periodOverTaskColor
                    : CustomColors.taskCardBgColor(context),
                child: TileListTilePart(task: task),
              );
            },
          ),
        );
      },
    );
  }

  ///
  _sort({required BuildContext context, required bool isSort}) {
    final viewModel = context.read<ViewModel>();
    viewModel.sort(isSort);
  }

  ///
  _addNewTask({required BuildContext context}) {
    showAddNewTask(context: context);
  }
}
