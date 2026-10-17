import 'package:dio/dio.dart';

class ApiService {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      headers: {'X-Api-Key': '1adcee19e804418ab9b04db27c305ffc'},
    ),
  );
}
