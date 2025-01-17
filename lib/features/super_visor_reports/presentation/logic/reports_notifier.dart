import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/features/super_visor_reports/data/datasources/reports_datasource.dart';
import 'package:sales/features/super_visor_reports/data/models/supervisor_invoices_response_model.dart';
import 'package:sales/injection.dart';


final reportsProvider=Provider<ReportsDatasourceImpl>((ref)=>ReportsDatasourceImpl(dio:dio));

final reportsDataProvider = FutureProvider.family<SupervisorInvoicesResponseModel,SupervisorInvoicesRequestModel>((ref,model) async {
  return ref.watch(reportsProvider).getSupervisorInvoices(model: model);
});
