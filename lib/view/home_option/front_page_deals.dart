import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/app_icons.dart';

import '../../utils/image_path_network.dart';
import 'common_home_option.dart';

class FrontPageDeals extends StatelessWidget {
  const FrontPageDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (ctx, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemCard(
          buttons: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              shareButton(shareUrl: "shareUrl"),
              IconButton(
                onPressed: () {},
                icon: AppIcons.bookmarks(),
              ),
              IconButton(
                onPressed: () {},
                icon: AppIcons.comment(),
              ),
            ],
          ),
          imageUrl: ImagePathNetwork.banner,
          title: 'Title Of Image',
        ),
      );
    });
  }
}
