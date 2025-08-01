import 'package:clive/ui/widgets/app_button.dart';
import 'package:clive/util/route/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/custom_popup.dart';
import 'app_text_styles.dart';
import 'color_manager.dart';

class UIActions {

  static void _showPopup(
      BuildContext context,
      Widget Function(BuildContext context) builder,
      {bool canDismiss = false}) {
    showDialog(
      barrierDismissible: canDismiss,
      context: context,
      builder: builder,
    );
  }
  static Widget? showSuccessPopup(
      BuildContext context, {
        Function()? onTap,
        required String message,
        String? buttonTitle,
      }) {
    _showPopup(context, (context) {
      return CustomDialog(children: [
        Icon(Icons.check_circle_outline_rounded, size: 100, color: ColorManager.green,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.black(size: 18, weight: FontWeight.w600),
          ),
        ),
        AppButton(
          title: buttonTitle ?? 'Ok',
          onTap: () {
            AppRouter.goBack(context);
            onTap?.call();
          },
        ),
      ]);
    });
    return null;
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


  static Widget? showPriSecPopup(
      BuildContext context, {
        Function()? onTap,
        required String message,
        String? buttonTitle,
        String? secButtonTitle,
      }) {
    _showPopup(context, (context) {
      return CustomDialog(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            message,
            style: AppTextStyles.black(size: 18, weight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          children: [
            Flexible(
              child: AppButton(
                title: secButtonTitle ?? 'Cancel',
                textColor: ColorManager.green,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.green),
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  AppRouter.goBack(context);
                },
              )
            ),
            SizedBox(width: 20),
            Flexible(
              child: AppButton(
                title: buttonTitle ?? 'Yes',
                onTap: () {
                  AppRouter.goBack(context);
                  onTap?.call();
                },
              ),
            ),
          ],
        )
      ]);
    });
    return null;
  }
}