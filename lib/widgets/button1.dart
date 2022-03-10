import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget1 extends StatelessWidget {
  final Widget? widget;
  final IconData? icon;
  final String text;
  final Color? color;
  final Color? tcolor;
  final void Function()? onClick;
  final double? width;
  final double? height;

  const ButtonWidget1(
      {Key? key,
        this.widget,
        this.icon,
        required this.text,
        this.color,
        this.onClick,
        this.height,
        this.width,
        this.tcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .08,
      width:  Get.width * .9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(

          shape: const RoundedRectangleBorder(
              side:  BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          primary: color,
        ),
        onPressed: onClick,
        child:
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(icon, color: tcolor),
                ),
                Align(
                  alignment: Alignment.center,
                  child:
                  Text(text, style: TextStyle(fontSize: 18, color: tcolor)),
                ),
              ],
            ),
      ),
    );
  }
}