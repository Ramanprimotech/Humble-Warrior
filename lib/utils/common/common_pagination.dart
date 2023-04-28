import 'package:humble_warrior/hw.dart';

class PaginationWidget extends StatelessWidget {

  final RxBool apiBool;
  final Future Function({bool? refresh}) api;
  final Function update;
  final bool showRefresh;
  final RxInt length;
  final RxInt totalRecords;
  final ScrollController scrollController;
  final Widget child;

  const PaginationWidget({
    super.key,
    required this.apiBool,
    this.showRefresh  = true,
    required this.api,
    required this.update,
    required this.scrollController,
    required this.child,
    required this.totalRecords,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    Timer? _timer;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          if (_timer != null) {
            _timer!.cancel();
          }
          _timer = Timer(const Duration(milliseconds: 1000), () {
            CommonUtils.toCheckInternet(action: () {
              if (length.value < totalRecords.value) {
                if (apiBool.value == false) {
                  apiBool.value = true;
                  update();
                  // Future.delayed(const Duration(milliseconds: 10), () {
                  //   scrollController.animateTo(
                  //     scrollController.position.maxScrollExtent,
                  //     duration: const Duration(milliseconds: 100),
                  //     curve: Curves.fastOutSlowIn,
                  //   );
                  // });

                  api();
                }
              }
            });
          });
        }
        return true;
      },
      child: showRefresh ? RefreshIndicator(
          onRefresh: () async {
            Future.delayed(const Duration(seconds: 1), () async {
              CommonUtils.toCheckInternet(action: () async {
                await api(refresh: true).then((value) => Future.value(0));
              });
            });
          },
          child: child): child,
    );
  }
}
