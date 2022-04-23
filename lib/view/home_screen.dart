import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'style.dart';

import '../view_model/view_model.dart';

import 'detail/detail_page.dart';
import 'side_menu/side_menu_page.dart';
import 'task_list/task_list_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= BreakPointWidth.midToLarge) {
        viewModel.screenSize = ScreenSize.LARGE;

        return Row(
          children: [
            const Expanded(
              flex: 3,
              child: SideMenuPage(),
            ),
            const Expanded(
              flex: 4,
              child: TaskListPage(),
            ),
            Expanded(
              flex: 6,
              child: DetailPage(),
            ),
          ],
        );
      } else if (constraints.maxWidth >= BreakPointWidth.smallToMid) {
        viewModel.screenSize = ScreenSize.MID;

        return Row(
          children: [
            const Expanded(
              flex: 1,
              child: TaskListPage(),
            ),
            Expanded(
              flex: 2,
              child: DetailPage(),
            ),
          ],
        );
      } else {
        viewModel.screenSize = ScreenSize.SMALL;

        return const TaskListPage();
      }
    });
  }
}
