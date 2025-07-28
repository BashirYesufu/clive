import 'dart:ui';

import 'package:clive/util/ui_util/color_manager.dart';

class AppTextStyles {

  static TextStyle? black({FontWeight? weight}) => TextStyle(color: ColorManager.black, fontWeight: weight ?? FontWeight.w400);
  static TextStyle green({FontWeight? weight}) => TextStyle(color: ColorManager.green, fontWeight: weight ?? FontWeight.w400);
  static TextStyle blue({FontWeight? weight}) => TextStyle(color: ColorManager.blue, fontWeight: weight ?? FontWeight.w400);
}