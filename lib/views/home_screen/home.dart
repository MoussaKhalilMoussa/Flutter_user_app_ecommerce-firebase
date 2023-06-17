import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:youtube_ecommerce/constants/constants.dart';
import 'package:youtube_ecommerce/controllers/home_controller.dart';
import 'package:youtube_ecommerce/views/cart_Screen/cart_screen.dart';
import 'package:youtube_ecommerce/views/category_screen/category_screen.dart';
import 'package:youtube_ecommerce/views/home_screen/home_screen.dart';
import 'package:youtube_ecommerce/views/profile_screen/profile_screen.dart';
import 'package:youtube_ecommerce/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    return WillPopScope(
      
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: redColor,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              backgroundColor: whiteColor,
              items: navBarItems,
              onTap: (value) {
                controller.currentNavIndex.value = value;
              }),
        ),
      ),
    );
  }
}
