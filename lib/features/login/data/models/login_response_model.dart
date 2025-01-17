class LoginResponseModel {
  int? code;
  String? message;
  Data? data;

  LoginResponseModel({this.code, this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? availableHolidays;
  bool? canReviewOthersHR;
  int? saudiaNationality;
  bool? isSaudi;
  String? mandopName;
  String? branchName;
  dynamic latitude;
  dynamic longitude;
  String? secName;
  int? secId;
  int? empCode;
  String? empName;
  String? secondName;
  String? empTel;
  String? empMob;
  String? empMail;
  String? empPic;
  String? comPLOGO;
  String? hrAppColor;
  int? jobid;
  int? departId;
  dynamic empState;
  dynamic jopEqama;
  dynamic iqamaID;
  String? empJopdate;
  String? empLworkEnddate;
  String? empJopdateTxt;
  dynamic empPirth;
  int? prounchID;
  dynamic purnshName;
  int? nationalityID;
  dynamic nationality;
  dynamic jobName;
  dynamic gender;
  dynamic companyName;
  dynamic vatno;
  dynamic vaTPercent;
  dynamic passportID;
  int? userID;
  bool? allowFullControl;
  bool? isManager;
  dynamic deviceToken;
  int? deviceType;
  dynamic mandopId;
  bool? isAdmin;
  dynamic appLastVersion;
  int? signedSettingcount;
  bool? managerCanAcceptRequests;
  bool? openVacation;

  Data(
      {this.availableHolidays,
        this.canReviewOthersHR,
        this.saudiaNationality,
        this.isSaudi,
        this.mandopName,
        this.branchName,
        this.latitude,
        this.longitude,
        this.secName,
        this.secId,
        this.empCode,
        this.empName,
        this.secondName,
        this.empTel,
        this.empMob,
        this.empMail,
        this.empPic,
        this.comPLOGO,
        this.hrAppColor,
        this.jobid,
        this.departId,
        this.empState,
        this.jopEqama,
        this.iqamaID,
        this.empJopdate,
        this.empLworkEnddate,
        this.empJopdateTxt,
        this.empPirth,
        this.prounchID,
        this.purnshName,
        this.nationalityID,
        this.nationality,
        this.jobName,
        this.gender,
        this.companyName,
        this.vatno,
        this.vaTPercent,
        this.passportID,
        this.userID,
        this.allowFullControl,
        this.isManager,
        this.deviceToken,
        this.deviceType,
        this.mandopId,
        this.isAdmin,
        this.appLastVersion,
        this.signedSettingcount,
        this.managerCanAcceptRequests,
        this.openVacation});

  Data.fromJson(Map<String, dynamic> json) {
    availableHolidays = json['availableHolidays'];
    canReviewOthersHR = json['canReviewOthers_HR'];
    saudiaNationality = json['saudiaNationality'];
    isSaudi = json['isSaudi'];
    mandopName = json['mandopName'];
    branchName = json['branchName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    secName = json['sec_name'];
    secId = json['sec_id'];
    empCode = json['emp_code'];
    empName = json['emp_name'];
    secondName = json['secondName'];
    empTel = json['emp_tel'];
    empMob = json['emp_mob'];
    empMail = json['emp_mail'];
    empPic = json['emp_pic'];
    comPLOGO = json['comP_LOGO'];
    hrAppColor = json['hrAppColor'];
    jobid = json['jobid'];
    departId = json['depart_id'];
    empState = json['empState'];
    jopEqama = json['jop_Eqama'];
    iqamaID = json['iqamaID'];
    empJopdate = json['emp_jopdate'];
    empLworkEnddate = json['emp_lwork_enddate'];
    empJopdateTxt = json['emp_jopdate_Txt'];
    empPirth = json['emp_pirth'];
    prounchID = json['prounchID'];
    purnshName = json['purnsh_name'];
    nationalityID = json['nationalityID'];
    nationality = json['nationality'];
    jobName = json['jobName'];
    gender = json['gender'];
    companyName = json['company_Name'];
    vatno = json['vatno'];
    vaTPercent = json['vaT_Percent'];
    passportID = json['passportID'];
    userID = json['userID'];
    allowFullControl = json['allowFullControl'];
    isManager = json['isManager'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
    mandopId = json['mandopId'];
    isAdmin = json['isAdmin'];
    appLastVersion = json['appLastVersion'];
    signedSettingcount = json['signedSettingcount'];
    managerCanAcceptRequests = json['managerCanAcceptRequests'];
    openVacation = json['open_Vacation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['availableHolidays'] = this.availableHolidays;
    data['canReviewOthers_HR'] = this.canReviewOthersHR;
    data['saudiaNationality'] = this.saudiaNationality;
    data['isSaudi'] = this.isSaudi;
    data['mandopName'] = this.mandopName;
    data['branchName'] = this.branchName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['sec_name'] = this.secName;
    data['sec_id'] = this.secId;
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['secondName'] = this.secondName;
    data['emp_tel'] = this.empTel;
    data['emp_mob'] = this.empMob;
    data['emp_mail'] = this.empMail;
    data['emp_pic'] = this.empPic;
    data['comP_LOGO'] = this.comPLOGO;
    data['hrAppColor'] = this.hrAppColor;
    data['jobid'] = this.jobid;
    data['depart_id'] = this.departId;
    data['empState'] = this.empState;
    data['jop_Eqama'] = this.jopEqama;
    data['iqamaID'] = this.iqamaID;
    data['emp_jopdate'] = this.empJopdate;
    data['emp_lwork_enddate'] = this.empLworkEnddate;
    data['emp_jopdate_Txt'] = this.empJopdateTxt;
    data['emp_pirth'] = this.empPirth;
    data['prounchID'] = this.prounchID;
    data['purnsh_name'] = this.purnshName;
    data['nationalityID'] = this.nationalityID;
    data['nationality'] = this.nationality;
    data['jobName'] = this.jobName;
    data['gender'] = this.gender;
    data['company_Name'] = this.companyName;
    data['vatno'] = this.vatno;
    data['vaT_Percent'] = this.vaTPercent;
    data['passportID'] = this.passportID;
    data['userID'] = this.userID;
    data['allowFullControl'] = this.allowFullControl;
    data['isManager'] = this.isManager;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    data['mandopId'] = this.mandopId;
    data['isAdmin'] = this.isAdmin;
    data['appLastVersion'] = this.appLastVersion;
    data['signedSettingcount'] = this.signedSettingcount;
    data['managerCanAcceptRequests'] = this.managerCanAcceptRequests;
    data['open_Vacation'] = this.openVacation;
    return data;
  }
}