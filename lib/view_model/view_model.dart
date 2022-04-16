import 'package:flutter/material.dart';
import 'package:minpro_todo/model/task_repository.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});
}
