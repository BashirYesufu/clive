import 'package:clive/networking/models/reponse/base_api_response.dart';
import 'package:dio/dio.dart';
import '../../app.dart';

enum RequestType {
  get, post, put, delete, patch;
}

class NetworkManager {

  Dio _client = Dio()..interceptors.add(App.inspector.getDioRequestInterceptor());

  BaseApiResponse? baseApiResponse;

  Future<BaseApiResponse?> makeRequest({required RequestType requestType, bool useNestedParam = true, required String url, Map<String, dynamic>? query, Map<String, dynamic>? body}) async {
    switch (requestType) {
      case RequestType.get: {
        var response = await _client.get(url);
        print(response);
        baseApiResponse = BaseApiResponse.fromJson(response, useNestedParam: useNestedParam);
        break;
      }
      default: break;
    }
    return baseApiResponse;
  }


}