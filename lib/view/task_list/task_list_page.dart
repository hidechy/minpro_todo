import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style.dart';

import '../../util/constants.dart';
import '../../view_model/view_model.dart';

import '../side_menu/side_menu_page.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(
      builder: (context, vm, child) {
        final screenSize = vm.screenSize;

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
        );
      },
    );
  }

  ///
  _sort({required BuildContext context}) {}

  ///
  _addNewTask({required BuildContext context}) {}
}
