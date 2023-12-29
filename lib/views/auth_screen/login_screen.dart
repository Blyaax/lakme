import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lakme/controller/auth_controller.dart';
import 'package:lakme/views/auth_screen/sign_up.dart';
import 'package:lakme/views/home_screen/home_screen.dart';
import 'package:lakme/views/home_screen/hoomiie.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';

import '../../widgets/applogo_widget.dart';
import '../../widgets/bg_widget.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_textFirld.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(22).make(),
              10.heightBox,
              Obx(
                  ()=> Column(
                  children: [
                    customTextField(
                        email, emailHint, controller.emailController, false),
                    15.heightBox,
                    customTextField(password, passwordHint,
                        controller.passwordController, false),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetpass.text.make()),
                    ),
                    5.heightBox,
                    controller.isloading.value ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        redColor
                      ),
                    ):ourButton(
                      () async {
                        controller.isloading(true);
                        await controller
                            .loginMethod(context: context)
                            .then((value) {
                          if (value != null) {
                            VxToast.show(context, msg: "Logged In");
                            // Get.offAll(() => HomeScreen());
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                          }else{
                            controller.isloading(false);
                          }
                        });
                      },
                      redColor,
                      whiteColor,
                      login,
                    ).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(() {
                      Get.to(() => SignUpScreen());
                    }, lightgolden, redColor, signup)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    15.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: socialIconList
                          .map((iconPath) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: Image.asset(iconPath, width: 30),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .shadowSm
                    .padding(EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .make(),
              ),
            ],
          ),
        ),

        // Your Scaffold content goes here
      ),
    );
  }
}
