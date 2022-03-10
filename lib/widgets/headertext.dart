import 'package:blogapp/constant/text_style.dart';
import 'package:flutter/material.dart';

Widget headerText(){
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0, top: 15),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(60),
        ),
        width: 170,
        height: 170,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("BLOGS" , style: headerStyle),
              Text("Journey to pleasures", style: subtitleStyle,)
            ],
          ),
        ),
      ),
    ),
  );
}