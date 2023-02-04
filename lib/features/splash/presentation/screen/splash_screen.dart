import 'package:flutter/services.dart';
import 'package:gs_diamond/features/splash/presentation/widget/splash_widget.dart';
import 'package:gs_diamond/core/constants/app_route_constant.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      VxNavigator.of(context)
          .clearAndPush(Uri.parse(AppRouteConstants.loginScreen));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
    return const SafeArea(child: SplashWidget());
  }
}
