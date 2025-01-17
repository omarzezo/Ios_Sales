import 'package:dartz/dartz.dart';
import 'package:sales/core/failures/failures.dart';
import 'package:sales/features/initialization/data/models/db_response_model.dart';


abstract class DbRepository{
  Future<Either<Failure, AllDbResponseModel>> getAllDb();
}