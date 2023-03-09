import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/search/api_services.dart';
import 'package:humble_warrior/view/search/model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBar(
                    margin: 16.pl,
                    padding: 8.pv,
                    child: TextFormField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0).r,
                        counterText: "",
                        hintText: "Search HW",
                        // hintStyle:
                        isDense: true,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),

                        /// prefixIcon
                        prefixIcon: IconButton(
                          padding: 8.pl,
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios,
                              color: Colors.black, size: 18.sp),
                        ),

                        // suffixIcon:
                        suffixIcon: GestureDetector(
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: 16.ph,
                  child: CircleAvatar(
                    maxRadius: 20.r,
                    backgroundColor: Colors.black26,
                    child: Icon(Icons.tune, color: Colors.black, size: 22.sp),
                  ),
                ),
              ],
            ),
            16.shb,
            Expanded(
              child: FutureBuilder<List<ProDetailItem>>(
                future: FetchSearchList().productDetails(controller.text),
                builder: (ctx, snapshot) {
                  if (controller.text.length == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          "Recent Searches",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ).paddingSymmetric(horizontal: 20, vertical: 20),
                        Expanded(
                          child: ListView.separated(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 40,
                                padding: 10.ph,
                                margin: 20.ph,
                                decoration: CustomBoxDecorations()
                                    .shadow(context: context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    AppText("Shoes"),
                                    Icon(Icons.cancel_outlined),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: AppText(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.data == []) {
                    return const Center(
                      child: AppText("No Data found"),
                    );
                  }
                  if (snapshot.data![0].productName == null ||
                      snapshot.data![0].productName == "") {
                    return const Center(
                      child: AppText("No Data found"),
                    );
                  }

                  return ListView.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.shb;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 80,
                          margin: 20.ph,
                          decoration:
                              CustomBoxDecorations().shadow(context: context),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AppText(
                                      snapshot.data![index].productName
                                          .toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    AppText(
                                      snapshot.data![index].productDescription
                                          .toString(),
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 8, vertical: 4),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: CommonWidgets.networkImage(
                                    height: 80,
                                    width: Get.width * .3,
                                    imageUrl:
                                        snapshot.data![index].url.toString(),
                                    fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        );

                        //   ListTile(
                        //   onTap: () {},
                        //   contentPadding: 16.ph,
                        //   leading: Image.asset(
                        //     ImagePathAssets.hwLogoUnnamed,
                        //     height: 40,
                        //     width: 40,
                        //   ),
                        //   title:
                        //       AppText("${snapshot.data![index].productName}"),
                        // );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
