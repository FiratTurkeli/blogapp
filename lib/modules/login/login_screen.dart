import 'package:blogapp/constant/text_style.dart';
import 'package:blogapp/controller/internet_controller.dart';
import 'package:blogapp/data/controller/local_storage_controller.dart';
import 'package:blogapp/data/controller/user_login_controller.dart';
import 'package:blogapp/constant/ui_helper.dart';
import 'package:blogapp/modules/login/login_controller.dart';
import 'package:blogapp/routes/app_pages.dart';
import 'package:blogapp/widgets/button1.dart';
import 'package:blogapp/widgets/headertext.dart';
import 'package:blogapp/widgets/textform1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  GlobalKey<FormState> _formKeyLogin =
  GlobalKey<FormState>(debugLabel: "login");
  final NetController netContoller = Get.put(NetController());
  final PrefController prefController = Get.put(PrefController());
  final UserLoginController loginController = Get.put(UserLoginController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          title: Text('Login', style: titleStyle,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Obx(() => Column(children: [
                UIHelper.verticalSpace(16),
                headerText(),
                UIHelper.verticalSpace(16),
                Form(
                    key: _formKeyLogin,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildTextFormFieldWidgetEmail(controller),
                              UIHelper.verticalSpace(16),
                              buildTextFormFieldWidgetPass(controller),
                              UIHelper.verticalSpace(16),
                              _loginButton(context),
                              UIHelper.verticalSpace(16),
                              _registerButton(context),
                            ]
                        )
                    )
                )
              ]
              )
              )
          ),
        )
    );
  }




TextFormField1 buildTextFormFieldWidgetEmail(LoginController controller) {
  return TextFormField1(
    controller: controller,
    action: TextInputAction.next,
    hintText: 'Email',
    obscureText: false,
    prefixIconData: Icons.email,
    onChanged: (value) => controller.email.value = value.trim(),
    validator: controller.validateEmail,
  );
}




TextFormField1 buildTextFormFieldWidgetPass(LoginController controller) {
  return TextFormField1(
      controller: controller,
      action: TextInputAction.send,
      hintText: 'Password',
      obscureText: controller.isVisible.value ? false : true,
      prefixIconData: Icons.lock,
      suffixIconData:
      controller.isVisible.value ? Icons.visibility_off : Icons.visibility,
      validator: controller.validatePassword,
      onChanged: (value) => controller.password.value = value.trim());
}




  ButtonWidget1 _loginButton(BuildContext context) {
    return ButtonWidget1(
      text: "Login",
      icon: Icons.login_rounded,
      tcolor: Colors.white,
      onClick: netContoller.isOnline
          ? () async {
        if (_formKeyLogin.currentState!.validate()) {
          await loginController
              .login(controller.email.value, controller.password.value)
              .then((value) {
            if (loginController.user.value.hasError == false &&
                loginController.isLoginLoading.value == false) {
              Get.offAndToNamed(Routes.BOTTOM);
            } else {
              Get.snackbar(
                  'Warning..!',
                  loginController
                      .user
                      .value
                      .validationErrors!
                      .isEmpty
                      ? "${loginController.user.value.message}."
                      : "${loginController.user.value.validationErrors!.first["Value"] ?? ""}. ${loginController.user.value.message}.",
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          });
        }
      }
          : () {},
      color: Colors.lightGreen,
    );
  }
}




ButtonWidget1 _registerButton(BuildContext context) {
  return ButtonWidget1(
    text: "Register",
    icon: Icons.login,
    tcolor: Colors.lightGreen,
    onClick: () {
      Get.toNamed(Routes.REGISTER);
    },
    color: Colors.white,
  );
}


