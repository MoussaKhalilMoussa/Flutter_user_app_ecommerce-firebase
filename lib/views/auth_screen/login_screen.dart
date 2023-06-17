import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:youtube_ecommerce/constants/constants.dart';
import 'package:youtube_ecommerce/constants/list.dart';
import 'package:youtube_ecommerce/controllers/auth_controller.dart';
import 'package:youtube_ecommerce/views/auth_screen/signup_screen.dart';
import 'package:youtube_ecommerce/views/home_screen/home.dart';
import 'package:youtube_ecommerce/widgets_common/applogo_widget.dart';
import 'package:youtube_ecommerce/widgets_common/bgWidget.dart';
import 'package:youtube_ecommerce/widgets_common/custom_textfield.dart';
import 'package:youtube_ecommerce/widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(children: [
        (context.screenHeight * 0.1).heightBox,
        applogoWidget(),
        10.heightBox,
        "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
        15.heightBox,
        Obx(
          () => Column(
            children: [
              customTextField(
                  title: email,
                  hint: emailHint,
                  isPass: false,
                  controller: controller.emailController),
              customTextField(
                  title: password,
                  hint: passwordHint,
                  isPass: true,
                  controller: controller.passwordContoller),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: forgetPass.text.make())),
              5.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : ourButton(
                      onPress: () async {
                        controller.isLoading(true);
                        await controller
                            .loginMethod(context: context)
                            .then((value) {
                          if (value != null) {
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => const Home());
                          } else {
                            controller.isLoading(false);
                          }
                        });
                      },
                      color: redColor,
                      textColor: whiteColor,
                      title: login,
                    ).box.width(context.screenWidth - 50).make(),
              5.heightBox,
              createNewAccount.text.color(fontGrey).make(),
              5.heightBox,
              ourButton(
                onPress: () {
                  Get.to(() => const SignupScreen());
                },
                color: lightGolden,
                textColor: redColor,
                title: signup,
              ).box.width(context.screenWidth - 50).make(),
              10.heightBox,
              loginWith.text.color(fontGrey).make(),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        )),
              )
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
