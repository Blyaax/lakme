import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lakme/controller/home_controller.dart';

import '../consts/firebase_const.dart';

class ChatController extends GetxController {

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var isloading=false.obs;
  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;

  getChatId() async {
    isloading(true);
    await chats
        .where("users", isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              "created_on": null,
              "last_message": "",
              "users": {friendId: null, currentId: null},
              "toId": "",
              "fromId": "",
              "friendname": friendName,
              "sendername": senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isloading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
