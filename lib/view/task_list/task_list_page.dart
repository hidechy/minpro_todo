import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style.dart';

import '../../util/constants.dart';
import '../../view_model/view_model.dart';

import '../side_menu/side_menu_page.dart';

import '../common/show_add_new_task.dart';

import 'task_list_tile_part.dart';

import '../../data/task.dart';

import '../common/show_snack_bar.dart';

import '../detail/detail_screen.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

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
                // child: TileListTilePart(
                //   task: task,
                //   onFinishChanged: (isFinished) => _finishTask(
                //       context: context,
                //       isFinished: isFinished,
                //       selectedTask: task),
                //   onDelete: () =>
                //       _deleteTask(context: context, selectedTask: task),
                //   onEdit: () =>
                //       _showTaskDetail(context: context, selectedTask: task),
                // ),
                child: (DeviceInfo.isWebOrDesktop)
                    ? _createTaskListTile(context: context, task: task)
                    : Slidable(
                        child:
                            _createTaskListTile(context: context, task: task),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.6,
                          children: [
                            SlidableAction(
                              label: StringR.edit,
                              icon: Icons.edit,
                              onPressed: (context) => _showTaskDetail(
                                context: context,
                                selectedTask: task,
                              ),
                              backgroundColor:
                                  CustomColors.slideActionColorLight(context),
                            ),
                            SlidableAction(
                              label: StringR.delete,
                              icon: Icons.delete,
                              onPressed: (context) => _deleteTask(
                                context: context,
                                selectedTask: task,
                              ),
                              backgroundColor:
                                  CustomColors.slideActionColorDark(context),
                            ),
                            SlidableAction(
                              label: StringR.close,
                              icon: Icons.close,
                              onPressed: (context) {},
                            ),
                          ],
                          dismissible: DismissiblePane(
                            onDismissed: () => _deleteTask(
                                context: context, selectedTask: task),
                          ),
                        ),
                        key: ValueKey<int>(task.id),
                      ),
              );
            },
          ),
        );
      },
    );
  }

  ///
  Widget _createTaskListTile(
      {required BuildContext context, required Task task}) {
    return TileListTilePart(
      task: task,
      onFinishChanged: (isFinished) => _finishTask(
          context: context, isFinished: isFinished, selectedTask: task),
      onDelete: () => _deleteTask(context: context, selectedTask: task),
      onEdit: () => _showTaskDetail(context: context, selectedTask: task),
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

  ///
  _finishTask(
      {required BuildContext context,
      required isFinished,
      required Task selectedTask}) {
    if (isFinished == null) return;

    final viewModel = context.read<ViewModel>();
    viewModel.finishTask(selectedTask: selectedTask, isFinished: isFinished);

    showSnackBar(
      context: context,
      contentText: StringR.finishTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );

    viewModel.setCurrentTask(null);
  }

  ///
  _deleteTask({required BuildContext context, required Task selectedTask}) {
    final viewModel = context.read<ViewModel>();
    viewModel.deleteTask(selectedTask: selectedTask);

    showSnackBar(
      context: context,
      contentText: StringR.deleteTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );

    viewModel.setCurrentTask(null);
  }

  ///
  _showTaskDetail({required BuildContext context, required Task selectedTask}) {
    final viewModel = context.read<ViewModel>();
    final screenSize = viewModel.screenSize;
    viewModel.setCurrentTask(selectedTask);

    if (screenSize == ScreenSize.SMALL) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DetailScreen(),
        ),
      );
    }
  }
}
