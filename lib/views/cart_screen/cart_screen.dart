import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lakme/controller/cart_controller.dart';
import 'package:lakme/services/firestore_services.dart';
import 'package:lakme/views/cart_screen/shipping_screen.dart';
import 'package:lakme/widgets/button.dart';

import '../../consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ourButton(() {
              Get.to(() => ShippingDetails());
            }, redColor, whiteColor, "Procced To Shipping")),
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart".text.fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
          stream: FirestorServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is Empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]["img"]}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title:
                                "${data[index]["title"]} (x${data[index]["qty"]})"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                            subtitle: "${data[index]["tprice"]}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                            trailing: IconButton(
                              onPressed: () {
                                FirestorServices.deletaDocument(data[index].id);
                              },
                              icon: Icon(Icons.delete),
                              color: redColor,
                            ),
                          );
                        },
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price : "
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        20.widthBox,
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .width(
                          context.screenWidth - 60,
                        )
                        .padding(EdgeInsets.all(12))
                        .color(lightgolden)
                        .roundedSM
                        .make(),
                    10.heightBox,
                  ],
                ),
              );
            }
          },
        ));
  }
}
