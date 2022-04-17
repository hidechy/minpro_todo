import 'package:flutter/material.dart';

import '../style.dart';

import '../../util/constants.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageColor.sideMenuBgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                FlutterLogo(
                  size: 100.0,
                ),
                Text(StringR.appTitle),
              ],
            ),
          ),
          ListTile(
            title: Text(StringR.addNewTask),
            onTap: () => _addNewTask(context: context),
          ),
          SwitchListTile(
            value: false,
            onChanged: null,
            title: Text(StringR.isFinishedTaskIncluded),
          ),
        ],
      ),
    );
  }

  ///
  _addNewTask({required BuildContext context}) {}
}
