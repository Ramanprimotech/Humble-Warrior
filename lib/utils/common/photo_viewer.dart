import 'package:humble_warrior/hw.dart';

class CustomPhotoViewer extends StatelessWidget {
  final String url;

  const CustomPhotoViewer({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              loadingBuilder:
                  (BuildContext context, ImageChunkEvent? loadingProgress) {
                return Center(
                  child: CustomShimmer(
                    height: 450,
                    width: Get.width,
                  ),
                );
              },
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 1.5,
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              imageProvider: NetworkImage(url),
            ),
            CommonWidgets.titleBar(context,
                title: photoViewerTxt, fontSize: 20, backIcon: true),
          ],
        ),
      ),
    );
  }
}
