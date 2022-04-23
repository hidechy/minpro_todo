import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../style.dart';

import '../../data/task.dart';
import '../../view_model/view_model.dart';
import '../../util/constants.dart';

import '../common/task_content_part.dart';

import '../common/show_snack_bar.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  final taskContentPartKey = GlobalKey<TaskContentPartState>();

  @override
  Widget build(BuildContext context) {
    return Selector<ViewModel, Tuple2<Task?, ScreenSize>>(
      selector: (context, vm) => Tuple2(vm.currentTask, vm.screenSize),
      builder: (context, data, child) {
        final selectedTask = data.item1;
        final screenSize = data.item2;

        if (selectedTask != null && screenSize != ScreenSize.SMALL) {
          _updateDetailInfo(selectedTask: selectedTask);
        }

        return Scaffold(
          backgroundColor: CustomColors.detailBgColor,
          appBar: AppBar(
            leading: (selectedTask != null)
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _clearCurrentTask(context: context);

                      if (screenSize == ScreenSize.SMALL) {
                        Navigator.pop(context);
                      }
                    },
                  )
                : null,
            title: Text(StringR.taskDetail),
            centerTitle: true,
            actions: (selectedTask != null)
                ? [
                    IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () => _updateTask(
                          context: context, selectedTask: selectedTask),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTask(
                          context: context, selectedTask: selectedTask),
                    ),
                  ]
                : null,
          ),
          // body: ListTile(
          //   title: Text(selectedTask?.title ?? ""),
          //   subtitle: Text(selectedTask?.limitDateTime.toString() ?? ""),
          // ),
          body: (selectedTask != null)
              ? TaskContentPart(
                  key: taskContentPartKey,
                  isEditMode: true,
                  selectedTask: selectedTask,
                )
              : null,
          floatingActionButton: (selectedTask != null)
              ? FloatingActionButton.extended(
                  onPressed: () =>
                      _finishTask(context: context, selectedTask: selectedTask),
                  label: Text(
                    (!selectedTask.isFinished)
                        ? StringR.complete
                        : StringR.inComplete,
                    style: TextStyles.completeButtonTextStyle.copyWith(
                      color: CustomColors.detailFabTextColor(context),
                    ),
                  ),
                  backgroundColor: CustomColors.detailPageFabBgColor,
                  elevation: 0.0,
                )
              : null,
        );
      },
    );
  }

  ///
  void _clearCurrentTask({required BuildContext context}) {
    final viewModel = context.read<ViewModel>();
    viewModel.setCurrentTask(null);
  }

  ///
  void _updateDetailInfo({required Task selectedTask}) {
    final taskContentPartState = taskContentPartKey.currentState;
    if (taskContentPartState == null) return;

    taskContentPartState.taskEditing = selectedTask;
    taskContentPartState.setDetailData();
  }

  ///
  _updateTask({required BuildContext context, required Task selectedTask}) {
    final taskContentPartState = taskContentPartKey.currentState;
    if (taskContentPartState == null) return;

    if (taskContentPartState.formKey.currentState!.validate()) {
      final viewModel = context.read<ViewModel>();

      final taskUpdated = selectedTask.copyWith(
        title: taskContentPartState.titleController.text,
        detail: taskContentPartState.detailController.text,
        limitDateTime: taskContentPartState.limitDateTime,
        isImportant: taskContentPartState.isImportant,
      );

      viewModel.updateTask(taskUpdated: taskUpdated);

      showSnackBar(
        context: context,
        contentText: StringR.editTaskCompleted,
        isSnackBarActionNeeded: false,
      );

      endEditTask(
        context: context,
        isEdit: true,
      );
    }
  }

  ///
  void endEditTask({required BuildContext context, required bool isEdit}) {
    final viewModel = context.read<ViewModel>();
    final screenSize = viewModel.screenSize;

    if (screenSize == ScreenSize.SMALL) {
      Navigator.pop(context);
    } else {
      if (!isEdit) viewModel.setCurrentTask(null);
    }
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

    endEditTask(
      context: context,
      isEdit: false,
    );
  }

  ///
  _finishTask({required BuildContext context, required Task selectedTask}) {
    final viewModel = context.read<ViewModel>();
    final isFinished = !selectedTask.isFinished;
    viewModel.finishTask(selectedTask: selectedTask, isFinished: isFinished);

    showSnackBar(
      context: context,
      contentText: (isFinished)
          ? StringR.finishTaskCompleted
          : StringR.unFinishTaskCompleted,
      isSnackBarActionNeeded: true,
      onUndone: () => viewModel.undo(),
    );

    endEditTask(
      context: context,
      isEdit: false,
    );
  }
}
