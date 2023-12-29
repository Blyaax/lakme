
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lakme/controller/product_controller.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets/bg_widget.dart';
import 'category_detail.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {




    var controller=Get.put(ProductController());


    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.white.fontFamily(bold).make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categorieImage[index],
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                10.heightBox,
                categorieList[index]
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make()
              ],
            )
                .box
                .white
                .outerShadowSm
                .rounded
                .clip(Clip.antiAlias)
                .make()
                .onTap(() {

                  controller.getSubCategories(categorieList[index]);

              Get.to(() => CategoryDetail(title: categorieList[index]));
            });
          },
        ),
      ),
    ));
  }
}
