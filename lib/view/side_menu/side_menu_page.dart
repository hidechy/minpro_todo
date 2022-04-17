import 'package:flutter/material.dart';

import '../style.dart';

import '../../util/constants.dart';

import 'package:provider/provider.dart';
import '../../view_model/view_model.dart';

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
            onTap: () {
              final viewModel = context.read<ViewModel>();
              final screenSize = viewModel.screenSize;
              if (screenSize != ScreenSize.LARGE) Navigator.pop(context);

              _addNewTask(context: context);
            },
          ),
          SwitchListTile(
            value: false,
            onChanged: null,
            title: Text(StringR.isFinishedTaskIncluded),
          ),
          AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationIcon: FlutterLogo(),
            applicationName: StringR.appTitle,
            applicationLegalese: "\u{a9} 2022 Hidechy.",
            aboutBoxChildren: [
              Text('他の情報やWidgetが出せる'),
            ],
          ),
        ],
      ),
    );
  }

  ///
  _addNewTask({required BuildContext context}) {}
}
