// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class PageColor {
  static const sideMenuBgColor = Color(0xFF1b1b1b);
  static const taskListBgColor = Color(0xFF212121);
  static const detailBgColor = Color(0xFF424242);
}

class BreakPointWidth {
  static const double smallToMid = 600;
  static const double midToLarge = 1240;
}

enum ScreenSize {
  SMALL,
  MID,
  LARGE,
}

class WidgetSize {
  static const double addTaskDialogWidth = 500.0;
  static const double addTaskDialogHeight = 500.0;
}
