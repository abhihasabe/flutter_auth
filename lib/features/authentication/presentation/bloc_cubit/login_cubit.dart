import 'package:gs_diamond/features/authentication/presentation/bloc_cubit/login_state.dart';
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

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void mobileChanged(String value) {
    final mNumber = Number.dirty(value);
    emit(state.copyWith(
      mNumber: mNumber,
      status: Formz.validate([mNumber, state.mNumber, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.mNumber, state.password]),
    ));
  }

  void roleChanged(String value) {
    final role = Field.dirty(value);
    emit(state.copyWith(
      role: role,
      status: Formz.validate([role, state.mNumber, state.password]),
    ));
  }

  Future<void> userLogin() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    /*locator
        .get<LoginUseCase>()
        .invoke(User(
            mNumber: state.mNumber.value,
            password: state.password.value,
            role: state.role.value.toLowerCase()))
        .then((outPut) {
      _eitherLoadedOrErrorState(outPut);
    });*/
  }

  Future logout() async {
    locator.get<CacheManager>().request(
        cacheName: CacheConstants.cacheName, method: CacheConstants.deleteAll);
  }

  Future<void> _eitherLoadedOrErrorState(
      Either<Failure, dynamic> loginResp) async {
    loginResp.fold(
        (failure) => {
              emit(state.copyWith(
                  status: FormzStatus.submissionFailure,
                  exceptionError: "Invalid User Credential")),
            },
        (right) => {
              /*locator.get<CacheManager>().request(
                  cacheName: CacheConstants.cacheName,
                  method: CacheConstants.setString,
                  key: CacheConstants.userId,
                  value: LoginModel.fromJson(right).data?.id.toString() ?? ""),*/
              emit(state.copyWith(
                  status: FormzStatus.submissionSuccess,
                  outPut: "Login Successfully",
                  outPut1: state.role.value)),
            });
  }
}
