import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_ecommerce/constants/my_images.dart';

Widget applogoWidget() {
  return Image.asset(icAppLogo)
  // using velocity_x here
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
