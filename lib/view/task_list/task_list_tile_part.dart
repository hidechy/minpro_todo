import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';

import '../../util/functions.dart';

import '../../util/constants.dart';

import '../style.dart';

class TileListTilePart extends StatefulWidget {
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
  State<TileListTilePart> createState() => _TileListTilePartState();
}

class _TileListTilePartState extends State<TileListTilePart> {
  bool isDisplayPopupMenu = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          isDisplayPopupMenu = true;
        });
      },
      onExit: (event) {
        setState(() {
          isDisplayPopupMenu = false;
        });
      },
      child: ListTile(
        leading: Radio(
          value: true,
          groupValue: widget.task.isFinished,
          onChanged: (value) => widget.onFinishChanged(value),
        ),
        title: Row(
          children: [
            (widget.task.isImportant)
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
                widget.task.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle:
            AutoSizeText(convertDateTimeToString(widget.task.limitDateTime)),
        onLongPress: widget.onDelete,
        onTap: widget.onEdit,
        // trailing: (isDisplayPopupMenu)
        //     ? PopupMenuButton(
        //         tooltip: StringR.showMenu,
        //         icon: Icon(Icons.more_vert),
        //         itemBuilder: (BuildContext context) {
        //           return [
        //             PopupMenuItem<TaskListTileMenu>(
        //               child: Text(StringR.edit),
        //               value: TaskListTileMenu.EDIT,
        //             ),
        //             PopupMenuItem<TaskListTileMenu>(
        //               child: Text(StringR.delete),
        //               value: TaskListTileMenu.DELETE,
        //             ),
        //           ];
        //         },
        //         onSelected: (selectedMenu) {
        //           if (selectedMenu == TaskListTileMenu.EDIT) {
        //             widget.onEdit();
        //           } else {
        //             widget.onDelete();
        //           }
        //         },
        //       )
        //     : null,

        trailing: PopupMenuButton(
          tooltip: StringR.showMenu,
          icon: (isDisplayPopupMenu) ? Icon(Icons.more_vert) : Container(),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<TaskListTileMenu>(
                child: Text(StringR.edit),
                value: TaskListTileMenu.EDIT,
              ),
              PopupMenuItem<TaskListTileMenu>(
                child: Text(StringR.delete),
                value: TaskListTileMenu.DELETE,
              ),
            ];
          },
          onSelected: (selectedMenu) {
            if (selectedMenu == TaskListTileMenu.EDIT) {
              widget.onEdit();
            } else {
              widget.onDelete();
            }
          },
        ),
      ),
    );
  }
}
