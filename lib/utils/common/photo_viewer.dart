import 'package:humble_warrior/hw.dart';
import 'package:photo_view/photo_view.dart';

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
