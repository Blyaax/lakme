import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lakme/widgets/exit_dialog.dart';

import '../../consts/consts.dart';
import '../../controller/home_controller.dart';
import '../account_screen/account_screen.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category.dart';
import 'hoomiie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItem = [
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
          label: account)
    ];

    var navBody = [
      Home(),
      CategoryScreen(),
      CartScreen(),
      AccountScreen(),
    ];

    return
      Scaffold(
        body: Obx(
          () => Expanded(
            child: navBody.elementAt(controller.currentNavIndex.value),
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            currentIndex: controller.currentNavIndex.value,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      );

  }
}


// WillPopScope(
// onWillPop: () async {
// showDialog(
// barrierDismissible: false,
// context: context,
// builder: (context) => exitDialog(context),
// );
// return false;
// },
// child: