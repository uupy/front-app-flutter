class WalletCardVo {
  String cardNumber;
  String cardType;
  String createTime;
  String id;
  String modifyTime;
  String openingBank;
  String openingSubBank;
  String ownerIdCardNo;
  String ownerName;
  String ownerPhoneNumber;
  Status status;
  String userId;
  String walletId;

  WalletCardVo(
      {this.cardNumber,
      this.cardType,
      this.createTime,
      this.id,
      this.modifyTime,
      this.openingBank,
      this.openingSubBank,
      this.ownerIdCardNo,
      this.ownerName,
      this.ownerPhoneNumber,
      this.status,
      this.userId,
      this.walletId});

  WalletCardVo.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    createTime = json['createTime'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    openingBank = json['openingBank'];
    openingSubBank = json['openingSubBank'];
    ownerIdCardNo = json['ownerIdCardNo'];
    ownerName = json['ownerName'];
    ownerPhoneNumber = json['ownerPhoneNumber'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    userId = json['userId'];
    walletId = json['walletId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNumber'] = this.cardNumber;
    data['cardType'] = this.cardType;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['openingBank'] = this.openingBank;
    data['openingSubBank'] = this.openingSubBank;
    data['ownerIdCardNo'] = this.ownerIdCardNo;
    data['ownerName'] = this.ownerName;
    data['ownerPhoneNumber'] = this.ownerPhoneNumber;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['userId'] = this.userId;
    data['walletId'] = this.walletId;
    return data;
  }
}

class Status {
  String desc;
  int value;

  Status({this.desc, this.value});

  Status.fromJson(Map<String, dynamic> json) {
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
