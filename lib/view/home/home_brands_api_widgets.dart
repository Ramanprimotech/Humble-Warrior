import 'package:humble_warrior/hw.dart';

import '../../modals/response/brands_response_mdel.dart';

class HomePageBrandAPIWidgets extends FutureAPI<List<BrandDetails>> {
  final BuildContext context;

  HomePageBrandAPIWidgets({required this.context});

  /// Brands Item Params
  final double width = 80;
  final double height = 60;
  final EdgeInsets padding = 5.pa;
  final EdgeInsets margin = 3.pa;

  /// Brands List Params
  final double separatorHeight = 10;
  final EdgeInsets listPadding =
      const EdgeInsets.only(left: 20, right: 20, bottom: 5);

  /// Home Screen Controller
  final HomeScreenController controller = Get.find();

  @override
  Widget error({Object? error}) {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          // fixedSize: const Size(, 35),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: dialogueThemeExtention.buttonColor,
        ),
        onPressed: () {
          controller.update([Endpoints.allBrands]);
        },
        child: const AppText('Retry',
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget success({List<BrandDetails>? data}) {
    List<BrandDetails> record = data ?? [];
    return ListView.separated(
      padding: listPadding,
      scrollDirection: Axis.horizontal,
      controller: controller.brandScrollController,
      itemCount: record.length,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            CommonUtils().urlLauncher(url: record[index].brandLink!);
          },
          child: Container(
            width: width,
            height: height,
            padding: padding,
            margin: margin,
            decoration: CustomBoxDecorations()
                .shadow(context: context, color: Colors.grey.shade200),
            child: CommonWidgets.networkImage(
              alignment: Alignment.center,
              imageUrl: record[index].brandImage!,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return separatorHeight.swb;
      },
    );
  }

  @override
  Widget waiting() {
    return ListView.separated(
      padding: listPadding,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return CustomShimmer.rectangular(width: width, height: height);
      },
      separatorBuilder: (BuildContext context, int index) {
        return separatorHeight.swb;
      },
    );
  }
}
