class StockLog {
  String adjustCount;
  String goodsName;
  String goodsPictureUrl;
  String remark;
  String skuId;
  String skuName;

  StockLog(
      {this.adjustCount,
      this.goodsName,
      this.goodsPictureUrl,
      this.remark,
      this.skuId,
      this.skuName});

  StockLog.fromJson(Map<String, dynamic> json) {
    adjustCount = json['adjustCount'];
    goodsName = json['goodsName'];
    goodsPictureUrl = json['goodsPictureUrl'];
    remark = json['remark'];
    skuId = json['skuId'];
    skuName = json['skuName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adjustCount'] = this.adjustCount;
    data['goodsName'] = this.goodsName;
    data['goodsPictureUrl'] = this.goodsPictureUrl;
    data['remark'] = this.remark;
    data['skuId'] = this.skuId;
    data['skuName'] = this.skuName;
    return data;
  }
}
