import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_ecommerce/constants/constants.dart';
import 'package:youtube_ecommerce/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want exit".text.size(18).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
            color: redColor,
            textColor: whiteColor,
            onPress: () {
              SystemNavigator.pop();
            },
            title: "Yes",
          ),
          ourButton(
            color: redColor,
            textColor: whiteColor,
            onPress: () {
              Navigator.pop(context);
            },
            title: "No",
          )
        ],
      ),
    ]).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
