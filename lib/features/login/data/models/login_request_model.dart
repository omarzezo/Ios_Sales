class LoginRequestModel {
  int? connectionId;
  bool? isManager;
  String? userName;
  String? password;
  int? branchId;
  int? companyNumber;

  LoginRequestModel(
      {this.connectionId,
        this.isManager,
        this.userName,
        this.password,
        this.branchId,
        this.companyNumber});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    connectionId = json['connectionId'];
    isManager = json['isManager'];
    userName = json['userName'];
    password = json['password'];
    branchId = json['branchId'];
    companyNumber = json['companyNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connectionId'] = this.connectionId;
    data['isManager'] = this.isManager;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['branchId'] = this.branchId;
    data['companyNumber'] = this.companyNumber;
    return data;
  }
}