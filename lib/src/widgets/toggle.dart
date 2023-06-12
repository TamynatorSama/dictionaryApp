// ignore_for_file: deprecated_member_use

import 'package:dictionary_app/src/settings/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Toggle extends StatefulWidget {
  const Toggle({super.key});

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  bool toogle = true;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) { 
      toogle = Theme.of(context).brightness == Brightness.light?false:true;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
            toogle = !toogle;
            customTheme.toggle();
            // widget.settingsController.updateThemeMode(newThemeMode);
          });
          },
          child: Container(
            height: 22,
            width: 40,
            padding: const EdgeInsets.all(1.6),
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color:  Theme.of(context).primaryColorDark
              ),
              child: AnimatedAlign(
                alignment: toogle? AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 18,
                  height: 20,
                  decoration: const  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                ),
              ),
          ),
        ),
        const SizedBox(width: 15,),
        SvgPicture.asset("assets/images/icon-moon.svg",color: Theme.of(context).primaryColorDark,),
      ],
    );
  }
}