import 'package:flutter/material.dart';

import '../style.dart';

import '../../util/constants.dart';

import 'package:provider/provider.dart';
import '../../view_model/view_model.dart';

import '../common/show_add_new_task.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.sideMenuBgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                const FlutterLogo(
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
          Consumer<ViewModel>(
            builder: (context, vm, child) {
              final isFinishedTaskIncluded = vm.isFinishedTaskIncluded;

              return SwitchListTile(
                value: isFinishedTaskIncluded,
                onChanged: (isIncluded) =>
                    vm.changeFinishStatus(isIncluded: isIncluded),
                title: Text(StringR.isFinishedTaskIncluded),
              );
            },
          ),
          ListTile(
            title: Text(StringR.showLicense),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: StringR.appTitle,
                applicationIcon: const FlutterLogo(),
                applicationLegalese: "\u{a9} 2022 Hidechy.",
                applicationVersion: "1.0.0",
              );

              // showAboutDialog(
              //   context: context,
              //   applicationIcon: const FlutterLogo(),
              //   applicationName: StringR.appTitle,
              //   applicationLegalese: "\u{a9} 2022 Hidechy.",
              //   children: [
              //     const Text('???????????????Widget????????????'),
              //   ],
              // );
            },
          ),
          AboutListTile(
            icon: const Icon(Icons.info_outline),
            applicationIcon: const FlutterLogo(),
            applicationName: StringR.appTitle,
            applicationLegalese: "\u{a9} 2022 Hidechy.",
            aboutBoxChildren: const [
              Text('???????????????Widget????????????'),
            ],
          ),
        ],
      ),
    );
  }

  ///
  _addNewTask({required BuildContext context}) {
    showAddNewTask(context: context);
  }
}
