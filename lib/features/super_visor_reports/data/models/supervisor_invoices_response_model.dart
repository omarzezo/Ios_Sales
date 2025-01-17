class SupervisorInvoicesRequestModel {
  int? connectionId;
  String? fromDate;
  String? toDate;
  String? searchKey;
  int? tafsily;
  int? boxid;
  bool? all;
  int? userID;
  int? prounchID;
  int? mandopID;

  SupervisorInvoicesRequestModel(
      {this.connectionId,
        this.fromDate,
        this.toDate,
        this.tafsily,
        this.searchKey,
        this.boxid,
        this.all,
        this.userID,
        this.prounchID,
        this.mandopID});

  SupervisorInvoicesRequestModel.fromJson(Map<String, dynamic> json) {
    connectionId = json['connectionId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    tafsily = json['tafsily'];
    boxid = json['boxid'];
    all = json['all'];
    searchKey = json['searchKey'];
    userID = json['userID'];
    prounchID = json['prounchID'];
    mandopID = json['mandopID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connectionId'] = this.connectionId;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['tafsily'] = this.tafsily;
    data['boxid'] = this.boxid;
    data['searchKey'] = this.searchKey;
    data['all'] = this.all;
    data['userID'] = this.userID;
    data['prounchID'] = this.prounchID;
    data['mandopID'] = this.mandopID;
    return data;
  }
}

class SupervisorInvoicesResponseModel {
  int? code;
  String? message;
  List<SupervisorData>? data;

  SupervisorInvoicesResponseModel({this.code, this.message, this.data});

  SupervisorInvoicesResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SupervisorData>[];
      json['data'].forEach((v) {
        data!.add(new SupervisorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupervisorData {
  String? mandopName;
  String? searchKey;
  int? mandopID;
  int? invCount;
  dynamic aTotal;
  dynamic omola;
  dynamic descountValue;
  dynamic net;
  dynamic invCountReturn;
  dynamic aTotalRturn;
  dynamic netAfterOmola;
  dynamic connectionId;

  SupervisorData(
      {this.mandopName,
        this.mandopID,
        this.searchKey,
        this.invCount,
        this.aTotal,
        this.omola,
        this.descountValue,
        this.net,
        this.invCountReturn,
        this.aTotalRturn,
        this.netAfterOmola,
        this.connectionId});

  SupervisorData.fromJson(Map<String, dynamic> json) {
    mandopName = json['mandop_Name'];
    mandopID = json['mandopID'];
    invCount = json['invCount'];
    aTotal = json['aTotal'];
    omola = json['omola'];
    descountValue = json['descountValue'];
    net = json['net'];
    invCountReturn = json['invCountReturn'];
    aTotalRturn = json['aTotalRturn'];
    netAfterOmola = json['netAfterOmola'];
    connectionId = json['connectionId'];
    searchKey = json['searchKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mandop_Name'] = this.mandopName;
    data['mandopID'] = this.mandopID;
    data['searchKey'] = this.searchKey;
    data['invCount'] = this.invCount;
    data['aTotal'] = this.aTotal;
    data['omola'] = this.omola;
    data['descountValue'] = this.descountValue;
    data['net'] = this.net;
    data['invCountReturn'] = this.invCountReturn;
    data['aTotalRturn'] = this.aTotalRturn;
    data['netAfterOmola'] = this.netAfterOmola;
    data['connectionId'] = this.connectionId;
    return data;
  }
}