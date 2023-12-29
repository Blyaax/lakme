import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lakme/views/home_screen/home_screen.dart';

import '../../consts/consts.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/applogo_widget.dart';
import '../../widgets/bg_widget.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_textFirld.dart';
import '../home_screen/hoomiie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

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
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join to $appname".text.fontFamily(bold).white.size(22).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(name, nameHint, nameController, false),
                    15.heightBox,
                    customTextField(email, emailHint, emailController, false),
                    15.heightBox,
                    customTextField(
                        password, passwordHint, passwordController, true),
                    15.heightBox,
                    customTextField(confirmpassword, passwordHint,
                        passwordRetypeController, true),
                    15.heightBox,
                    5.heightBox,
                    Row(
                      children: [
                        Checkbox(
                          checkColor: redColor,
                          value: isCheck,
                          onChanged: (value) {
                            setState(() {
                              isCheck = value;
                            });
                          },
                        ),
                        5.widthBox,
                        Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                                text: terms,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                )),
                            TextSpan(
                              text: "&",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                                text: privacypolicy,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                )),
                          ])),
                        ),
                      ],
                    ),
                    controller.isloading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            () async {
                              if (isCheck != false) {
                                controller.isloading(true);
                                try {
                                  await controller
                                      .signupMethod(emailController.text,
                                          passwordController.text, context)
                                      .then((value) {
                                    return controller.storeUserData(
                                        nameController.text,
                                        passwordController.text,
                                        emailController.text);
                                  }).then((value) {
                                    VxToast.show(context,
                                        msg: "Logged In Successfully");
                                    Get.offAll(() => HomeScreen());
                                  });
                                } catch (e) {
                                  VxToast.show(context, msg: e.toString());
                                  auth.signOut();
                                  controller.isloading(false);
                                }
                              }
                            },
                            isCheck == true ? redColor : lightGrey,
                            whiteColor,
                            signup,
                          ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: already,
                          style: TextStyle(fontFamily: bold, color: fontGrey)),
                      TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: redColor))
                    ])).onTap(() {
                      Get.back();
                    })
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
