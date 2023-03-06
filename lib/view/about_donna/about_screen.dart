import 'package:humble_warrior/hw.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    return Scaffold(
      appBar: CommonAppBar().AppBarWidget(
        showBackButton: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              /// About Donna title
              CommonWidgets.titleBar(context,
                  backIcon: false,
                  title: aboutDonnaTxt,
                  fontSize: 18,
                  color: AppColors.primary),

              /// About image
              _showImg(),

              /// About Details
              _details(context),

              /// See copy of humble warrior button
              _seeCopyButton(),
              25.shb,
            ]),

            /// Brands List
            HomeScreenWidgets(context: context, controller: controller)
                .brandsList(),
            25.shb,
          ],
        ),
      ),
    );
  }

  /// About Donna image
  _showImg() {
    return Padding(
      padding: 20.ph,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CommonWidgets.networkImage(
          imageUrl:
              "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg",
          fit: BoxFit.fitWidth,
          height: 200,
          alignment: Alignment.topCenter,
          width: Get.width,
        ),
      ),
    );
  }

  /// About Details
  _details(context) {
    return Container(
      padding: 10.pa,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: Get.width,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const AppText(helloGorgeousTxt, fontWeight: FontWeight.bold),
        ReadMoreText(
          style: Theme.of(context).textTheme.bodyMedium,
          AppStrings.lorem,
          trimLines: 10,
          trimMode: TrimMode.Line,
          trimCollapsedText: readMoreTxt,
          trimExpandedText: readLessTxt,
          lessStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          moreStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ]),
    );
  }

  /// See copy of humble warrior button
  _seeCopyButton() {
    return Container(
      margin: 20.ph,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 1,
              // offset: const Offset(0, 3),
            )
          ]),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          const TextSpan(
            text: seeCopyHumbleTxt,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          WidgetSpan(child: 10.swb),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await CommonUtils().urlLauncher(
                      url:
                          "https://humblewarrior.com/wp-content/uploads/2020/09/humble-warrior-media.pdf",
                      title: "The Humble Warrior");
                },
              text: hereTxt,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 16))
        ]),
      ),
    );
  }
}
