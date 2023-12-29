import 'package:get/get.dart';
import 'package:lakme/controller/product_controller.dart';
import 'package:lakme/views/chatScreen/chat_screen.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets/button.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetail({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    print(Colors.yellow.value);
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removewishlist(data.id, context);
                    } else {
                      controller.addToWish(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        viewportFraction: 1.0,
                        itemCount: data["p_imgs"].length,
                        aspectRatio: 16 / 9,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              data["p_imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      10.heightBox,
                      title!.text
                          .size(16)
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data["p_rating"]),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data["p_price"]}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .size(18)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data["p_seller"]}"
                                  .text
                                  .size(16)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            ],
                          )),
                          CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .color(textfieldGrey)
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .make(),
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Color:".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                    children: List.generate(
                                        data["p_colors"].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .roundedFull
                                                    .color(Color(
                                                            data["p_colors"]
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .margin(
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4))
                                                    .make()
                                                    .onTap(() {
                                                  controller
                                                      .changeColorIndex(index);
                                                }),
                                                Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorIndex.value,
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            )))
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity:"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data["p_price"]));
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data["p_quantity"]));
                                          controller.calculateTotalPrice(
                                              int.parse(data["p_price"]));
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                      10.widthBox,
                                      "${data["p_quantity"]} Available"
                                          .text
                                          .size(14)
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).box.white.shadowSm.padding(EdgeInsets.all(12)).make(),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Total:".text.color(textfieldGrey).make(),
                            ),
                            "${controller.totalPrice.value}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .make()
                          ],
                        ).box.white.shadowSm.padding(EdgeInsets.all(12)).make(),
                      ),
                      20.heightBox,
                      "Description"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "${data["p_desc"]}".text.color(darkFontGrey).make(),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailButtonList.length,
                            (index) => ListTile(
                                  title: "${itemDetailButtonList[index]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: Icon(Icons.arrow_forward_outlined),
                                )),
                      ),
                      20.heightBox,
                      productyoumaylike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "Lap Tops 4Gb/64GB"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "\$600"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .margin(EdgeInsets.all(4))
                                        .rounded
                                        .padding(EdgeInsets.all(8))
                                        .make())),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(() {
                if (controller.quantity.value > 0) {
                  controller.addToCart(
                    data["p_name"],
                    data["p_imgs"][0],
                    data["p_seller"],
                    data["p_colors"][controller.colorIndex.value],
                    controller.quantity.value,
                    controller.totalPrice.value,
                    context,
                    data["vendor_id"],
                  );
                  VxToast.show(context, msg: "Added To Cart");
                } else {
                  VxToast.show(context, msg: "Minimum 1 product is required");
                }
              }, redColor, whiteColor, "Add To Cart"),
            )
          ],
        ),
      ),
    );
  }
}
