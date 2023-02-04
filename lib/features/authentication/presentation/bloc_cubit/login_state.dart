import 'package:gs_diamond/core/validations/number_validation_dart.dart';
import 'package:gs_diamond/core/validations/password_validation.dart';
import 'package:gs_diamond/core/validations/field_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  const LoginState({
    this.mNumber = const Number.pure(),
    this.password = const Password.pure(),
    this.role = const Field.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
    this.outPut = "",
    this.outPut1 = "",
  });

  final Number mNumber;
  final Password password;
  final Field role;
  final FormzStatus status;
  final String exceptionError;
  final Object outPut;
  final Object outPut1;

  @override
  List<Object> get props =>
      [mNumber, password, role, status, exceptionError, outPut, outPut1];

  LoginState copyWith({
    Number? mNumber,
    Password? password,
    Field? role,
    FormzStatus? status,
    String? exceptionError,
    Object? outPut,
    Object? outPut1,
  }) {
    return LoginState(
        mNumber: mNumber ?? this.mNumber,
        password: password ?? this.password,
        role: role ?? this.role,
        status: status ?? this.status,
        exceptionError: exceptionError ?? this.exceptionError,
        outPut: outPut ?? this.outPut,
        outPut1: outPut1 ?? this.outPut1);
  }
}
