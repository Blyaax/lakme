import 'package:flutter/services.dart';
import 'package:lakme/consts/consts.dart';
import 'package:lakme/widgets/button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are You Sure Want To Exit".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(() {
              SystemNavigator.pop();
            }, redColor, whiteColor, "Yes"),
            ourButton(() {
              Navigator.pop(context);
            }, redColor, whiteColor, "No")
          ],
        )
      ],
    ).box.color(lightGrey).roundedSM.make(),
  );
}
