import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/tap_handler.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

class Sort extends StatefulWidget {
  const Sort({Key? key}) : super(key: key);

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  SortController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.filterInitialData();
  }

  @override
  Widget build(BuildContext context) {
    controller.checkFilter();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SortController>(
            id: "sort",
            builder: (controller) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidgets.titleBar(
                      context,
                      title: sortTxt,
                      fontSize: 20,
                      onPress: () {
                        controller.back();
                      },
                      widget: GestureDetector(
                        onTap: () {
                          if (controller.isItemSelected.value) {
                            controller.reset();
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: 20.pr,
                          child: Obx(
                            () => AppText(
                              resetTxt,
                              color: controller.isItemSelected.value
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: 15.ph,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: SizedBox(
                                      height: double.maxFinite,
                                      child: _BuildHeaders(),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: AppColors.primary,
                                    width: 5.w,
                                    thickness: 0.2,
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: double.maxFinite,
                                      child: _BuildSort(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.apply();
                      },
                      child: Container(
                        height: 50,
                        margin: 20.pa,
                        width: MediaQuery.of(Get.context!).size.width,
                        alignment: Alignment.center,
                        decoration: CustomBoxDecorations(context: context)
                            .shadow(color: AppColors.primary),
                        /*BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 3,blurRadius: 2)]
                    ),*/
                        child: const AppText(
                          "Apply",
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]);
            }),
      ),
    );
  }
}

class _BuildHeaders extends StatefulWidget {
  const _BuildHeaders({Key? key}) : super(key: key);

  @override
  State<_BuildHeaders> createState() => _BuildHeadersState();
}

class _BuildHeadersState extends State<_BuildHeaders> {
  @override
  Widget build(BuildContext context) {
    SortController controller = Get.find<SortController>();
    return ListView.separated(
      padding: 8.pa.r,
      itemCount: controller.filterData.length,
      separatorBuilder: (_, __) => 20.shb,
      itemBuilder: (_, index) {
        return TapHandler(
          onTap: () {
            controller.headerIndex.value = index;
            controller.update();
          },
          child: Obx(
            () => Card(
              color: controller.headerIndex.value == index
                  ? AppColors.primary
                  : Colors.transparent,
              shape: const StadiumBorder(),
              elevation: 0,
              margin: 0.pa.r,
              child: Padding(
                padding: 12.6.ps.r,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 3.r,
                        backgroundColor: controller.headerIndex.value == index
                            ? Colors.white
                            : AppColors.primary),
                    8.w.swb,
                    AppText(
                      controller.filterData[index].header,
                      color: controller.headerIndex.value == index
                          ? Colors.white
                          : AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildSort extends StatefulWidget {
  const _BuildSort({
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildSort> createState() => _BuildSortState();
}

class _BuildSortState extends State<_BuildSort> {
  @override
  Widget build(BuildContext context) {
    final SortController controller = Get.find<SortController>();
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        key: Key(controller.headerIndex.value.toString()),
        itemCount: controller
            .filterData[controller.headerIndex.value].subHeader.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: 8.16.ps.r,
            child: TapHandler(
              onTap: () {
                controller.filterData[controller.headerIndex.value].selected =
                    index;
                controller.checkFilter();
                setState(() {});
              },
              child: Row(
                children: [
                  Icon(
                    Icons.check_rounded,
                    color: controller.filterData[controller.headerIndex.value]
                                .selected ==
                            index
                        ? AppColors.primary
                        : Colors.transparent,
                    size: 20.w,
                  ),
                  4.swb,
                  AppText(
                    controller.filterData[controller.headerIndex.value]
                        .subHeader[index].itemnName,
                    color: controller.filterData[controller.headerIndex.value]
                                .selected ==
                            index
                        ? AppColors.primary
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
