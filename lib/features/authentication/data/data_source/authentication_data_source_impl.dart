import 'package:gs_diamond/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:gs_diamond/core/constants/app_network_constants.dart';
import 'package:gs_diamond/core/manager/http_client_manager.dart';
import 'package:gs_diamond/core/error/exceptions.dart';
import 'package:gs_diamond/di/injection.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  @override
  Future authentication(Uri url, Map inputData) async {
    try {
      final setAcceptanceResponse = await locator
          .get<HttpClientManager>()
          .request(url: url, method: AppNetworkConstants.post, body: inputData);
      return setAcceptanceResponse;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
