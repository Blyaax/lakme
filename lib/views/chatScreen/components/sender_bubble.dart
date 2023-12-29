import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lakme/consts/consts.dart';

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data["created_on"] == null ? DateTime.now() : data["created_on"].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: "${data["msg"]}".text.white.size(16).make(),
          ),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: time.text.color(whiteColor.withOpacity(0.5)).make(),
          )
        ],
      ),
    ),
  );
}
