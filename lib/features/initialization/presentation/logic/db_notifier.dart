import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/features/initialization/data/datasources/db_datasource.dart';
import 'package:sales/features/initialization/data/models/db_response_model.dart';
import 'package:sales/injection.dart';


final dbProvider=Provider<DbDatasourceImpl>((ref)=>DbDatasourceImpl(dio:dio));

final dbDataProvider = FutureProvider<AllDbResponseModel>((ref) async {
  return ref.watch(dbProvider).getDbApi();
});

final dbInfDataProvider = FutureProvider.family<AllDbResponseModelData,int>((ref,companyCode) async {
  return await ref.watch(dbProvider).getInfoForDbApi(companyCode: companyCode);
});

