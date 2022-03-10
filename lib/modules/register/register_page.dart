import 'package:blogapp/constant/text_style.dart';
import 'package:blogapp/controller/internet_controller.dart';
import 'package:blogapp/data/controller/controller.dart';
import 'package:blogapp/data/controller/local_storage_controller.dart';
import 'package:blogapp/constant/ui_helper.dart';
import 'package:blogapp/modules/register/register_controller.dart';
import 'package:blogapp/widgets/button1.dart';
import 'package:blogapp/widgets/headertext.dart';
import 'package:blogapp/widgets/textform1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class RegisterPage extends GetView<RegisterController> {
  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  final NetController netContoller = Get.put(NetController());
  final ApiController apiController = Get.put(ApiController());
  final PrefController prefController = Get.put(PrefController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey.withOpacity(0.7) ,
          title: Text('Sign Up' , style: subtitleStyle,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [

                headerText(),

                Form(
                    key: _formKeyRegister,
                    child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildTextFormFieldWidgetEmail(controller),
                              UIHelper.verticalSpace(16),
                              buildTextFormFieldWidgetPass(
                                  "Password", controller),
                              UIHelper.verticalSpace(16),
                              buildTextFormFieldWidgetPass(
                                  "Re-Password", controller),
                              UIHelper.verticalSpace(16),
                              _registerButton(context),
                              UIHelper.verticalSpace(16),
                              _loginButton(context),
                            ]))))
              ]
              )
          ),
        )
    );
  }






TextFormField1 buildTextFormFieldWidgetEmail(RegisterController controller) {
  return TextFormField1(
    controller: controller,
    action: TextInputAction.next,
    hintText: 'Email',
    obscureText: false,
    prefixIconData: Icons.email,
    validator: controller.validateEmail,
    onChanged: (value) => controller.email.value = value.trim(),
  );
}



TextFormField1 buildTextFormFieldWidgetPass(
    String text, RegisterController controller) {
  return TextFormField1(
    controller: controller,
    action: text == "Password" ? TextInputAction.next : TextInputAction.send,
    hintText: text,
    obscureText: controller.isVisible.value ? false : true,
    prefixIconData: Icons.lock,
    onChanged: (value) {
      if (text == "Password") {
        controller.password.value = value.trim();
      } else {
        controller.passwordRetry.value = value.trim();
      }
    },
    suffixIconData:
    controller.isVisible.value ? Icons.visibility_off : Icons.visibility,
    validator: text == "Password"
        ? controller.validatePassword
        : controller.validatePasswordRetry,
  );
}

  ButtonWidget1 _registerButton(BuildContext context) {
    return ButtonWidget1(
      text: "Register",
        icon: Icons.login_outlined,
      color: Colors.lightGreen,
      tcolor: Colors.white,
      onClick: () async {
        if (_formKeyRegister.currentState!.validate()) {
          await apiController
              .signUp(controller.email.value, controller.password.value,
              controller.passwordRetry.value)
              .whenComplete(() async {
            await apiController.login(
                controller.email.value, controller.password.value);
            if (apiController.user.value.hasError == false &&
                controller.password.value == controller.passwordRetry.value &&
                apiController.isRegisterLoading.value == false) {
              prefController.token.value =
              apiController.user.value.data!.token!;
              prefController.isLogin.value = true;
              prefController.saveToPrefs();
              Get.offAndToNamed(Routes.BOTTOM);
            } else {
              Get.snackbar(
                  'Warning..!',
                  apiController.user.value.validationErrors!.isEmpty
                      ? "${apiController.user.value.message}."
                      : "${apiController.user.value.validationErrors!.first["Value"] ?? ""}. ${apiController.user.value.message}.",
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          });
        }
      }
    );
  }
}



ButtonWidget1 _loginButton(BuildContext context) {
  return ButtonWidget1(
    text: "Login",
    icon: Icons.login_outlined,
    color: Colors.white,
    tcolor: Colors.lightGreen,
    onClick: () {
      Get.toNamed(Routes.LOGIN);
    },

  );
}