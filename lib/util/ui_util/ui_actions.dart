import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

class UIActions {

  void showSuccessPopup(BuildContext context, String message){

  }

  static void showSheet(BuildContext context, {double height = 350, Widget? child, Color? backgroundColor, bool isDismissible = true, bool isDraggable = true}){
    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: isDraggable,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? ColorManager.backGround,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: height,
              child: child,
            ),
          ),
    );
  }

}