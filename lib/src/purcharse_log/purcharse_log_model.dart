class PurcharseLog {
  String clubName;
  String goodsName;
  String goodsPictureUrl;
  int id;
  int price;
  int purchaseAmount;
  int purchaseCount;
  String purchaseTime;
  String remark;
  int skuId;
  String skuName;
  Status status;

  PurcharseLog(
      {this.clubName,
      this.goodsName,
      this.goodsPictureUrl,
      this.id,
      this.price,
      this.purchaseAmount,
      this.purchaseCount,
      this.purchaseTime,
      this.remark,
      this.skuId,
      this.skuName,
      this.status});

  PurcharseLog.fromJson(Map<String, dynamic> json) {
    clubName = json['clubName'];
    goodsName = json['goodsName'];
    goodsPictureUrl = json['goodsPictureUrl'];
    id = json['id'];
    price = json['price'];
    purchaseAmount = json['purchaseAmount'];
    purchaseCount = json['purchaseCount'];
    purchaseTime = json['purchaseTime'];
    remark = json['remark'];
    skuId = json['skuId'];
    skuName = json['skuName'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clubName'] = this.clubName;
    data['goodsName'] = this.goodsName;
    data['goodsPictureUrl'] = this.goodsPictureUrl;
    data['id'] = this.id;
    data['price'] = this.price;
    data['purchaseAmount'] = this.purchaseAmount;
    data['purchaseCount'] = this.purchaseCount;
    data['purchaseTime'] = this.purchaseTime;
    data['remark'] = this.remark;
    data['skuId'] = this.skuId;
    data['skuName'] = this.skuName;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
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
