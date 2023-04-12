import 'package:humble_warrior/hw.dart';
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
      bottomNavigationBar: bottomNavigationWidget(context),
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context,
                title: notificationsTxt,

                fontSize: 20,),
                // widget: FutureBuilder<NotificationResponseModel>(
                //     future: _notificationController.notificationList(),
                //     builder: (context, snapshot) {
                //
                //       if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasError){
                //         return const SizedBox(width: 95,);
                //       }
                //       if (snapshot.data!.posts!.isNotEmpty && isLoggedIn) {
                //         return Container(
                //           padding: 20.pr,
                //           alignment: Alignment.centerRight,
                //           width: 95,
                //           child: GestureDetector(
                //               onTap: () {
                //                 DialogHelper.showConfirmationDialog(
                //                     context: context,
                //                     message: confirmDeleteNotification,
                //                     actionLabel: deleteTxt,
                //                     action: () async {
                //                       Get.back();
                //                       DialogHelper.showLoadingDialog(
                //                           label: loadingTxt);
                //                       await _notificationController
                //                           .deleteNotification()
                //                           .then((value) {
                //                         DialogHelper.closeDialog();
                //                         if (!value) {
                //                           debugPrint(
                //                               "Error Deleting the notifications");
                //                         } else {
                //                           setState(() {});
                //                         }
                //                       });
                //                     });
                //               },
                //               child: AppText(
                //                 clearAllTxt,
                //                 color: AppColors.primary,
                //               )),
                //         );
                //       }
                //       return const SizedBox(width: 95,);
                //     })),
            // if (_notificationController.notificationList().toString().isNotEmpty && isLoggedIn)
                Align(
                  alignment: Alignment.centerRight,
                  child: FutureBuilder<NotificationResponseModel>(
                      future: _notificationController.notificationList(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting || snapshot.hasError){
                          return const SizedBox(width: 95,height: 20,);
                        }
                        if (snapshot.data!.posts!.isNotEmpty && isLoggedIn) {
                          return Container(
                            padding: const EdgeInsets.only(right: 20,bottom: 10),
                            alignment: Alignment.centerRight,
                            width: 95,
                            child: GestureDetector(
                                onTap: () {
                                  DialogHelper.showConfirmationDialog(
                                      context: context,
                                      message: confirmDeleteNotification,
                                      actionLabel: deleteTxt,
                                      action: () async {
                                        Get.back();
                                        DialogHelper.showLoadingDialog(
                                            label: loadingTxt);
                                        await _notificationController
                                            .deleteNotification()
                                            .then((value) {
                                          DialogHelper.closeDialog();
                                          if (!value) {
                                            debugPrint(
                                                "Error Deleting the notifications");
                                          } else {
                                            setState(() {});
                                          }
                                          _notificationController.update(['badge']);
                                        });
                                      });
                                },
                                child: AppText(
                                  clearAllTxt,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                )),
                          );
                        }
                        return const SizedBox(width: 95,height: 20,);
                      }),
                ),
            Expanded(
              child: isLoggedIn == false
                  ? loginFirst(context)
                  : CustomRefreshIndicator(
                      onRefresh: () {
                        setState(() {});
                        return Future.value(0);
                      },
                      child: FutureBuilder<NotificationResponseModel>(
                        future: _notificationController.notificationList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.separated(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 5),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return const CustomShimmer.rectangular(
                                  height: 100,
                                  width: double.infinity,
                                );
                              },
                              itemCount: 15,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return 15.shb;
                              },
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: AppText(
                                noNotificationTxt,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          if (snapshot.data!.posts!.isEmpty) {
                            return const Center(
                              child: AppText(
                                noNotificationTxt,
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
                              Posts posts = snapshot.data!.posts![index];
                              return GestureDetector(
                                  onTap: () async {
                                    await _notificationController
                                        .notificationDetailsNavigator(
                                            posts.categoryName, posts.id)
                                        .then((value) => setState(() {
                                              _notificationController.update();
                                              _notificationController.update(['badge']);
                                            }));
                                  },
                                  child: NotificationItem(data: posts));
                            },
                            itemCount: snapshot.data!.posts!.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
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
