import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news/core/services/api_service.dart';

abstract class RemoteDataSource {
  Future<Response> getNews(String sourceId);

  Future<Response> getSource(String categoryId);
}

@Injectable(as: RemoteDataSource)
class RemoteDataSourceImp implements RemoteDataSource {
  ApiService apiService;
  RemoteDataSourceImp(this.apiService);
  @override
  Future<Response<dynamic>> getNews(String sourceId) {
    return apiService.dio.get('everything?sources=$sourceId');
  }

  @override
  Future<Response<dynamic>> getSource(String categoryId) {
    return apiService.dio.get(
      'top-headlines/sources',
      queryParameters: {'category': categoryId},
    );
  }
}
