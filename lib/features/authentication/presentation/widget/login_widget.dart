import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/authentication_cubit.dart';
import 'package:gs_diamond/core/constants/app_assets_constant.dart';
import 'package:gs_diamond/core/constants/app_constant.dart';
import 'package:gs_diamond/core/theme/app_text_styles.dart';
import 'package:gs_diamond/core/helper/dialog.helper.dart';
import 'package:gs_diamond/core/theme/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController mobileController = TextEditingController();
  final _mobileTextFocus = FocusNode();

  bool get isPopulated => mobileController.text.trim().isNotEmptyAndNotNull;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 6,
              /*decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),*/
              child: Image.asset(AppAssets.splashLogo),
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Verification',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const SizedBox(
              height: 08,
            ),
            const Text(
              'Enter your mobile number to receive a Verification code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    onFieldSubmitted: (value) {
                      mobileController.text = value;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    cursorColor: primaryColor,
                    cursorHeight: 20,
                    cursorWidth: 1,
                    focusNode: _mobileTextFocus,
                    controller: mobileController,
                    style: textFormFieldStyle,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: buttonBordersColor, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: buttonBordersColor, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: errorColor, width: 1.0),
                      ),
                      labelStyle: textFormFieldLabelStyle,
                      labelText: AppConstants.mNumber,
                    ),
                    validator: (value) {
                      "Please Enter Mobile Number";
                    },
                    onChanged: (mNumber) {
                      context
                          .read<AuthenticationCubit>()
                          .mobileChanged(mNumber);
                    }),
                const SizedBox(height: 30),
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
                        if (mobileController.text.isNotEmptyAndNotNull &&
                            mobileController.text.length == 10) {
                          context.read<AuthenticationCubit>().checkMobileNo();
                        } else if (mobileController.text.isNotEmptyAndNotNull &&
                                mobileController.text.length < 10 ||
                            mobileController.text.length > 10) {
                          DialogHelper.showToast(
                              context,
                              "Please Enter Valid Mobile Number",
                              ToastGravity.BOTTOM);
                        } else {
                          DialogHelper.showToast(
                              context,
                              "Please Enter Mobile Number",
                              ToastGravity.BOTTOM);
                        }
                      },
                      child: const Text(
                        AppConstants.otp,
                        style: textButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
