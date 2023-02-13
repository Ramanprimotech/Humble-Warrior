import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';
import 'package:humble_warrior/view/brands/brands_controller.dart';

import '../../utils/search_bar/search_bar_ui.dart';

class BrandsScreen extends StatelessWidget {
    const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrandsController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchBar(textEditingController: TextEditingController(), focusNode: FocusNode(),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Expanded(
            child: Container(
              color: Theme.of(context)
                  .floatingActionButtonTheme
                  .backgroundColor,
              height: Get.height,
              width: Get.height,
              child: FutureBuilder<List<BrandDetails>>(
                  future: controller.allBrands(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.vertical,
                        itemCount: 25,
                        itemBuilder: (ctx, index) {
                          return Container(
                            color: Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor,
                            // height: 60,
                            // width: 80,
                            child: Column(
                              children: const [
                                ShimmerLoader(
                                    child: AppText(
                                      "HW",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 35,
                                    )),
                              ],
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return 20.sw;
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return AppText("Something Went Wrong");
                    }
                    List<BrandDetails> data = snapshot.data ?? [];
                    return ListView.separated(
                      // physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            CommonUtils().urlLauncher(
                                url: data[index].brandLink!);
                          },
                          child: SizedBox(
                            // height: 60,
                            // width: 80,
                            child: Column(
                              children: [
                                CommonWidgets.networkImage(
                                  alignment: Alignment.center,
                                  imageUrl: data[index].brandImage!,
                                  fit: BoxFit.contain,
                                  height: 80,
                                  width: Get.width,
                                ),
                                5.sh,
                                AppText(data[index].brandName!, fontSize: 22),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return 50.sh;
                      },
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
