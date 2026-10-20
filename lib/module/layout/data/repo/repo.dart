import 'package:news/module/layout/data/data_source/local_data_source.dart';
import 'package:news/module/layout/data/data_source/remote_data_source.dart';
import 'package:news/module/layout/data/models/news_response.dart';
import 'package:news/module/layout/data/models/sources_response.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class Repo {
  Future<List<Articles>> getNews(String sourceId);

  Future<List<Sources>> getSource(String categoryId);
}

class RepoImp implements Repo {
  RemoteDataSource remoteDataSource = RemoteDataSourceImp();
  LocalDataSource localDataSource = LocalDataSourceImp();
  @override
  Future<List<Articles>> getNews(String sourceId) async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    try {
      if (isConnected) {
        var response = await remoteDataSource.getNews(sourceId);
        if (response.statusCode == 200) {
          await localDataSource.saveNews(response.data);
          var data = NewsResponse.fromJson(response.data);
          return data.articles ;
        } else {
          throw response.data['message'];
        }
      } else {
        var response = await localDataSource.getNews();
        var data = NewsResponse.fromJson(response);
        return data.articles;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Sources>> getSource(String categoryId) async {
    try {
      var response = await remoteDataSource.getSource(categoryId);
      if (response.statusCode == 200) {
        var data = SourcesResponse.fromJson(response.data);
        return data.sources!;
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
