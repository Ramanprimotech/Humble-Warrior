import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/notification_response_model.dart';
import 'package:humble_warrior/view/notification/notification_item.dart';

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
                              child: NotificationItem(data: Posts()));
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
                        return NotificationItem(
                            data: snapshot.data!.posts![index]);
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
}
