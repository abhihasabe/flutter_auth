import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/authentication_cubit.dart';
import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/authentication_state.dart';
import 'package:gs_diamond/features/authentication/presentation/widget/otp_widget.dart';
import 'package:gs_diamond/core/constants/app_route_constant.dart';
import 'package:gs_diamond/core/helper/dialog.helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          DialogHelper.dismissDialog(context);
          DialogHelper.showToast(
              context, state.exceptionError, ToastGravity.BOTTOM);
        } else if (state.status.isSubmissionSuccess) {
          DialogHelper.dismissDialog(context);
          if (state.outPut1 == 1) {
            VxNavigator.of(context)
                .clearAndPush(Uri.parse(AppRouteConstants.homeScreen));
          } else {
            DialogHelper.showToast(
                context, state.outPut.toString(), ToastGravity.BOTTOM);
          }
        } else if (state.status.isSubmissionInProgress) {
          DialogHelper.showLoaderDialog(context);
        }
      }, builder: (context, state) {
        return const SafeArea(child: OtpWidget());
      }),
    );
  }
}
