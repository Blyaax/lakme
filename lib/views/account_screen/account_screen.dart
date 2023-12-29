import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lakme/controller/auth_controller.dart';
import 'package:lakme/controller/profilecontroller.dart';
import 'package:lakme/services/firestore_services.dart';
import 'package:lakme/views/MessageScreen/message_screen.dart';
import 'package:lakme/views/account_screen/components/editScreen.dart';
import 'package:lakme/views/auth_screen/login_screen.dart';
import 'package:lakme/views/ordersScreens/orderScreen.dart';
import 'package:lakme/views/wishlistScreen/wishlist_screen.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets/bg_widget.dart';
import 'components/deatils_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    FirestorServices.getCounts();
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestorServices.getuser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                    ).onTap(() {
                      controller.nameController.text = data["name"];

                      Get.to(() => EditProfile(
                            data: data,
                          ));
                    }),
                  ),
                  Row(
                    children: [
                      data["imageUrl"] == ""
                          ? Image.asset(
                              imgProfile2,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data["imageUrl"],
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          " ${data["name"]}"
                              .text
                              .overflow(TextOverflow.ellipsis)
                              .fontFamily(semibold)
                              .white
                              .make(),
                          "${data["email"]}".text.white.make(),
                        ],
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            color: whiteColor,
                          )),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => LoginScreen());
                          },
                          child: logout.text.white.fontFamily(bold).make()),
                    ],
                  ),
                  20.heightBox,
                  FutureBuilder(
                    future: FirestorServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ),
                        );
                      } else {
                        var countData = snapshot.data;
                        print(snapshot.data);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailcard(context.screenWidth / 3.4,
                                "in your cart", countData[0].toString()),
                            detailcard(context.screenWidth / 3.4,
                                "in your wishlist", countData[1].toString()),
                            detailcard(context.screenWidth / 3.4, "yours order",
                                countData[2].toString()),
                          ],
                        );
                      }
                    },
                  ),
                  40.heightBox,
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => OrderScreen());
                              break;
                            case 1:
                              Get.to(() => WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => MessageScreen());
                              break;
                          }
                        },
                        leading: Image.asset(
                          profileButtonsIcons[index],
                          width: 22,
                        ),
                        title: profileButtonList[index].text.make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .padding(EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                ],
              ),
            ),
          );
        }
      },
    )));
  }
}
