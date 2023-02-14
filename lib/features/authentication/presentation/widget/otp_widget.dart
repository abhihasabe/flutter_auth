import 'package:gs_diamond/core/constants/app_assets_constant.dart';
import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/authentication_cubit.dart';
import 'package:gs_diamond/features/authentication/presentation/widget/otp_input_widget.dart';
import 'package:gs_diamond/core/constants/app_constant.dart';
import 'package:gs_diamond/core/theme/app_text_styles.dart';
import 'package:gs_diamond/core/helper/dialog.helper.dart';
import 'package:gs_diamond/core/theme/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OtpWidget extends StatefulWidget {
  const OtpWidget({Key? key}) : super(key: key);

  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        if (this.mounted) {
          setState(() {
            secondsRemaining--;
          });
        }
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 6,
                /*decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),*/
                child: Image.asset(AppAssets.splashLogo),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Please enter the 4 digit code sent to your mobile number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Column(
                children: [
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpInput(_fieldOne, true, false),
                        OtpInput(_fieldTwo, false, false),
                        OtpInput(_fieldThree, false, false),
                        OtpInput(_fieldFour, false, true),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBgColor,
                            minimumSize: const Size(double.maxFinite, 48)),
                        onPressed: () {
                          if (_fieldOne.text.isNotEmptyAndNotNull &&
                              _fieldTwo.text.isNotEmptyAndNotNull &&
                              _fieldThree.text.isNotEmptyAndNotNull &&
                              _fieldFour.text.isNotEmptyAndNotNull) {
                            context.read<AuthenticationCubit>().otpChanged(
                                _fieldOne.text +
                                    _fieldTwo.text +
                                    _fieldThree.text +
                                    _fieldFour.text);
                            context.read<AuthenticationCubit>().checkOTP();
                          } else {
                            DialogHelper.showToast(context, "Please Enter OTP",
                                ToastGravity.BOTTOM);
                          }
                        },
                        child: const Text(
                          AppConstants.verify,
                          style: textButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              enableResend
                  ? InkWell(
                      onTap: enableResend ? _resendCode : null,
                      child: const Text(
                        "Resend New OTP",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Text(
                      'Resend OTP after $secondsRemaining seconds',
                      style: const TextStyle(color: primaryColor, fontSize: 14),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  Widget _textFieldOTP({required bool first, last}) {
    return SizedBox(
      height: 55,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            print("value: $value");
            context.read<AuthenticationCubit>().otpChanged(value);
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 20.0),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
