import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/view_model.dart';

import '../style.dart';

import '../../util/constants.dart';

showSnackBar({required BuildContext context, required String contentText}) {
  final viewModel = context.read<ViewModel>();
  final screenSize = viewModel.screenSize;

  if (screenSize == ScreenSize.SMALL) {
    final snackBar = SnackBar(
      content: Text(contentText),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(contentText),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: AutoSizeText(StringR.close),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
