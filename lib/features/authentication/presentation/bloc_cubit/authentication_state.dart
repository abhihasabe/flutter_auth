import 'package:gs_diamond/core/validations/number_validation_dart.dart';
import 'package:gs_diamond/core/validations/password_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.mNumber = const Number.pure(),
    this.otp = const Password.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
    this.outPut = "",
    this.outPut1 = "",
  });

  final Number mNumber;
  final Password otp;
  final FormzStatus status;
  final String exceptionError;
  final Object outPut;
  final Object outPut1;

  @override
  List<Object> get props =>
      [mNumber, otp, status, exceptionError, outPut, outPut1];

  AuthenticationState copyWith({
    Number? mNumber,
    Password? otp,
    FormzStatus? status,
    String? exceptionError,
    Object? outPut,
    Object? outPut1,
  }) {
    return AuthenticationState(
        mNumber: mNumber ?? this.mNumber,
        otp: otp ?? this.otp,
        status: status ?? this.status,
        exceptionError: exceptionError ?? this.exceptionError,
        outPut: outPut ?? this.outPut,
        outPut1: outPut1 ?? this.outPut1);
  }
}
