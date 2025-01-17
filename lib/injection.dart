import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sales/constants/rest_api_urls.dart';
import 'package:sales/features/initialization/data/datasources/db_datasource.dart';
// import 'package:ht_sales/features/initialization/data/repositories/db_repository.dart';
// import 'package:ht_sales/features/initialization/domain/repositories/db_repository.dart';
// import 'package:ht_sales/features/initialization/domain/usecases/db_usecases.dart';




Dio dio =Dio(
    BaseOptions(
      baseUrl: RestApiUrls.baseUrl,
      receiveDataWhenStatusError: true,
      headers: {
        'content-type' : 'application/json',
        'accept': 'application/json'
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    )
);
final sl = GetIt.I;  // Service location

Future<void> init() async{

  // Factory - each time a new instance of the Class

  // Presentation layer

  // Domain layer
  // sl.registerFactory(
  //         () => DBUseCases(dbRepository: sl()));

  // Data layer

  sl.registerFactory<DbDatasource>(
          () => DbDatasourceImpl(
          dio: Dio(
              BaseOptions(
                baseUrl: RestApiUrls.baseUrl,
                receiveDataWhenStatusError: true,
                headers: {
                  'content-type' : 'application/json',
                },
                connectTimeout: const Duration(seconds: 60),
                receiveTimeout: const Duration(seconds: 60),
              )
          ))
  );

}
