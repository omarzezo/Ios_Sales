import 'package:dio/dio.dart';
import 'package:sales/core/utils/globals.dart';
import '../../../../core/utils/exception.dart';
import '../models/db_response_model.dart';


abstract class DbDatasource{
  Future<AllDbResponseModel> getDbApi();
  Future<AllDbResponseModelData> getInfoForDbApi({required int companyCode});
}

class DbDatasourceImpl implements DbDatasource{
  final Dio dio;

  DbDatasourceImpl({required this.dio});

  @override
  Future<AllDbResponseModel> getDbApi() async{
    try {
      showLoader();
      Response response;
      response = await dio.get('ChooseMyDB/Get?AppCode=1');
      // print('response>>'+response.data.toString());
      dismissLoader();
      if(response.statusCode != 200){
        throw ExceptionUtils.dioStatusCodeErrorHandle(response.statusCode);
      }else{
        return AllDbResponseModel.fromJson(response.data);
      }
    } on DioError catch (e, stacktrace) {
      // print('eeeee>>'+e.toString());
      throw ExceptionUtils.dioErrorHandle(e, stacktrace);
    }
  }

  @override
  Future<AllDbResponseModelData> getInfoForDbApi({required int companyCode}) async {
    try {
      showLoader();
      Response response;
      response = await dio.get('ChooseMyDB/GetDB_byCompanyNumber?CompanyNumber=$companyCode');
      dismissLoader();
      // print(response.data);
      if(response.statusCode != 200){
        throw ExceptionUtils.dioStatusCodeErrorHandle(response.statusCode);
      }else{
        return AllDbResponseModelData.fromJson(response.data['data']);
      }
    } on DioError catch (e, stacktrace) {
      throw ExceptionUtils.dioErrorHandle(e, stacktrace);
    }
  }
}