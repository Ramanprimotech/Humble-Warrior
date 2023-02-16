import 'package:flutter/cupertino.dart';

Widget future<T>({
  required Future<T> api,
  required Widget Function() waiting,
  required Widget Function(T? data) sucess,
  required Widget Function(Object? error) error,
}) {
  return FutureBuilder<T>(
      future: api,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waiting();
          // return Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (ctx, index) {
          //       if (index == 3) {
          //         return ValueListenableBuilder(
          //           valueListenable: controller.keyboardIsOpened,
          //           builder: (context, value, child) {
          //             return Visibility(
          //               visible: value,
          //               child: SizedBox(
          //                 height: brandHeight + brandLoveHeight + 10,
          //               ),
          //             );
          //           },
          //         );
          //       }
          //       return ShimmerLoader(
          //         child: homeOption(
          //             homeOptions: HomeCategoryList(
          //                 categoryImage:
          //                 "https://www.pngfind.com/pngs/m/415-4156288_image-nike-logo-just-do-it-orange-hd.png",
          //                 categoryName: "Donna's Options",
          //                 id: 0),
          //             index: index),
          //       );
          //     },
          //     itemCount: 4,
          //   ),
          // );
        }
        if (snapshot.hasError) {
          return error(snapshot.error);
          // // return ErrorWidget(snapshot.error!);
          // final DialogueThemeExtention dialogueThemeExtention =
          // Theme.of(context).extension<DialogueThemeExtention>()!;
          // return Padding(
          //   padding:
          //   const EdgeInsets.only(top: 80.0, left: 30, right: 30),
          //   child: Container(
          //     height: 200,
          //     width: Get.width,
          //     padding:
          //     EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: dialogueThemeExtention.backGroundColor,
          //       boxShadow: [
          //         BoxShadow(
          //             color: dialogueThemeExtention.shadow!,
          //             spreadRadius: 2,
          //             blurRadius: 2,
          //             offset: Offset(0, 0))
          //       ],
          //     ),
          //     child: Column(children: [
          //       AppText("${snapshot.error.toString()}",
          //           maxLines: 5, fontSize: 20),
          //       20.sh,
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           elevation: 5,
          //           // fixedSize: const Size(, 35),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           backgroundColor: dialogueThemeExtention.buttonColor,
          //         ),
          //         onPressed: () {
          //           controller.update([Endpoints.homeCategories]);
          //         },
          //         child: const AppText('Retry',
          //             color: Colors.white, fontWeight: FontWeight.bold),
          //       ),
          //     ]),
          //   ),
          // );
          // // return const AppText("Something Went Wrong");
        }
        return sucess(snapshot.data);
        // List<T> data = snapshot.data ?? [];
        // return Expanded(
        //   child: ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       if (index == data.length) {
        //         return ValueListenableBuilder(
        //           valueListenable: controller.keyboardIsOpened,
        //           builder: (ctx, value, child) {
        //             return Visibility(
        //               visible: value,
        //               child: SizedBox(
        //                 height: brandHeight + brandLoveHeight + 10,
        //               ),
        //             );
        //           },
        //         );
        //       }
        //       return homeOption(homeOptions: data[index], index: index);
        //     },
        //     itemCount: data.length + 1,
        //   ),
        // );
      });
}
