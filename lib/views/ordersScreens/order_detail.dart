import 'package:flutter/material.dart';
import 'package:lakme/consts/consts.dart';
import 'package:lakme/views/ordersScreens/components/order_place_detail.dart';
import 'package:lakme/views/ordersScreens/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetail extends StatelessWidget {
  final dynamic data;

  OrderDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Order Detail",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      body: Column(
        children: [
          orderStatus(
              color: redColor,
              icon: Icons.done,
              showDone: data["order_placed"],
              title: "Order Placed"),
          orderStatus(
              color: Vx.blue400,
              icon: Icons.thumb_up,
              showDone: data["order_confirmed"],
              title: "Confirmed"),
          orderStatus(
              color: Colors.yellow.shade800,
              icon: Icons.delivery_dining,
              showDone: data["order_on_delivery"],
              title: "On Delivered"),
          orderStatus(
              color: Colors.green.shade800,
              icon: Icons.done_all_outlined,
              showDone: data["order_delivered"],
              title: "Delivered"),
          Divider(),
          10.heightBox,
          orderPlacedDetails("Order Code", "Shipping Method",
              data["order_code"], data["shipping_method"]),
          orderPlacedDetails(
              "Order Date",
              "Payment Method",
              intl.DateFormat().add_yMd().format((data["order_date"].toDate())),
              data["payment_method"]),
          orderPlacedDetails(
              "Payment Status", "Delivery Status", "Unpaid", "Order Placed"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Shipping Address".text.fontFamily(semibold).make(),
                    "${data['order_by_name']}".text.make(),
                    "${data['order_by_email']}".text.make(),
                    "${data['order_by_address']}".text.make(),
                    "${data['order_by_city']}".text.make(),
                    "${data['order_by_state']}".text.make(),
                    "${data['order_by_phone']}".text.make(),
                    "${data['order_by_postalcode']}".text.make()
                  ],
                ),
                SizedBox(
                  width: 90,
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Total Amount".text.make(),
                      "${data['total_amount']}".text.color(redColor).make(),
                    ],
                  ),
                )
              ],
            ),
          ).box.outerShadowMd.white.make(),
          Divider(),
          10.heightBox,
          "Ordered Box"
              .text
              .fontFamily(semibold)
              .size(16)
              .color(darkFontGrey)
              .make(),
          10.heightBox,
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(data['orders'].length, (index) {
              return orderPlacedDetails(
                data['orders'][index]['title'],
                data['orders'][index]['tprice'] ,
                "${data['orders'][index]['qty']}",
                "Refundable",
              );
            }).toList(),
          )
              .box
              .roundedSM
              .shadowMd
              .white
              .margin(EdgeInsets.only(bottom: 4))
              .make(),
          10.heightBox,

        ],
      ),
    );
  }
}
