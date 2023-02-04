import 'package:gs_diamond/features/authentication/domain/usecase/mobile_usecase.dart';
import 'package:gs_diamond/features/authentication/domain/usecase/otp_usecase.dart';
import 'package:gs_diamond/core/error/failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, dynamic>> userMobile(User loginData);
  Future<Either<Failure, dynamic>> userOTP(OTP loginData);
}