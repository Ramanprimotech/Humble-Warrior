import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_UI.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomSearchBar(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("sfddf"),
          ],
        ),
      ),
    );
  }
}
