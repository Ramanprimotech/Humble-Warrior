import 'package:humble_warrior/hw.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context,
                title: notificationsTxt, fontSize: 20),
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 2), () {
                    return Future.value(0);
                  });
                },
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 5),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return notificationCard(context);
                  },
                  itemCount: 15,
                  separatorBuilder: (BuildContext context, int index) {
                    return 20.shb;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  notificationCard(context) {
    return Container(
      width: Get.width,
      height: 150,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        notificationImg(),
        notificationDetails(),
      ]),
    );
  }

  notificationImg() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: CommonWidgets.networkImage(
        imageUrl:
            "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg",
        alignment: Alignment.topCenter,
        width: Get.width / 3.5,
        fit: BoxFit.cover,
      ),
    );
  }

  notificationDetails() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                )),
            child: AppText(
              donnaFavouriteDealTxt.toUpperCase(),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: AppText(
              "Style And Savings " * 3,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 5),
            child: AppText(
              "These cuties were tough to photograph and honestly my picture doesn't to do justice." *
                  2,
              fontSize: 14,
              maxLines: 2,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8)),
                  child: const AppText(
                    "Yesterday",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
