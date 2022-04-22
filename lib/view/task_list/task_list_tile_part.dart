import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';

import '../../util/functions.dart';

import '../../util/constants.dart';

import '../style.dart';

class TileListTilePart extends StatelessWidget {
  const TileListTilePart(
      {Key? key,
      required this.task,
      required this.onFinishChanged,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  final Task task;

  final ValueChanged onFinishChanged;

  final VoidCallback onDelete;

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio(
        value: true,
        groupValue: task.isFinished,
        onChanged: (value) => onFinishChanged(value),
      ),
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
      onLongPress: onDelete,
      onTap: onEdit,
    );
  }
}
