import 'package:gs_diamond/features/authentication/domain/repository/authentication_repository.dart';
import 'package:gs_diamond/core/usecase/usecase.dart';
import 'package:gs_diamond/core/error/failure.dart';
import 'package:gs_diamond/di/injection.dart';
import 'package:either_dart/src/either.dart';

class OTPUseCase implements UseCaseOneInput<OTP, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(OTP otpData) async {
    return await locator.get<AuthenticationRepository>().userOTP(otpData);
  }
}

class OTP {
  String otp;
  OTP({required this.otp});
}
