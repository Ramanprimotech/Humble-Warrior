import 'package:humble_warrior/hw.dart';

class PaginationWidget extends StatelessWidget {
  final RxBool apiBool;
  final Future Function({bool? refresh}) api;
  final Function update;
  final RxInt length;
  final RxInt totalRecords;
  final ScrollController scrollController;
  final Widget child;

  const PaginationWidget({
    super.key,
    required this.apiBool,
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
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          if (length.value < totalRecords.value) {
            if (apiBool.value == false) {
              apiBool.value = true;
              update();
              Future.delayed(Duration(milliseconds: 10), () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              });

              api();
            }
          }
        }
        return true;
      },
      child: RefreshIndicator(
          onRefresh: () async {
            await api(refresh: true).then((value) => Future.value(0));
          },
          child: child),
    );
  }
}
