import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AllDbResponseModel extends Equatable {
  const AllDbResponseModel({
     this.code,
     this.message,
     this.data,
  });

  final int? code;
  final String? message;
  final List<AllDbResponseModelData>? data;

  AllDbResponseModel copyWith({
    int? code,
    String? message,
    List<AllDbResponseModelData>? data,
  }) {
    return AllDbResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory AllDbResponseModel.fromJson(Map<String, dynamic> json){
    return AllDbResponseModel(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AllDbResponseModelData>.from(json["data"]!.map((x) => AllDbResponseModelData.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
    code, message, data, ];
}

class AllDbResponseModelData extends Equatable {
  AllDbResponseModelData({
    required this.id,
    required this.dbName,
    required this.title,
    required this.connectionString,
    required this.companyNumber,
    required this.activationCode,
    required this.appCode,
    required this.comPLogo,
    required this.hrAppColor,
    required this.comPName,
  });

  final int? id;
  final String? dbName;
  final String? title;
  final String? connectionString;
  final int? companyNumber;
  final int? activationCode;
  final int? appCode;
  final dynamic comPLogo;
  final dynamic hrAppColor;
  final dynamic comPName;

  AllDbResponseModelData copyWith({
    int? id,
    String? dbName,
    String? title,
    String? connectionString,
    int? companyNumber,
    int? activationCode,
    int? appCode,
    dynamic? comPLogo,
    dynamic? hrAppColor,
    dynamic? comPName,
  }) {
    return AllDbResponseModelData(
      id: id ?? this.id,
      dbName: dbName ?? this.dbName,
      title: title ?? this.title,
      connectionString: connectionString ?? this.connectionString,
      companyNumber: companyNumber ?? this.companyNumber,
      activationCode: activationCode ?? this.activationCode,
      appCode: appCode ?? this.appCode,
      comPLogo: comPLogo ?? this.comPLogo,
      hrAppColor: hrAppColor ?? this.hrAppColor,
      comPName: comPName ?? this.comPName,
    );
  }

  factory AllDbResponseModelData.fromJson(Map<String, dynamic> json){
    return AllDbResponseModelData(
      id: json["id"],
      dbName: json["dbName"],
      title: json["title"],
      connectionString: json["connectionString"],
      companyNumber: json["companyNumber"],
      activationCode: json["activationCode"],
      appCode: json["appCode"],
      comPLogo: json["comP_LOGO"],
      hrAppColor: json["hrAppColor"],
      comPName: json["comP_NAME"],
    );
  }

  @override
  List<Object?> get props => [
    id, dbName, title, connectionString, companyNumber, activationCode, appCode, comPLogo, hrAppColor, comPName, ];
}
