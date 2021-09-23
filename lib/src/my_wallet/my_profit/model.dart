class ProfitVo {
  String bizId;
  String bizParam;
  String bizType;
  String createTime;
  bool hasFrozen;
  String id;
  String modifyTime;
  double profitAmount;
  String profitTime;
  String remark;
  String userId;
  String walletId;

  ProfitVo(
      {this.bizId,
      this.bizParam,
      this.bizType,
      this.createTime,
      this.hasFrozen,
      this.id,
      this.modifyTime,
      this.profitAmount,
      this.profitTime,
      this.remark,
      this.userId,
      this.walletId});

  ProfitVo.fromJson(Map<String, dynamic> json) {
    bizId = json['bizId'];
    bizParam = json['bizParam'];
    bizType = json['bizType'];
    createTime = json['createTime'];
    hasFrozen = json['hasFrozen'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    profitAmount = json['profitAmount'];
    profitTime = json['profitTime'];
    remark = json['remark'];
    userId = json['userId'];
    walletId = json['walletId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bizId'] = this.bizId;
    data['bizParam'] = this.bizParam;
    data['bizType'] = this.bizType;
    data['createTime'] = this.createTime;
    data['hasFrozen'] = this.hasFrozen;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['profitAmount'] = this.profitAmount;
    data['profitTime'] = this.profitTime;
    data['remark'] = this.remark;
    data['userId'] = this.userId;
    data['walletId'] = this.walletId;
    return data;
  }
}
