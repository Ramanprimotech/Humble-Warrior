import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/productDetail/category_details_list/category_details_list_controller.dart';

class CategoryListDetails extends StatelessWidget {
  final ProductCategoryItem? item;
  const CategoryListDetails({required this.item,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FToast().init(context);
    final CategoryDetailsListController controller = Get.find();

    controller.context = context;
    controller.id = item!.id.toString();
    controller.categoryListApi();
    return Scaffold(
      // bottomNavigationBar: bottomNavigationWidget(context),
      appBar: AppBar(
        titleSpacing: 5,
        leadingWidth: 34,
        leading: AppIcons.IosBackIcon(),
        title:  SearchBar(route: 3,
          margin: EdgeInsets.only(right: 4),
          ///Uncomment for preselected category
          // item: item,
        ),
        actions: [
          FilterIcon(route : 3, item: item),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                          child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return const CustomShimmer.rectangular(
                            height: 290,
                            borderRadius: 15,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                          );
                        },
                        itemCount: 10,
                        separatorBuilder: (BuildContext context, int index) {
                          return 18.shb;
                        },
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
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 4),
                      controller: controller.categoryListScrollController,
                      itemCount: controller.categoryList.length + 1,
                      itemBuilder: (ctx, index) {
                        ProductDetailsResponse details =
                            ProductDetailsResponse();
                        if (index != controller.categoryList.length) {
                          details = controller.categoryList[index];
                        }
                        return index != controller.categoryList.length
                            ? CardView(
                                index: index,
                                imgUrl: details.url,
                                cardText: details.itemName,
                                details: details,
                                onTap: () {
                                  Get.toNamed(AppRoutes.categoryItemDetail,id: 3,
                                      arguments: { "details" :   ProductDetailsResponse(
                                          id: details.id)});
                                },
                              )

                            // categoryListCard(details, index, context,
                            //         categoryCard: true)
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
                          height: 18,
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

  Widget loginFirst(context) {
    return CommonWidgets.errorAPI(
        height: 150,
        buttonTitle: gotoLoginTxt,
        errorText: accessingMsgTxt,
        context: context,
        onPress: () {
          Get.offAllNamed(AppRoutes.loginPage);
        });
  }
}
