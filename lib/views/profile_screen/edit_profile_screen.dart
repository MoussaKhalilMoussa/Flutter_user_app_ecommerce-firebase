import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_ecommerce/constants/constants.dart';
import 'package:youtube_ecommerce/controllers/profile_controller.dart';
import 'package:youtube_ecommerce/widgets_common/bgWidget.dart';
import 'package:youtube_ecommerce/widgets_common/custom_textfield.dart';
import 'package:youtube_ecommerce/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if data image url and controller path is empty
            data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()

                // if data is not empty but controller path is empty
                : data['imageUrl'] != '' && controller.profileImagePath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

                    // else if controller path is not empty but data image url is
                    : Image.file(
                        File(controller.profileImagePath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            const Divider(),
            20.heightBox,
            customTextField(
                hint: nameHint,
                title: name,
                controller: controller.nameController,
                isPass: false),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: oldpass,
                controller: controller.oldpassController,
                isPass: true),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: newpass,
                controller: controller.newpassController,
                isPass: true),
            20.heightBox,
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);

                          // if image is not selected
                          if (controller.profileImagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          // if old password matches data base

                          if (data['password'] ==
                              controller.oldpassController.text) {
                            controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text);

                            await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "Wrong old password");
                            controller.isLoading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save"))
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
