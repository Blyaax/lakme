

import '../../../consts/consts.dart';

Widget detailcard(width, String? title, String? count) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .roundedSM
      .width(width)
      .height(80)
      .padding(EdgeInsets.all(4))
      .make();
}
