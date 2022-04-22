import '../data/task.dart';

class TaskRepository {
  List<Task> baseTaskListBeforeChange = [];

  void addNewTask(
    String title,
    String detail,
    DateTime limitDateTime,
    bool isImportant,
  ) {
    final nextId = getNextId();

    final newTask = Task(
      id: nextId,
      title: title,
      detail: detail,
      limitDateTime: limitDateTime,
      isImportant: isImportant,
      isFinished: false,
    );

    baseTaskList.add(newTask);
  }

  ///
  int getNextId() {
    final maxId = baseTaskList.reduce((currentTodo, nextTodo) {
      return (currentTodo.id > nextTodo.id) ? currentTodo : nextTodo;
    }).id;

    return maxId + 1;
  }

  ///
  List<Task> getTaskList({
    required bool isSorted,
    required bool isFinishedTaskIncluded,
  }) {
    var returnList = <Task>[];
    returnList =
        getBaseTaskList(isFinishedTaskIncluded: isFinishedTaskIncluded);

    if (isSorted) {
      return sortByImportant(returnList);
    }

    return returnList;
  }

  ///
  List<Task> getBaseTaskList({required bool isFinishedTaskIncluded}) {
    baseTaskList.sort((a, b) => a.limitDateTime.compareTo(b.limitDateTime));

    if (isFinishedTaskIncluded) {
      return baseTaskList;
    } else {
      return baseTaskList.where((task) => task.isFinished == false).toList();
    }
  }

  ///
  List<Task> sortByImportant(List<Task> taskList) {
    /*
    taskList.sort((a, b) {
//      return (a.isImportant) ? -1 : 1;

      final isImportantA = a.isImportant;
      final isImportantB = b.isImportant;
      final compare = a.limitDateTime.compareTo(b.limitDateTime);
      if (isImportantA && (isImportantB || compare < 0)) {
        return -1;
      } else if (!isImportantB && compare < 0) {
        return -1;
      } else {
        return 1;
      }
    });
    */

    final listImportant =
        taskList.where((task) => task.isImportant == true).toList();
    final listNotImportant =
        taskList.where((task) => task.isImportant == false).toList();

    listImportant.sort((a, b) => a.limitDateTime.compareTo(b.limitDateTime));
    listNotImportant.sort((a, b) => a.limitDateTime.compareTo(b.limitDateTime));

    taskList = [
      ...listImportant,
      ...listNotImportant,
    ];

    return taskList;
  }

  ///
  void finishTask({required Task selectedTask, required isFinished}) {
    ///
//    baseTaskListBeforeChange = baseTaskList;
    baseTaskListBeforeChange = [...baseTaskList];

    final updateTask = selectedTask.copyWith(isFinished: isFinished);
    updateTaskList(updateTask: updateTask);
  }

  ///
  void updateTaskList({required Task updateTask}) {
//    final index = baseTaskList.indexOf(updateTask);
    final index = searchIndex(selectedTask: updateTask);

    baseTaskList[index] = updateTask;
  }

  ///
  int searchIndex({required Task selectedTask}) {
    return baseTaskList.indexWhere((task) => task.id == selectedTask.id);
  }

  ///
  void undo() {
    baseTaskList = baseTaskListBeforeChange;
  }

  ///
  void deleteTask(Task deleteTask) {
    baseTaskListBeforeChange = [...baseTaskList];
    final index = searchIndex(selectedTask: deleteTask);
    baseTaskList.removeAt(index);
  }
}
