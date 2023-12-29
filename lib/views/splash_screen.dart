import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lakme/views/home_screen/home_screen.dart';

import '../consts/consts.dart';
import '../widgets/applogo_widget.dart';
import 'auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ChangeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(() => LoginScreen());
      // auth.authStateChanges().listen((User? user) {
      //   if(user==null && mounted){
      //     Get.to(()=>LoginScreen());
      // }else{
      //     Get.to(()=>HomeScreen());
      //   }
      //   );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ChangeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: credits.text.white.fontFamily(semibold).make(),
            ),
          ],
        ),
      ),
    );
  }
}
