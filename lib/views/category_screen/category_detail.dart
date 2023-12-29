import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lakme/controller/product_controller.dart';
import 'package:lakme/services/firestore_services.dart';
import 'package:lakme/widgets/bg_widget.dart';
import 'package:lakme/consts/consts.dart';

import 'item_detail.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;

  const CategoryDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.white.fontFamily(bold).make(),
            ),
            body:



            StreamBuilder(
              stream: FirestorServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {


                  return Center(
                    child: "No Product Found!".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;



                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  controller.subcat.length,
                                  (index) => "${controller.subcat[index]}"
                                      .text
                                      .size(12)
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .makeCentered()
                                      .box
                                      .rounded
                                      .white
                                      .size(150, 60)
                                      .margin(
                                          EdgeInsets.symmetric(horizontal: 4))
                                      .make())),
                        ),


                        20.heightBox,


                        Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              print(data[index]["p_imgs"][0]);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ...

                                  Image.network(
                                    data[index]["p_imgs"][0],
                                    height: 160,
                                    width: 190,
                                    fit: BoxFit.cover,
                                  ),

                                  "${data[index]["p_name"]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]["p_price"]}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .shadowSm
                                  .padding(EdgeInsets.all(12))
                                  .margin(EdgeInsets.all(4))
                                  .make()
                                  .onTap(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ItemDetail(
                                    title: "${data[index]["p_name"]}",
                                    data: data[index],
                                  ),
                                ));
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            )));
  }
}

