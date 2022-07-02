import 'package:dio/dio.dart';
import 'package:mobile_app/shared/bloc/end_points.dart';
import 'package:mobile_app/shared/components/components.dart';

class DioHelper {
  static late Dio dio;
  static const String accessType = 'Bearer ';

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://grad-project-fy-1.herokuapp.com/api/v1',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "authorization": '$accessType$token',
    };
    return dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      "authorization": "$accessType$token",
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static var res;

  static Future<Response> postbody({
    required Map<String, dynamic> body,
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "authorization": "$accessType$token",
    };
    try {
      FormData formData = FormData.fromMap(body);
      res = await dio.post(
        url,
        data: formData,
        queryParameters: query,
      );

      print('this is postbody res $res');
      return res?.data;
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  static Future<Response> uploadImage() async {
    dio.options.headers = {
      "authorization": '$accessType$token',
    };
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(
        image!.path,
      )
    });
    return dio.post(
      UPLOADPROFILE,
      data: formData,
    );
  }
}

// static Future<List<GetPatientModel>> fetchUsers() async {
//   try {
//     Response response = await Dio().get('');
//     if (response.statusCode == 200) {
//       var getUsersData = response.data as List;
//       var listUsers =
//           getUsersData.map((i) => GetPatientModel.fromJson(i)).toList();
//       return listUsers;
//     } else {
//       throw Exception('Failed to load users');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
// }
