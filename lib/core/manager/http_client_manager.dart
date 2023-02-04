import 'package:gs_diamond/core/constants/app_network_constants.dart';
import 'package:gs_diamond/core/constants/http_constants.dart';
import 'package:gs_diamond/core/constants/app_constant.dart';
import 'package:gs_diamond/core/model/common_response.dart';
import 'package:gs_diamond/core/model/error_model.dart';
import 'package:gs_diamond/core/error/exceptions.dart';
import 'package:meta/meta.dart' show required;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

abstract class HttpClientManager {
  Future<dynamic> request({
    @required Uri url,
    @required String method,
    Map body,
    Map<String, String> headers,
    String? screenName,
  });
}

class HttpClientManagerImpl implements HttpClientManager {
  final http.Client initClient;
  http.StreamedResponse? streamedResponse;

  HttpClientManagerImpl({required this.initClient});

  Future<dynamic> request(
      {@required Uri? url,
      @required String? method,
      Map? body,
      String? screenName,
      Map<String, String>? headers}) async {
    final defaultHeaders = headers ??
        {'content-type': 'application/json', 'accept': 'application/json'};
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = http.Response('', 500);
    Future<http.Response>? futureResponse;

    print("url: $url");
    print("method: $method");
    print("body: $body");
    print("headers: $headers");

    try {
      switch (method) {
        case AppNetworkConstants.get:
          futureResponse = initClient.get(url!, headers: defaultHeaders);
          break;
        case AppNetworkConstants.post:
          futureResponse = initClient
              .post(url!, headers: defaultHeaders, body: jsonBody)
              .timeout(
                 const Duration(seconds: AppConstants.DEFAULT_HTTP_TIMEOUT),
                onTimeout: onTimeOut,
              );
          break;
        case AppNetworkConstants.put:
          futureResponse = initClient
              .put(url!, headers: defaultHeaders, body: jsonBody)
              .timeout(
                const Duration(seconds: AppConstants.DEFAULT_HTTP_TIMEOUT),
                onTimeout: onTimeOut,
              );
          break;
        case AppNetworkConstants.delete:
          futureResponse =
              initClient.delete(url!, headers: defaultHeaders).timeout(
                     const Duration(seconds: AppConstants.DEFAULT_HTTP_TIMEOUT),
                    onTimeout: onTimeOut,
                  );
          break;
        case AppNetworkConstants.image:
          http.MultipartRequest request = http.MultipartRequest("POST", url!);
          http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
              'challan_photo', body?['challan_photo']);
          request.files.add(multipartFile);
          request.fields['qnt'] = body?['qnt'];
          request.fields['fuelopp_id'] = body?['fuelopp_id'];
          request.fields['vehicle_number'] = body?['vehicle_number'];
          print("request: ${request.fields}");
          request.headers.addAll(defaultHeaders);
          streamedResponse = await request.send();
          streamedResponse?.stream.transform(utf8.decoder).listen((value) {
            print("value: $value");
          });
          break;
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 30));
      }
    } catch (error) {
      throw ServerException();
    }
    return _handleResponse(response, screenName);
  }

  dynamic _handleResponse(http.Response response, screenName) {
    print("responseBody: ${response.body}");
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty
            ? CommonResponse(code: response.statusCode)
            : jsonDecode(response.body);
      case 201:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 204:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 207:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 400:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 401:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 403:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 404:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 409:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 500:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      case 503:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
      default:
        throw ServerException(
            ErrorModel.fromJson(jsonDecode(response.body)).errors);
    }
  }

  FutureOr<http.Response> onTimeOut() async {
    throw CommonResponse(
      code: HTTP_GATEWAY_TIMEOUT,
    );
  }
}
