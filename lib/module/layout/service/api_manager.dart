import 'package:news/core/services/api_service.dart';
import 'package:news/module/layout/models/news_response.dart';
import 'package:news/module/layout/models/sources_response.dart';

class ApiManager {
  // static Future<List<Articles>> getNews() async {
  //   try {
  //     var response = await ApiService.dio.get('everything?q=bitcoin');
  //     if (response.statusCode == 200) {
  //       var data = NewsResponse.fromJson(response.data);
  //       return data.articles;
  //     } else {
  //       throw response.data['message'];
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<List<Articles>> getNews(String sourceId) async {
    try {
      var response = await ApiService.dio.get('everything?sources=$sourceId');
      if (response.statusCode == 200) {
        var data = NewsResponse.fromJson(response.data);
        return data.articles;
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Sources>?> getSource(String categoryId) async {
    try {
      var response = await ApiService.dio.get(
        'top-headlines/sources',
        queryParameters: {'category': categoryId},
      );
      if (response.statusCode == 200) {
        var data = SourcesResponse.fromJson(response.data);
        return data.sources;
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
