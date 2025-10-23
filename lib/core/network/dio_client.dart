import 'package:dio/dio.dart';
import 'package:pokemon_test/core/constants/api_constants.dart';
import 'package:pokemon_test/core/error/exceptions.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<Response> get(String path) async {
    try {
      return await dio.get(path);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Mohon maaf jaringan tidak tersedia');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
