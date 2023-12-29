import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lakme/consts/consts.dart';
import 'package:lakme/controller/profilecontroller.dart';
import 'package:lakme/widgets/bg_widget.dart';
import 'package:lakme/widgets/button.dart';
import 'package:lakme/widgets/custom_textFirld.dart';
import 'package:lakme/views/account_screen/account_screen.dart';

import '../../../consts/images.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;

  EditProfile({Key? key, this.data}) : super(key: key);

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
            data["imageUrl"] == "" && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : data["imageUrl"] != "" && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data["imageUrl"],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(() async {
              controller.changeImages(context);
            }, redColor, whiteColor, "Change"),
            20.heightBox,
            Divider(),
            20.heightBox,
            customTextField(name, nameHint, controller.nameController, false),
            10.heightBox,
            customTextField(
                oldpassword, passwordHint, controller.oldpassController, false),
            10.heightBox,
            customTextField(
                newpassword, passwordHint, controller.newpassController, false),
            20.heightBox,
            controller.isloading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(() async {
                      controller.isloading(true);

                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = data["imageUrl"];
                      }

                      //old password matches data base

                      if (data["password"] ==
                          controller.oldpassController.text) {

                        await controller.changeAuthPassword(
                          email: data["email"],
                          password: controller.oldpassController.text,
                          newpassword:controller.newpassController.text,
                        );

                        await controller.uploadProfileImage();
                        await controller.updateProfile(
                            controller.nameController.text,
                            controller.newpassController.text,
                            controller.profileImageLink);
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Wrong Old Message");
                        controller.isloading(false);
                      }
                    }, redColor, whiteColor, "Save"),
                  )
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 15, right: 15))
            .roundedSM
            .make(),
      ),
    ));
  }
}
