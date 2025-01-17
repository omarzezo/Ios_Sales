import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/features/login/data/models/login_request_model.dart';
import '../../../../core/utils/exception.dart';
import '../models/login_response_model.dart';


abstract class LoginDatasource{
  Future<LoginResponseModel> login({required LoginRequestModel model});
}

class LoginDatasourceImpl implements LoginDatasource{
  final Dio dio;

  LoginDatasourceImpl({required this.dio});

  @override
  Future<LoginResponseModel> login({required LoginRequestModel model}) async {
    try {
      // print('model>>'+jsonEncode(model));
      showLoader();
      Response response;
      response = await dio.post('User/Login',data:model.toJson());
      dismissLoader();
      // print('model>>'+response.data.toString());
      if(response.statusCode != 200){
        throw ExceptionUtils.dioStatusCodeErrorHandle(response.statusCode);
      }else{
        // print('model>>${LoginResponseModel.fromJson(response.data).data!.empName}');
        return LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e, stacktrace) {
      throw ExceptionUtils.dioErrorHandle(e, stacktrace);
    }
  }
}