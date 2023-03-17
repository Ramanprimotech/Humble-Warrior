import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_controller.dart';

class CategoryListDetails extends StatelessWidget {
  const CategoryListDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FToast().init(context);
    final CategoryDetailsListController controller = Get.find();
    String title = Get.arguments[0];
    controller.context = context;
    controller.id = Get.arguments[1];
    controller.categoryListApi();
    return Scaffold(
      bottomNavigationBar: bottomNavigationWidget(context),
      // appBar: AppBar(
      //   titleSpacing: 5,
      //   leadingWidth: 35,
      //   centerTitle: false,
      //   title: SearchBar(
      //     margin: 15.pr,
      //   ),
      //   leading: AppIcons.IosBackIcon(),
      // ),
      appBar: AppBar(
        titleSpacing: 5,
        leadingWidth: 34,
        leading: AppIcons.IosBackIcon(),
        title: const SearchBar(margin: EdgeInsets.only(right: 15)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // CommonWidgets.titleBar(context,
            //     title: title, fontSize: 20, backIcon: true),
            12.shb,
            Expanded(
              child: PaginationWidget(
                length: controller.categoryListLength,
                apiBool: controller.categoryListBool,
                api: controller.categoryListApi,
                update: controller.update,
                scrollController: controller.categoryListScrollController,
                totalRecords: controller.categoryListTotalDeals,
                child: GetBuilder<CategoryDetailsListController>(
                  init: controller,
                  builder: (ctx) {
                    if (controller.categoryList.isEmpty &&
                        controller.categoryListBool.value == true) {
                      return Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          CommonWidgets.loading(),
                        ],
                      ));
                    }
                    if (controller.categoryList.isEmpty &&
                        controller.categoryListBool.value == false) {
                      return CommonWidgets.noData(
                          update: controller.update,
                          context: context,
                          onTap: () {
                            controller.categoryListBool.value = true;
                            controller.update();
                            controller.categoryListApi();
                          });
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      controller: controller.categoryListScrollController,
                      itemCount: controller.categoryList.length + 1,
                      itemBuilder: (ctx, index) {
                        ProductDetailsResponse details =
                            ProductDetailsResponse();
                        if (index != controller.categoryList.length) {
                          details = controller.categoryList[index];
                        }
                        return index != controller.categoryList.length
                            ? categoryListCard(details, index, context,
                                categoryCard: true)
                            : Obx(
                                () => Visibility(
                                    visible: controller.categoryListBool.value,
                                    child: Container(
                                        height: 80,
                                        alignment: Alignment.center,
                                        child:
                                            const CircularProgressIndicator())),
                              );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 25,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*  ItemCard categoryListCard(
      DonnaDealsDetails details, int index, BuildContext context) {
    return ItemCard(
      onTap: () {
        Get.toNamed(AppRoutes.dailyDealProductDetail, arguments: [details]);
      },
      radius: 10,
      buttons: donnaDealsButton(details, index, context,categoryCard: true,
          cardTitle: details.dealName!),
      imageUrl: details.url!,
      title: "",
      effect: false,
      buttonbarHeight: 90,
    );
  }*/

  Widget loginFirst(context) {
    return CommonWidgets.errorAPI(
        height: 150,
        buttonTitle: gotoLoginTxt,
        errorText: accessingMsgTxt,
        context: context,
        onPress: () {
          Get.offAllNamed(AppRoutes.loginPage);
        });
    /*Container(
      height: 150,
      margin: 20.pa,
      padding: 20.ps,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Column(children: [
        AppText(accessingMsgTxt,
            color: dialogueThemeExtention.textColor, fontSize: 20),
        20.sh,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            // fixedSize: const Size(, 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: dialogueThemeExtention.buttonColor,
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.loginPage);
          },
          child: const AppText(gotoLoginTxt,
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ]),
    );*/
  }
}
