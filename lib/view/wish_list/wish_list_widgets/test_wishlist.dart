import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/hive/hive_storage_service.dart';
import 'package:humble_warrior/hive/wishlistitem.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/extensions.dart';

class WishlistScreenTest extends StatelessWidget {
  const WishlistScreenTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HiveService service = Get.find<HiveService>();
    Box<Wishlistitem> box = service.box;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Wishlistitem item = Wishlistitem(
                    shop: "shopUrl!",
                    productId: box.length.toString(),
                    code: "details.couponCode!",
                    type: '0',
                    image: "details.url!",
                    dealName: "details.dealName!");
                service.box.put(box.length.toString(), item);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, value, child) {
            var keys = value.keys.toList();
            var values = value.values.toList();
            return ListView.separated(
              itemCount: values.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          service.deleteItem(keys[index].toString());
                        },
                        child: AppText(
                            keys[index].toString() + "  This is the key")),
                    AppText(maxLines: 5, values[index].toString())
                  ],
                );
              },
              separatorBuilder: (context, int) => 20.sh,
            );
          }),
    );
  }
}
