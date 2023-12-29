import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lakme/services/firestore_services.dart';
import 'package:lakme/views/account_screen/account_screen.dart';
import 'package:lakme/views/category_screen/item_detail.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../controller/product_controller.dart';
import '../../widgets/home_buttons.dart';
import 'components/featured_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(children: [
          Container(
            alignment: Alignment.center,
            color: lightGrey,
            height: 60,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  fillColor: whiteColor,
                  filled: true,
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: textfieldGrey,
                  )),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    height: 150,
                    itemCount: slidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        slidersList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                          2,
                          (index) => homeButtons(
                              context.screenWidth / 2.5,
                              context.screenHeight * 0.15,
                              index == 0 ? icTodaysDeal : icFlashDeal,
                              index == 0 ? todaydeal : flashsale,
                              () {})),
                    ],
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    height: 150,
                    itemCount: secondSlidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(secondSlidersList[index],
                              fit: BoxFit.fill)
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                          3,
                          (index) => homeButtons(
                              context.screenWidth / 3.5,
                              context.screenHeight * 0.15,
                              index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              index == 0
                                  ? topcategories
                                  : index == 1
                                      ? brands
                                      : topsellers,
                              () {})),
                    ],
                  ),
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredcategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  // SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: FutureBuilder(
                  //       future: FirestorServices.allproducts(),
                  //       builder: (BuildContext context,
                  //           AsyncSnapshot<QuerySnapshot> featuredsnapshot) {
                  //         if(!featuredsnapshot.hasData){
                  //           return Center(
                  //             child: CircularProgressIndicator(
                  //               valueColor: AlwaysStoppedAnimation(
                  //                 redColor
                  //               ),
                  //             ),
                  //           );
                  //         }else{
                  //           var featuredList=Get.find().fetchFeatured(featuredsnapshot.data!.docs);
                  //           print(featuredList);
                  //         }
                  //       },
                  //     )
                  // ),
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredproduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
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
                  VxSwiper.builder(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    height: 150,
                    itemCount: slidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        slidersList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    },
                  ),
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: allproducts.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  StreamBuilder(
                    stream: FirestorServices.allproducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        );
                      } else {
                        var allproductdata = snapshot.data!.docs;
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allproductdata.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  allproductdata[index]["p_imgs"][0],
                                  height: 200,
                                  width: 190,
                                  fit: BoxFit.cover,
                                ),
                                Spacer(),
                                "${allproductdata[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${allproductdata[index]["p_price"]}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .margin(EdgeInsets.all(12))
                                .rounded
                                .padding(EdgeInsets.all(8))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetail(
                                  title: "${allproductdata[index]["p_name"]}",
                                  data: allproductdata[index]));
                            });
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }
}
