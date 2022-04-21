import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';

import '../../util/functions.dart';

class TileListTilePart extends StatelessWidget {
  const TileListTilePart({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AutoSizeText(task.title),
      subtitle: Text(convertDateTimeToString(task.limitDateTime)),
    );
  }
}
