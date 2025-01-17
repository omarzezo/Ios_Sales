import 'package:dio/dio.dart';

class RestApiUrls{
  RestApiUrls._();

  // static const String baseUrl = 'http://144.91.81.59:92/api/';
  // static const String baseUrl = 'http://farid2025-001-site1.htempurl.com/api/';
  static  String baseUrl = 'http://sqlfalcon.ddns.net:50/api/';
  // static  String baseUrl = '';
  // static const String randomJoke = 'https://api.chucknorris.io/jokes/random';

  static BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
    headers: {
      'content-type' : 'application/json',
    },
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  static Options options = Options(
    headers: {
      'content-type' : 'application/json',
    },
    receiveTimeout: const Duration(seconds: 60),
  );

}