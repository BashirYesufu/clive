import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../util/ui_util/color_manager.dart';

class AppSwitch extends StatefulWidget {
  AppSwitch({required this.isOn, this.onToggle, this.enabled = true, super.key});

  bool isOn;
  final Function(bool)? onToggle;
  final bool enabled;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 40.0,
      height: 20.0,
      toggleSize: 20.0,
      value: widget.isOn,
      borderRadius: 13.0,
      activeColor: ColorManager.green,
      inactiveColor: ColorManager.grey,
      onToggle: (val) {
        if(!widget.enabled){
          return;
        }
        setState(() {
          widget.isOn = val;
        });
        if (widget.onToggle != null) {
          widget.onToggle!(val);
        }
      },
    );
  }
}
