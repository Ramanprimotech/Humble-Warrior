import 'package:humble_warrior/hw.dart';

class CatCard extends StatelessWidget {
  const CatCard({Key? key, this.imageUrl, this.onTap, this.title})
      : super(key: key);
  final String? imageUrl;
  final onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: 30.pl,
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 45,
              child: Image.network(errorBuilder: (context, error, stackTrace) {
                return Center(
                    child: Image.asset(
                  ImagePathAssets.noImageFound,
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  // height: height,
                ));
              }, imageUrl ?? ""),
            ),
            // 4.shb,
            AppText(title ?? "",
                fontSize: 14, maxLines: 1, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}
