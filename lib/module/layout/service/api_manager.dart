import 'package:news/core/services/api_service.dart';

class ApiManager {
  Future<void> getNews() async {
    var response = await ApiService.dio.get('everything?q=bitcoin');
  }
}
