import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';

import '../../util/functions.dart';

import '../../util/constants.dart';

import '../style.dart';

class TileListTilePart extends StatelessWidget {
  const TileListTilePart({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          (task.isImportant)
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text(
                      StringR.important,
                      style: TextStyles.listTileChipTextStyle,
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: AutoSizeText(
              task.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: AutoSizeText(convertDateTimeToString(task.limitDateTime)),
    );
  }
}
