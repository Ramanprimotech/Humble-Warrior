import 'package:humble_warrior/hw.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

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
              child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: (){},
                      contentPadding: 16.ph,
                      leading: Image.asset(
                        ImagePathAssets.hwLogoUnnamed,
                        height: 40,
                        width: 40,
                      ),
                      title: AppText("Gods Now's"),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

