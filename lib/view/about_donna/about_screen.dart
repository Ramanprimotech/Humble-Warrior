import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey,
            boxShadow: [BoxShadow(
              color: Colors.grey.shade100,spreadRadius: 5,blurRadius: 5,
            )]
          ),
          child: AppText(aboutDonnaTxt,fontWeight: FontWeight.bold),
      ),
      ]),
    );
  }
}
