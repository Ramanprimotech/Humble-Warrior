import 'package:humble_warrior/hw.dart';

class NotificationItem extends StatefulWidget {
  final Posts data;

  const NotificationItem({Key? key, required this.data}) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.width / 4.5,
      decoration: CustomBoxDecorations(context: context)
          .shadow(color: widget.data.read == false ? AppColors.readBox : null),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        notificationImg(widget.data.thumbnail ?? "null"),
        notificationDetails(widget.data),
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
              data.categoryName.toString().toUpperCase(),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          if (data.title.isNotEmptyAndNotNull)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: AppText(
                data.title ?? "",
                fontWeight: FontWeight.bold,
                color: data.read == false ? Colors.black : null,
                maxLines: 1,
                fontSize: 16,
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
                  child: AppText(
                    data.date != null ? data.date! : "",
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
