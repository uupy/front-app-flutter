class WithdrawRecordVo {
  double adjustFee;
  double amount;
  String applyRemark;
  String auditOperator;
  String auditRemark;
  AuditStatus auditStatus;
  String auditTime;
  String cardNumber;
  String cardType;
  String createTime;
  String id;
  String modifyTime;
  String openingBank;
  String openingSubBank;
  String ownerName;
  double serviceChargeFee;
  String userId;
  String walletId;

  WithdrawRecordVo(
      {this.adjustFee,
      this.amount,
      this.applyRemark,
      this.auditOperator,
      this.auditRemark,
      this.auditStatus,
      this.auditTime,
      this.cardNumber,
      this.cardType,
      this.createTime,
      this.id,
      this.modifyTime,
      this.openingBank,
      this.openingSubBank,
      this.ownerName,
      this.serviceChargeFee,
      this.userId,
      this.walletId});

  WithdrawRecordVo.fromJson(Map<String, dynamic> json) {
    adjustFee = json['adjustFee'];
    amount = json['amount'];
    applyRemark = json['applyRemark'];
    auditOperator = json['auditOperator'];
    auditRemark = json['auditRemark'];
    auditStatus = json['auditStatus'] != null
        ? new AuditStatus.fromJson(json['auditStatus'])
        : null;
    auditTime = json['auditTime'];
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    createTime = json['createTime'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    openingBank = json['openingBank'];
    openingSubBank = json['openingSubBank'];
    ownerName = json['ownerName'];
    serviceChargeFee = json['serviceChargeFee'];
    userId = json['userId'];
    walletId = json['walletId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adjustFee'] = this.adjustFee;
    data['amount'] = this.amount;
    data['applyRemark'] = this.applyRemark;
    data['auditOperator'] = this.auditOperator;
    data['auditRemark'] = this.auditRemark;
    if (this.auditStatus != null) {
      data['auditStatus'] = this.auditStatus.toJson();
    }
    data['auditTime'] = this.auditTime;
    data['cardNumber'] = this.cardNumber;
    data['cardType'] = this.cardType;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['openingBank'] = this.openingBank;
    data['openingSubBank'] = this.openingSubBank;
    data['ownerName'] = this.ownerName;
    data['serviceChargeFee'] = this.serviceChargeFee;
    data['userId'] = this.userId;
    data['walletId'] = this.walletId;
    return data;
  }
}

class AuditStatus {
  String desc;
  int value;

  AuditStatus({this.desc, this.value});

  AuditStatus.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['value'] = this.value;
    return data;
  }
}
