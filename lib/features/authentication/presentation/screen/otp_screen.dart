import 'package:gs_diamond/features/authentication/presentation/widget/otp_widget.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: OtpWidget());
  }
}
