import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/notification_response_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _notificationController = Get.find();
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
                  setState(() {});
                  return Future.value(0);
                },
                child: FutureBuilder<NotificationResponseModel>(
                  future: _notificationController.notificationList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ShimmerLoader(
                              child: notificationCard(context, Posts()));
                        },
                        itemCount: 15,
                        separatorBuilder: (BuildContext context, int index) {
                          return 15.shb;
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: AppText(
                          "No notifications found",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    if (snapshot.data!.posts!.isEmpty) {
                      return const Center(
                        child: AppText(
                          "No notifications found",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 5),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return notificationCard(
                            context, snapshot.data!.posts![index]);
                      },
                      itemCount: snapshot.data!.posts!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 15.shb;
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

  notificationCard(context, Posts data) {
    return Container(
      width: Get.width,
      height: 150,
      decoration: CustomBoxDecorations().shadow(
          context: context,
          color: data.read == false ? AppColors.readBox : null),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        notificationImg(data.thumbnail ?? "null"),
        notificationDetails(data),
      ]),
    );
  }

  notificationImg(String url) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: CommonWidgets.networkImage(
        imageUrl: url,
        // "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg",
        alignment: Alignment.topCenter,
        width: Get.width / 3.5,
        fit: BoxFit.cover,
      ),
    );
  }

  notificationDetails(Posts data) {
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
              data.title ?? "null",
              fontWeight: FontWeight.bold,
              color: data.read == false ? Colors.black : null,
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
              color: data.read == false ? Colors.black : null,
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
