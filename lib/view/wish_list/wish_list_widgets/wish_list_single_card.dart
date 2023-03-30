import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';

class WishListCard extends StatelessWidget {
  final double? cardHeight;
  final double imageHeight;
  final double imageTitleHeight;
  final double buttonbarHeight;
  final Widget? buttons;
  final double radius;
  final String imageUrl;
  final String title;
  final String deal;
  final VoidCallback? onTap;
  final ProductDetailsResponse details;

  const WishListCard(
      {Key? key,
      this.buttons,
      required this.details,
      this.buttonbarHeight = 75,
      this.radius = 10,
      this.imageHeight = 220,
      this.imageTitleHeight = 60,
      this.cardHeight,
      this.onTap,
      required this.deal,
      required this.imageUrl,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CardView(
          cardText: details.ribbonName.isNotEmptyAndNotNull
              ? details.ribbonName
              : details.itemName,
          imageText: true,
          imgUrl: details.url!,
          title: details.ribbonName != null
              ? details.ribbonName!
              : details.itemName.toString(),
          onTap: onTap,
          details: details,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  // bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(10),
                )),
            child: AppText(
              deal.toUpperCase(),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
