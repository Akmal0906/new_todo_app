import 'package:dio/dio.dart';
import 'package:todo_app/utilis/all_urls.dart';

class DioInterceptor extends Interceptor {
  Dio dio = Dio(BaseOptions(baseUrl: AllUrls.baseUrl));
@override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "Content-Type": "application/json",
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String? token=await refreshToken();
      try {
        handler.resolve(await _retry(err.requestOptions,token??'Error'));
      } on DioException catch (e) {
        handler.next(e);
      }
      return;
    }
    handler.next(err);
  }

  Future<String?> refreshToken() async {
    final data = {
      "username": "admin",
      "email": "admin@gmail.com",
      "password": "admin"
    };
    var response = await dio.post(
      '${AllUrls.baseUrl}${AllUrls.authLogin}',
      data: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('refresh Token if 1 working ${response.data['access']}');
      return response.data['access'];
    } else {
      print('refresh Token else working');

      return null;
    }
  }

  Future<Response<dynamic>> _retry(
      RequestOptions requestOptions, String token) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
