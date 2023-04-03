import 'package:humble_warrior/hw.dart';

import '../../modals/response/brands_response_mdel.dart';
import '../../modals/response/home_categories_response_model.dart';

class BrandAPIWidgets extends FutureAPI<List<BrandDetails>> {
  final BuildContext context;
  final String searchText;

  BrandAPIWidgets({required this.context, required this.searchText});

  /// Grid Parameters
  final int crossAxisCount = 2;
  final double crossAxisSpacing = 8.0;
  final double mainAxisSpacing = 8.0;
  final double childAspectRatio = 1.5;

  /// Home Controller
  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    return CommonWidgets.errorAPI(
        buttonTitle: retryTxt,
        errorText: error.toString(),
        context: context,
        onPress: () => controller.update([Endpoints.allBrands]));
  }

  @override
  Widget success({List<BrandDetails>? data}) {
    List<BrandDetails> dataa = data != null
        ? data.where((element) {
            return element.brandName!
                .toLowerCase()
                .contains(searchText.toLowerCase().trim());
          }).toList()
        : [];
    if (dataa.isEmpty) {
      return const Center(
        child: AppText("No Brand Found"),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: dataa.length,
      itemBuilder: (ctx, index) {
        BrandDetails brandDetails = dataa[index];
        return GestureDetector(
          onTap: () async {
            await CommonUtils().urlLauncher(url: brandDetails.brandLink!);
          },
          child: Card(
            elevation: 8,
            margin: 8.pa,
            color: Colors.grey.shade200,
            child: CommonWidgets.networkImage(
              margin: 8.pa,
              alignment: Alignment.center,
              imageUrl: dataa[index].brandImage!,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget waiting() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 20,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: 8.pa,
          color: Colors.grey.shade200,
          child: const CustomShimmer.rectangular(borderRadius: 10),
        );
      },
    );
  }

  /// Home Options
  Widget homeOption(
      {required HomeCategoryList homeOptions, required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.homeOptions, arguments: <int>[homeOptions.id!]);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CommonWidgets.networkImage(
                imageUrl: homeOptions.categoryImage!,
                fit: BoxFit.fitWidth,
                height: 200,
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(20),
                  )),
              child: AppText(
                homeOptions.categoryName!.toUpperCase(),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
