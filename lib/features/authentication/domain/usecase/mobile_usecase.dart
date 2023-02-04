import 'package:gs_diamond/features/authentication/domain/repository/authentication_repository.dart';
import 'package:gs_diamond/core/usecase/usecase.dart';
import 'package:gs_diamond/core/error/failure.dart';
import 'package:gs_diamond/di/injection.dart';
import 'package:either_dart/src/either.dart';

class MobileUseCase implements UseCaseOneInput<User, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(User loginData) async {
    return await locator.get<AuthenticationRepository>().userMobile(loginData);
  }
}

class User {
  String mNumber;

  User({required this.mNumber});
}
