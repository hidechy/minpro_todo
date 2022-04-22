import 'package:flutter/material.dart';
import 'package:minpro_todo/data/task.dart';

import '../model/task_repository.dart';
import '../view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  ScreenSize screenSize = ScreenSize.SMALL;

  List<Task> selectedTaskList = [];

  bool isSorted = false;

  bool isFinishedTaskIncluded = false;

  ///
  void addNewTask(
    String title,
    String detail,
    DateTime limitDateTime,
    bool isImportant,
  ) {
    repository.addNewTask(title, detail, limitDateTime, isImportant);

    getTaskList();
  }

  ///
  void getTaskList() {
    selectedTaskList = repository.getTaskList(
      isSorted: isSorted,
      isFinishedTaskIncluded: isFinishedTaskIncluded,
    );

    notifyListeners();
  }

  ///
  void sort(bool isSort) {
    isSorted = isSort;
    getTaskList();
  }

  ///
  void finishTask({required Task selectedTask, required isFinished}) {
    repository.finishTask(selectedTask: selectedTask, isFinished: isFinished);
    getTaskList();
  }

  ///
  undo() {
    repository.undo();
    getTaskList();
  }
}
