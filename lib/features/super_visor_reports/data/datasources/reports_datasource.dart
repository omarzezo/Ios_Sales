import 'package:dio/dio.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:sales/features/super_visor_reports/data/models/reports_response_model.dart';
import 'package:sales/features/super_visor_reports/data/models/supervisor_invoices_response_model.dart';
import '../../../../core/utils/exception.dart';


abstract class ReportsDatasource{
  Future<SupervisorInvoicesResponseModel> getSupervisorInvoices({required SupervisorInvoicesRequestModel model});
  Future<ReportResponseModel> getPdfReport({required SupervisorInvoicesRequestModel model});
}

class ReportsDatasourceImpl implements ReportsDatasource{
  final Dio dio;

  ReportsDatasourceImpl({required this.dio});

  @override
  Future<ReportResponseModel> getPdfReport({required SupervisorInvoicesRequestModel model})async {
    try {
      showLoader();
      Response response;
      response = await dio.post('Invoice/POS_DaylySale_Report',data:model.toJson());
      dismissLoader();
      if(response.statusCode != 200){
        throw ExceptionUtils.dioStatusCodeErrorHandle(response.statusCode);
      }else{
        return ReportResponseModel.fromJson(response.data);
      }
    } on DioException catch (e, stacktrace) {
      throw ExceptionUtils.dioErrorHandle(e, stacktrace);
    }
  }

  @override
  Future<SupervisorInvoicesResponseModel> getSupervisorInvoices({required SupervisorInvoicesRequestModel model})async{
    try {
      showLoader();
      Response response;
      response = await dio.post('Invoice/POS_DaylySale',data:model.toJson());
      dismissLoader();
      if(response.statusCode != 200){
        throw ExceptionUtils.dioStatusCodeErrorHandle(response.statusCode);
      }else{
        return SupervisorInvoicesResponseModel.fromJson(response.data);
      }
    } on DioException catch (e, stacktrace) {
      throw ExceptionUtils.dioErrorHandle(e, stacktrace);
    }
  }
}