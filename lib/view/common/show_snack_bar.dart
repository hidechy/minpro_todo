import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/view_model.dart';

import '../style.dart';

import '../../util/constants.dart';

showSnackBar({
  required BuildContext context,
  required String contentText,
  required bool isSnackBarActionNeeded,
  VoidCallback? onUndone,
}) {
  final viewModel = context.read<ViewModel>();
  final screenSize = viewModel.screenSize;

  if (screenSize == ScreenSize.SMALL) {
    final snackBar = SnackBar(
      content: Text(contentText),
      action: (isSnackBarActionNeeded || onUndone != null)
          ? SnackBarAction(
              label: StringR.undo,
              onPressed: onUndone!,
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(contentText),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: AutoSizeText(StringR.close),
                    ),
                    HorizontalSpacer.snackBar,
                    (isSnackBarActionNeeded || onUndone != null)
                        ? TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onUndone!();
                            },
                            child: AutoSizeText(StringR.undo),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
