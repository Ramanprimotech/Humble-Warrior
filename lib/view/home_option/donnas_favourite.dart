import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/app_icons.dart';

import '../../utils/image_path_network.dart';
import 'common_home_option.dart';

class DonnaFavourite extends StatelessWidget {
  const DonnaFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (ctx, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemCard(
          buttons: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              shopButton(url: ImagePathNetwork.url),
              codeButton(code: "dklfgj"),
              shareButton(shareUrl: ImagePathNetwork.url),
              IconButton(
                onPressed: () {},
                icon: AppIcons.bookmarks(),
              ),
            ],
          ),
          imageUrl:
              "https://humblewarrior.com/wp-content/uploads/2022/11/ANRABESS-2022-Fall-Winter-Long-Sleeve-1-4-Zipper-Collared-Casual-Chunky-Cable-Knit-Cropped-Pullover-11-15-22-LIVE-PIC-SMC.jpg",
          title: 'Title Of Image',
        ),
      );
    });
  }
}
