import 'package:gs_diamond/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:gs_diamond/features/authentication/domain/repository/authentication_repository.dart';
import 'package:gs_diamond/features/authentication/domain/usecase/mobile_usecase.dart';
import 'package:gs_diamond/core/constants/app_network_constants.dart';
import 'package:gs_diamond/core/error/exceptions.dart';
import 'package:gs_diamond/core/error/failure.dart';
import 'package:gs_diamond/di/injection.dart';
import 'package:either_dart/src/either.dart';
import 'package:gs_diamond/features/authentication/domain/usecase/otp_usecase.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Either<Failure, dynamic>> userMobile(User loginData) async {
    try {
      final uri = Uri.parse(AppNetworkConstants.mobileAuthenticationURL);
      var loginJsonData = {
        "MobileNumber": loginData.mNumber,
        "DeviceID": "1",
        "DeviceName": "MotoG",
        "IMEI": "SDSD54545",
        "GoogleToken": "SKEKED5SDSDSD4"
      };
      final connectingResponse = await locator
          .get<AuthenticationDataSource>()
          .authentication(uri, loginJsonData);
      if (connectingResponse != null) {
        return Right(connectingResponse);
      } else {
        return Left(ServerFailure(message: 'Data Not Found'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> userOTP(OTP otpData) async {
    try {
      final uri = Uri.parse(AppNetworkConstants.checkValidateOTPURL);
      var otpJsonData = {
        "UserCode": "30",
        "DeviceID": "1",
        "EnteredOTP": otpData.otp
      };
      final connectingResponse = await locator
          .get<AuthenticationDataSource>()
          .authentication(uri, otpJsonData);
      if (connectingResponse != null) {
        return Right(connectingResponse);
      } else {
        return Left(ServerFailure(message: 'Data Not Found'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
