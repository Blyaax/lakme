import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lakme/consts/consts.dart';
import 'package:lakme/consts/list.dart';
import 'package:lakme/controller/cart_controller.dart';
import 'package:lakme/views/home_screen/home_screen.dart';
import 'package:lakme/widgets/button.dart';

import '../home_screen/hoomiie.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).make(),
        ),
        bottomNavigationBar: SizedBox(
            height: 100,
            child: controller.placingOrder.value
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  )
                : ourButton(() async {


                    await controller.placeMyorder(
                      orderPaymentMethod:
                          paymentMethods[controller.paymentIndex.value],
                      totalAmount: controller.totalP.value,
                    );


                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");
                    Get.offAll(HomeScreen());
                  }, redColor, whiteColor, "Place My Order")),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodsImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                value: true,
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: "${paymentMethods[index]}"
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(14)
                              .make()),
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
