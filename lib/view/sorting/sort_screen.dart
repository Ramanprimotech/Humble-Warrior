import 'package:flutter/material.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/tap_handler.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

class Sort extends StatelessWidget {
   Sort({Key? key}) : super(key: key);

  SortController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                CommonWidgets.titleBar(context,
                    title: sortTxt, fontSize: 20,
                widget: GestureDetector(
                  onTap: (){
                    if(controller.check.value!=-1){
                      controller.reset();
                    }
                  },
                  child: Padding(
                    padding: 20.pr,
                    child: AppText('Reset',
                      color: controller.check.value!=-1?AppColors.primary:Colors.transparent,
                    ),
                  ),
                ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: 15.ph,
                      child: Column(children: [
                      Row(
                      children: [
                      Expanded(
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
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: double.maxFinite,
                        child: _BuildSort(),
                      ),
                  ),
                  ],
                ),
                        // selectionType(title: "Sort",id: 0),
                        // selectionType(title: "Sort",id: 1),
                        // selectionType(title: "Sort",id: 2),
                        // selectionType(title: "Sort",id: 3),
                      ],),
                    ),
                  ),
                ),
          Container(
            height: 50,
            margin: 20.pa,
            width: MediaQuery.of(Get.context!).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 3,blurRadius: 2)]
            ),
            child: AppText(
              "Apply",
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }



  selectionType({String? title, int? id}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
      child: GestureDetector(
        onTap: (){
          controller.click(id!);
        },
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title??""),
              Container(
                padding: 2.pa,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                   border: Border.all(color:Theme.of(Get.context!).textTheme.displaySmall!.color!,width: 2),
                ),
                child: Container(
                  // padding: 5.pa,
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.check.value==id!?AppColors.primary:Colors.transparent,
                  ),
                ),
              )
            ],),
        ),
      ),
    );
  }

}


class _BuildHeaders extends StatelessWidget {
  const _BuildHeaders({Key? key}) : super(key: key);

  static final SortController controller =
  Get.find<SortController>();

  @override
  Widget build(BuildContext context) {
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
              color: controller.headerIndex.value==index?AppColors.primary:Colors.transparent,
              shape: StadiumBorder(),
              elevation: 0,
              margin: 0.pa.r,
              child: Padding(
                padding: 12.6.ps.r,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 3.r,
                        backgroundColor: controller.headerIndex.value==index?Colors.white:AppColors.primary),
                    8.w.swb,
                    AppText(
                      controller.filterData[index].header,
                      color: controller.headerIndex.value==index?Colors.white:AppColors.primary,
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
  const _BuildSort({Key? key,}) : super(key: key);

  static final SortController controller =
  Get.find<SortController>();

  @override
  State<_BuildSort> createState() => _BuildSortState();
}

class _BuildSortState extends State<_BuildSort> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  ListView.builder(
        padding: EdgeInsets.zero,
        key:Key(_BuildSort.controller.headerIndex.value.toString()),
        itemCount: _BuildSort.controller.filterData[_BuildSort.controller.headerIndex.value].subHeader.length,
        itemBuilder: (_, index) {
          return Obx(
            () => Padding(
                padding: 8.16.ps.r,
                child: TapHandler(
                      onTap: () {
                        _BuildSort.controller.filterData[_BuildSort.controller.headerIndex.value].selected = index;
                        setState(() {

                        });
                      },
                      child: Row(
                          children: [
                            Icon(
                              Icons.check_rounded,
                              color:_BuildSort.controller.filterData[_BuildSort.controller.headerIndex.value].selected == index
                              ? AppColors.primary
                                  : Colors.transparent,
                              size: 20.w,
                            ),
                            4.swb,
                            AppText(
                              _BuildSort.controller.filterData[_BuildSort.controller.headerIndex.value].subHeader[index],
                              color: _BuildSort.controller.filterData[_BuildSort.controller.headerIndex.value].selected == index ? AppColors.primary : null,
                            ),
                          ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}


