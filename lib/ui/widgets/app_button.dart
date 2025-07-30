import 'package:flutter/material.dart';

import '../../util/ui_util/color_manager.dart';

class AppButton extends StatelessWidget {
  const AppButton({this.onTap, required this.title, super.key});
  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)),
      ),
    );
  }
}
