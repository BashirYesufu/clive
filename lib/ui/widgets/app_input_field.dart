import 'package:clive/util/ui_util/color_manager.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({this.title = '',super.key});
  final String title;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.border,
              width: 1
            ),
            borderRadius: BorderRadius.circular(8)
          ),
          child: TextField(

          ),
        ),
      ],
    );
  }
}
