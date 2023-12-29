import 'package:get/get.dart';
import 'package:lakme/consts/consts.dart';
import 'package:lakme/controller/cart_controller.dart';
import 'package:lakme/views/cart_screen/payment_screen.dart';
import 'package:lakme/widgets/button.dart';
import 'package:lakme/widgets/custom_textFirld.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(() {
          if (controller.addressController.text.length > 10) {
            Get.to(() => PaymentMethod());
          } else {
            VxToast.show(context, msg: "Please Fill The Form");
          }
        }, redColor, whiteColor, "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField(
                "Address", "Address", controller.addressController, false),
            customTextField("City", "City", controller.cityController, false),
            customTextField(
                "State", "State", controller.stateController, false),
            customTextField("Postal Code", "Postal Code",
                controller.postalController, false),
            customTextField("Phone Number", "Phone Number",
                controller.phoneController, false),
          ],
        ),
      ),
    );
  }
}
