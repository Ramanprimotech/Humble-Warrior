import 'package:humble_warrior/hw.dart';

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
    return ListView(
      children: [
        const AffiliateDiscretionText(),
        8.shb,
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataa.length,
          itemBuilder: (ctx, index) {
            BrandDetails brandDetails = dataa[index];
            return GestureDetector(
              onTap: () async {
                await CommonUtils().urlLauncher(url: brandDetails.brandLink!);
              },
              child: Card(elevation: 8,
                margin: 8.pa,
                color: Colors.white,
                child: CommonWidgets.networkImage(
                  margin: 8.pa,
                  alignment: Alignment.center,
                  imageUrl: dataa[index].brandImage!,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget waiting() {
    return ListView(
      children: [
        const AffiliateDiscretionText(),
        8.shb,
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return const CustomShimmer.rectangular(borderRadius: 10);
          },
        ),
      ],
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

class AffiliateDiscretionText extends StatelessWidget {
  const AffiliateDiscretionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "* This app shares deals using affiliate codes and may earn commissions for purchases made through the provided links.",
      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
      maxLines: 2,
    );
  }
}
