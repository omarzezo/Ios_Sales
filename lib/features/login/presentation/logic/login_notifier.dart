import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/login/data/datasources/login_datasource.dart';
import 'package:sales/features/login/data/models/login_request_model.dart';
import 'package:sales/features/login/data/models/login_response_model.dart';
import 'package:sales/injection.dart';

final loginProvider=Provider<LoginDatasourceImpl>((ref)=>LoginDatasourceImpl(dio:dio));

final loginDataProvider = FutureProvider.family<LoginResponseModel,LoginRequestModel>((ref,model) async {
  return ref.watch(loginProvider).login(model: model);
});

final rememberMeProvider=StateProvider<bool>((ref)=>SharedPrefHelper.sp.getBool('rememberMe')??false);
