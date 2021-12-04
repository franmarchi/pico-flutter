import 'package:flutter/material.dart';

class AppBarMobile extends StatefulWidget {
  const AppBarMobile({Key? key}) : super(key: key);

  @override
  _AppBarMobileState createState() => _AppBarMobileState();
}

class _AppBarMobileState extends State<AppBarMobile> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Pico"),
    );
  }
}
