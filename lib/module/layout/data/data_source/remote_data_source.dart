import 'package:dio/dio.dart';
import 'package:news/core/services/api_service.dart';

abstract class RemoteDataSource {
  Future<Response> getNews(String sourceId);

  Future<Response> getSource(String categoryId);
}

class RemoteDataSourceImp implements RemoteDataSource {
  @override
  Future<Response<dynamic>> getNews(String sourceId) {
    return ApiService.dio.get('everything?sources=$sourceId');
  }

  @override
  Future<Response<dynamic>> getSource(String categoryId) {
    return ApiService.dio.get(
      'top-headlines/sources',
      queryParameters: {'category': categoryId},
    );
  }
}
