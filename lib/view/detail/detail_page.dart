import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../style.dart';

import '../../data/task.dart';
import '../../view_model/view_model.dart';
import '../../util/constants.dart';

import '../common/task_content_part.dart';

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
                    const IconButton(
                      icon: Icon(Icons.done),
                      onPressed: null,
                    ),
                    const IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: null,
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
}
