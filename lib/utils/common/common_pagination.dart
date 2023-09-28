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
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >= (scrollInfo.metrics.maxScrollExtent / totalRecords.value) * 5 && totalRecords.value > 5) {
          if(apiBool.value == false){
            print("hfjsdfhsjsfsdh Api call");
            apiBool.value = true;
              CommonUtils.toCheckInternet(action: () {
              if (length.value < totalRecords.value) {
                update();
                // Future.delayed(const Duration(milliseconds: 10), () {
                //   scrollController.animateTo(
                //     scrollController.position.maxScrollExtent,
                //     duration: const Duration(milliseconds: 100),
                //     curve: Curves.fastOutSlowIn,
                //   );
                // });
                api().whenComplete(() =>
                   apiBool.value = false
                );
              }
            });
          }
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
