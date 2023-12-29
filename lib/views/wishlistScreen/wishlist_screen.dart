import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lakme/consts/consts.dart';
import 'package:lakme/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders Yet.......!"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(
                    "${data[index]["p_imgs"][0]}",
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: "${data[index]["p_name"]}"
                      .text
                      .fontFamily(semibold)
                      .make(),
                  subtitle: "${data[index]["p_price"]}"
                      .numCurrency
                      .text
                      .fontFamily(semibold)
                      .color(redColor)
                      .make(),
                  trailing: IconButton(
                    onPressed: () async {
                      await firestore
                          .collection(productsCollection)
                          .doc(data[index].id)
                          .set({
                        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                      }, SetOptions(merge: true));
                    },
                    icon: Icon(Icons.favorite),
                    color: redColor,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
