import 'package:flutter/material.dart';

import '../model/task_repository.dart';
import '../view/style.dart';

class ViewModel extends ChangeNotifier {
  final TaskRepository repository;

  ViewModel({required this.repository});

  ScreenSize screenSize = ScreenSize.SMALL;
}
