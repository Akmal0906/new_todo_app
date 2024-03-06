import 'package:dio/dio.dart';
import 'package:todo_app/data/network/interaptor.dart';
import 'package:todo_app/domain/models/categories_model/category_model.dart';

import '../../domain/models/items_model/item_model.dart';
import '../../utilis/all_urls.dart';
import 'dart:async';

class FetchData {
  // Future<List<ItemModel>?> getAllTask(String token) async {
  //   final dio = Dio();
  //   try {
  //     print('working 1');
  //
  //     final response = await dio.get('${AllUrls.baseUrl}${AllUrls.apiTodo}',
  //         options: Options(
  //             receiveTimeout: Duration(seconds: 3),
  //             sendTimeout: Duration(seconds: 3),
  //             headers: {'Authorization': 'Bearer $token'}));
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('*****************************8');
  //       print('GETaLLtASK ${response.data}');
  //       print('*****************************8');
  //     } else if (response.statusCode == 401) {
  //       print('working 401');
  //
  //       getAllTask(await refreshToken(dio));
  //     }
  //   } on DioException catch (e) {
  //     if(e.response?.statusCode==401){
  //       getAllTask(await refreshToken(dio));
  //
  //     }
  //     print('catch working');
  //   }
  //   return null;
  // }

  // Future<List<ItemModel>?> getAllTask(String token) async {
  //   final dio = Dio();
  //   try {
  //     print('working 1');
  //     dio.interceptors.add(
  //       InterceptorsWrapper(
  //         onRequest:
  //             (RequestOptions options, RequestInterceptorHandler handler) {
  //           return handler.next(options);
  //         },
  //         onResponse:
  //             (Response response, ResponseInterceptorHandler handler) async {
  //           if (response.statusCode == 401) {
  //             print('Interceptor onResponse');
  //             final res = await refreshToken(Dio());
  //           }
  //
  //           return handler.next(response);
  //         },
  //         onError: (DioException error, ErrorInterceptorHandler handler) async {
  //           if (error.response?.statusCode == 401) {
  //             print('Interceptor working');
  //             final res = await refreshToken(Dio());
  //             getAllTask(res);
  //           }
  //
  //           return handler.next(error);
  //         },
  //       ),
  //     );
  //   } on DioException catch (e) {
  //     return null;
  //   }
  //   return null;
  // }

  Future<List<ItemModel>?> getAllTask1(String token) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());

    try {
      final response = await dio.get('${AllUrls.baseUrl}${AllUrls.apiTodo}',
          options: Options(
              receiveTimeout: Duration(seconds: 3),
              sendTimeout: Duration(seconds: 3),
              headers: {'Authorization': 'Bearer das'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List jsonResponse = await response.data;

        return jsonResponse.map((e) => ItemModel.fromJson(e)).toList();
      } else if (response.statusCode == 401) {}
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<List<CategoryModel>?> getAllCategory(String token) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());

    try {
      final response = await dio.get('${AllUrls.baseUrl}${AllUrls.apiCategory}',
          options: Options(
              receiveTimeout: Duration(seconds: 3),
              sendTimeout: Duration(seconds: 3),
              headers: {'Authorization': 'Bearer das'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List jsonResponse = await response.data;

        return jsonResponse.map((e) => CategoryModel.fromJson(e)).toList();
      } else if (response.statusCode == 401) {}
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<CategoryModel?> getCurrentCategory(String id) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());

    try {
      final response = await dio.get(
          '${AllUrls.baseUrl}${AllUrls.apiCategory}$id',
          options: Options(
              receiveTimeout: Duration(seconds: 5),
              sendTimeout: Duration(seconds: 5),
              headers: {'Authorization': 'Bearer das'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = await response.data;
        print('getAllTask1 ${response.data}');
        return CategoryModel.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {}
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<String?> postToDo(
      String startTime, String endTime, String clockTime, String task) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    final data = {
      "context": task,
      "alert": '$clockTime.000000',
      "start_date": startTime,
      "end_date": "2027-09-04",
      "category": 1
    };

    try {
      final response = await dio.post(
          '${AllUrls.baseUrl}${AllUrls.postTaskUrl}',
          data: data,
          options: Options(
              receiveTimeout: const Duration(seconds: 5),
              sendTimeout: const Duration(seconds: 5),
              headers: {'Authorization': 'Bearer das'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Successed added';
      } else if (response.statusCode == 401) {}
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<String?> deleteIdTask(int id) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());

    try {
      final response = await dio.delete(
          '${AllUrls.baseUrl}${AllUrls.apiTodo}$id/'.trim(),
          options: Options(
              receiveTimeout: Duration(seconds: 5),
              sendTimeout: Duration(seconds: 5),
              headers: {'Authorization': 'Bearer das'}));
      if (response.statusCode == 204) {
        return 'Successfully deleted task';
      } else if (response.statusCode == 401) {}
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<String?> updateIdTask(ItemModel itemModel) async {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    final data = {
      "context": itemModel.context,
      "alert": '${itemModel.alert}.000000',
      "start_date": itemModel.startDate,
      "end_date": itemModel.endDate,
      "category": 1
    };
    try {
      final response = await dio.put(
          '${AllUrls.baseUrl}${AllUrls.apiTodo}${itemModel.id}/'.trim(),
          data: data,
          options: Options(
              receiveTimeout: Duration(seconds: 5),
              sendTimeout: Duration(seconds: 5),
              headers: {'Authorization': 'Bearer das'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Successfully Updated task';
      } else if (response.statusCode == 400) {
        return 'Bad Request';
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<String> refreshToken(Dio dio) async {
    final data = {
      "username": "admin",
      "email": "admin@gmail.com",
      "password": "admin"
    };
    final res =
        await dio.post('${AllUrls.baseUrl}${AllUrls.authLogin}', data: data);

    return res.data['access'];
  }
}
