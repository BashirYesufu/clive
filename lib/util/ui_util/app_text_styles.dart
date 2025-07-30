import 'package:flutter/material.dart';

import 'package:clive/util/ui_util/color_manager.dart';

class AppTextStyles {

  static TextStyle? black({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: ColorManager.black, fontWeight: weight ?? FontWeight.w400);
  static TextStyle green({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: ColorManager.green, fontWeight: weight ?? FontWeight.w400);
  static TextStyle deepGreen({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: ColorManager.deepGreen, fontWeight: weight ?? FontWeight.w400);
  static TextStyle blue({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: ColorManager.blue, fontWeight: weight ?? FontWeight.w400);
  static TextStyle grey({FontWeight? weight, double? size}) => TextStyle(fontSize: size ?? 14, color: ColorManager.grey, fontWeight: weight ?? FontWeight.w400);
}