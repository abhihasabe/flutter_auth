import 'dart:convert';

import 'package:gs_diamond/features/authentication/data/model/mobile_model.dart';
import 'package:gs_diamond/features/authentication/data/model/otp_model.dart';
import 'package:gs_diamond/features/authentication/domain/usecase/mobile_usecase.dart';
import 'package:gs_diamond/features/authentication/domain/usecase/otp_usecase.dart';
import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/authentication_state.dart';
import 'package:gs_diamond/core/validations/number_validation_dart.dart';
import 'package:gs_diamond/core/validations/password_validation.dart';
import 'package:gs_diamond/core/constants/app_cache_constant.dart';
import 'package:gs_diamond/core/validations/field_validation.dart';
import 'package:gs_diamond/core/manager/cache_manager.dart';
import 'package:gs_diamond/core/error/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gs_diamond/di/injection.dart';
import 'package:either_dart/either.dart';
import 'package:formz/formz.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void mobileChanged(String value) {
    final mNumber = Number.dirty(value);
    emit(state.copyWith(
      mNumber: mNumber,
      status: Formz.validate([mNumber, state.mNumber, state.otp]),
    ));
  }

  void otpChanged(String value) {
    final otp = Password.dirty(value);
    emit(state.copyWith(
      otp: otp,
      status: Formz.validate([otp, state.mNumber, state.otp]),
    ));
  }

  Future<void> checkMobileNo() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    locator
        .get<MobileUseCase>()
        .invoke(User(mNumber: state.mNumber.value))
        .then((outPut) {
      outPut.fold(
          (failure) => {
                emit(state.copyWith(
                    status: FormzStatus.submissionFailure,
                    exceptionError: failure.props.toString())),
              },
          (right) => {
                locator.get<CacheManager>().request(
                    cacheName: CacheConstants.cacheName,
                    method: CacheConstants.setString,
                    key: CacheConstants.userId,
                    value: MobileModel.fromJson(right)
                            .data?[0]
                            .status
                            .toString() ??
                        ""),
                emit(state.copyWith(
                    status: FormzStatus.submissionSuccess,
                    outPut: MobileModel.fromJson(right).data?[0].message,
                    outPut1: MobileModel.fromJson(right).data?[0].status)),
              });
    });
  }

  Future<void> checkOTP() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    locator.get<OTPUseCase>().invoke(OTP(otp: state.otp.value)).then((outPut) {
      print("object: $outPut");
      outPut.fold(
          (failure) => {
                emit(state.copyWith(
                    status: FormzStatus.submissionFailure,
                    exceptionError: failure.props.toString())),
              },
          (right) => {
                locator.get<CacheManager>().request(
                    cacheName: CacheConstants.cacheName,
                    method: CacheConstants.setString,
                    key: CacheConstants.userId,
                    value:
                        OTPModel.fromJson(right).data?[0].status.toString() ??
                            ""),
                emit(state.copyWith(
                    status: FormzStatus.submissionSuccess,
                    outPut: OTPModel.fromJson(right).data?[0].message,
                    outPut1: OTPModel.fromJson(right).data?[0].status)),
              });
    });
  }

  Future logout() async {
    locator.get<CacheManager>().request(
        cacheName: CacheConstants.cacheName, method: CacheConstants.deleteAll);
  }
}
