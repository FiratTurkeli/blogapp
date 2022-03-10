import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFormField1 extends StatelessWidget {
  final String hintText;
  final controller;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final TextInputAction action;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  TextFormField1(
      {required this.hintText,
        required this.controller,
        required this.prefixIconData,
        this.suffixIconData,
        required this.obscureText,
        required this.onChanged,
        required this.action,
        this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .9,
      child: TextFormField(
        textInputAction: action,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        cursorColor: Colors.white,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),

        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white, fontSize: 18.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.lightGreen, width: 1.5),
          ),

          labelText: hintText,
          prefixIcon: Icon(
            prefixIconData,
            size: 25,
            color: Colors.white,
          ),

          suffixIcon: GestureDetector(
            onTap: () {
              controller.isVisible.value = !controller.isVisible.value;
            },
            child: Icon(
              suffixIconData,
              size: 20,
              color: controller.isVisible.value ? Colors.lightGreen : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}