import 'package:humble_warrior/hw.dart';

class BottomNavigationScreen extends GetView<BottomNavigationController> {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder(
          init: controller,
          builder: (BottomNavigationController ctr) {
            return Scaffold(
              bottomNavigationBar: bottomNavigationWidget(context),
              body: ctr.navigationItems.elementAt(ctr.selectedIndex),
            );
          }),
    );
  }
}
