import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:youtube_ecommerce/constants/constants.dart';
import 'package:youtube_ecommerce/controllers/auth_controller.dart';
import 'package:youtube_ecommerce/views/home_screen/home.dart';
import 'package:youtube_ecommerce/widgets_common/applogo_widget.dart';
import 'package:youtube_ecommerce/widgets_common/bgWidget.dart';
import 'package:youtube_ecommerce/widgets_common/custom_textfield.dart';
import 'package:youtube_ecommerce/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(children: [
        (context.screenHeight * 0.1).heightBox,
        applogoWidget(),
        10.heightBox,
        "Join the $appname".text.fontFamily(bold).white.size(18).make(),
        15.heightBox,
        Obx(
          () => Column(
            children: [
              customTextField(
                  title: name,
                  hint: nameHint,
                  controller: nameController,
                  isPass: false),
              customTextField(
                  title: email,
                  hint: emailHint,
                  controller: emailController,
                  isPass: false),
              customTextField(
                  title: password,
                  hint: passwordHint,
                  controller: passwordController,
                  isPass: true),
              customTextField(
                  title: retypePassword,
                  hint: passwordHint,
                  controller: passwordRetypeController,
                  isPass: true),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: forgetPass.text.make())),
              Row(
                children: [
                  Checkbox(
                    checkColor: redColor,
                    value: isCheck,
                    onChanged: (newValue) {
                      setState(() {
                        isCheck = newValue;
                      });
                    },
                  ),
                  10.widthBox,
                  Expanded(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: termAndCond,
                          style: TextStyle(
                            fontFamily: regular,
                            color: redColor,
                          )),
                      TextSpan(
                          text: "&",
                          style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: privacyPolicy,
                          style: TextStyle(
                            fontFamily: regular,
                            color: redColor,
                          )),
                    ])),
                  )
                ],
              ),
              5.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : ourButton(
                      onPress: () async {
                        if (isCheck != false) {
                          controller.isLoading(true);
                          try {
                            await controller
                                .signupMethod(
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                              return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text);
                            }).then((value) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                            });
                          } catch (e) {
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isLoading(false);
                          }
                        }
                      },
                      color: isCheck == true ? redColor : lightGrey,
                      textColor: whiteColor,
                      title: signup,
                    ).box.width(context.screenWidth - 50).make(),
              10.heightBox,

              // wraping into gesture detector of velocity x
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                alreadyHaveAccount.text.color(fontGrey).make(),
                login.text.color(redColor).make().onTap(() {
                  Get.back();
                })
              ]),
            ],
          )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .shadowSm
              .make(),
        ),
      ])),
    ));
  }
}
