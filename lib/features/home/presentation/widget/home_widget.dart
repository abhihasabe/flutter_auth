import 'package:flutter/material.dart';
import 'package:gs_diamond/core/theme/app_text_styles.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home", style: appBarTextStyle),
          brightness: Brightness.light,
        ),
        body: const Text("data"));
  }
}
