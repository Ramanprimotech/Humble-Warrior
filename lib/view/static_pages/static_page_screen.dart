
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/html.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:humble_warrior/modals/response/static_page_model.dart';
import 'package:humble_warrior/view/static_pages/static_page_controller.dart';

class StaticPagesScreen extends StatelessWidget {
  const StaticPagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StaticPagesController controller = Get.find<StaticPagesController>();
    controller.id = Get.arguments[0];
    String title = Get.arguments[1];
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 20),
        CommonWidgets.titleBar(context,
            title: title, fontSize: 20),
        // 20.sh,
   FutureBuilder<List<StaticData>>(
       future:controller.staticPageApi(controller.id),
       builder: (context ,snapshot){
     if(snapshot.connectionState == ConnectionState.waiting){
       return const Expanded(child: Center(child: CircularProgressIndicator()));
     }
     print("id ---- ${controller.id } ${ snapshot.data}");
     if(snapshot.hasError){
       return CommonWidgets.errorAPI(errorText: "${snapshot.error}",
           context: context,
           onPress: (){Get.back();},
           buttonTitle: "OK");
     }

     List<StaticData> staticResponse = snapshot.data!;
    return  staticResponse.isNotEmpty?
    Expanded(

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: HtmlData().htmlString(context, staticResponse[0].pageContent.toString()),
          // HTML.toRichText(context, ,
          //   linksCallback: (dynamic link) {
          //     CommonUtils().urlLauncher(url: link.toString());
          //   },)

          // AppText(staticResponse[0].pageContent.toString(),maxLines: 100,),
        ),
      ),
    ):Expanded(
      child: Center(
        child: CommonWidgets.errorAPI(errorText: "${snapshot.error}",
            context: context,
            onPress: (){Get.back();},
            buttonTitle: "OK")
      ),
    );
   }),

      ]),
    );
  }
}
