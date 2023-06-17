import 'package:flutter/material.dart';
import 'package:youtube_ecommerce/constants/constants.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
