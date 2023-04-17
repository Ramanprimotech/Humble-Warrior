import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_card_selector.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
        actions: const [FilterIcon()],
      ),
      body: SafeArea(
        child: Column(
          children: [
            12.shb,
            Expanded(
              child: Obx(
                () => Center(
                    child: controller.loggedIn.value == false
                        ? loginFirst(context)
                        : CustomRefreshIndicator(
                            onRefresh: () async {
                              return Future.delayed(const Duration(seconds: 1),
                                  () {
                                controller.getWishList();
                                return Future.value(0);
                              });
                            },
                            child: Obx(
                              () => controller.data.value.isEmpty
                                  ? const Center(
                                      child: AppText(
                                        "Your wishlist is empty",
                                        fontSize: 20,
                                      ),
                                    )
                                  : ListView.separated(
                                      padding: 20.pb,
                                      itemCount: controller.data.value.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ProductDetailsResponse details =
                                            controller.data.value.reversed
                                                .toList()[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                          ),
                                          child: WishListCardSelector(
                                            details: details,
                                            index: index,
                                            context: context,
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 18,
                                        );
                                      },
                                    ),
                            ))),
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
