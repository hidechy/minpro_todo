import 'package:minpro_todo/view_model/view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../model/task_repository.dart';

List<SingleChildWidget> globalProviders = [...independentModels, ...viewModels];

List<SingleChildWidget> independentModels = [
  Provider<TaskRepository>(
    create: (context) => TaskRepository(),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<ViewModel>(
    create: (context) => ViewModel(
      repository: context.read<TaskRepository>(),
    ),
  )
];
