class OrderOfflineDetailVo {
  double amount;
  String clubId;
  String contactName;
  String contactNumber;
  double couponAmount;
  DescValueType couponType;
  String createTime;
  String id;
  List<ItemList> itemList;
  String modifyTime;
  DescValueType paymentStatus;
  DescValueType status;
  String paidTime;
  String paymentTradeNo;
  DescValueType paymentType;
  double realAmount;
  String remark;
  List<SkuList> skuList;
  String userId;

  OrderOfflineDetailVo({
    this.amount,
    this.clubId,
    this.contactName,
    this.contactNumber,
    this.couponAmount,
    this.couponType,
    this.createTime,
    this.id,
    this.itemList,
    this.modifyTime,
    this.status,
    this.paymentStatus,
    this.paidTime,
    this.paymentTradeNo,
    this.paymentType,
    this.realAmount,
    this.remark,
    this.skuList,
    this.userId,
  });

  OrderOfflineDetailVo.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    clubId = json['clubId'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    couponAmount = json['couponAmount'];
    couponType = json['couponType'] != null
        ? new DescValueType.fromJson(json['couponType'])
        : null;
    createTime = json['createTime'];
    id = json['id'];
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList.add(new ItemList.fromJson(v));
      });
    }
    modifyTime = json['modifyTime'];
    paymentStatus = json['paymentStatus'] != null
        ? new DescValueType.fromJson(json['paymentStatus'])
        : null;
    status = json['status'] != null
        ? new DescValueType.fromJson(json['status'])
        : null;
    paidTime = json['paymentTime'];
    paymentTradeNo = json['paymentTradeNo'];
    paymentType = json['paymentType'] != null
        ? new DescValueType.fromJson(json['paymentType'])
        : null;
    realAmount = json['realAmount'];
    remark = json['remark'];
    if (json['skuList'] != null) {
      skuList = <SkuList>[];
      json['skuList'].forEach((v) {
        skuList.add(new SkuList.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['clubId'] = this.clubId;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['couponAmount'] = this.couponAmount;
    if (this.couponType != null) {
      data['couponType'] = this.couponType.toJson();
    }
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['modifyTime'] = this.modifyTime;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.paymentStatus != null) {
      data['paymentStatus'] = this.paymentStatus.toJson();
    }
    data['paymentTime'] = this.paidTime;
    data['paymentTradeNo'] = this.paymentTradeNo;
    if (this.paymentType != null) {
      data['paymentType'] = this.paymentType.toJson();
    }
    data['realAmount'] = this.realAmount;
    data['remark'] = this.remark;
    if (this.skuList != null) {
      data['skuList'] = this.skuList.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class DescValueType {
  String desc;
  int value;

  DescValueType({this.desc, this.value});

  DescValueType.fromJson(Map<String, dynamic> json) {
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

class ItemList {
  double amount;
  String createTime;
  String goodsId;
  String goodsName;
  String goodsPictureUrl;
  String id;
  String modifyTime;
  int quantity;
  double realAmount;
  double salePrice;
  String skuId;
  String skuName;
  String thumbnailUrl;
  double volume;
  double weight;

  ItemList({
    this.amount,
    this.createTime,
    this.goodsId,
    this.goodsName,
    this.goodsPictureUrl,
    this.id,
    this.modifyTime,
    this.quantity,
    this.realAmount,
    this.salePrice,
    this.skuId,
    this.skuName,
    this.thumbnailUrl,
    this.volume,
    this.weight,
  });

  ItemList.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createTime = json['createTime'];
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    goodsPictureUrl = json['goodsPictureUrl'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    quantity = json['quantity'];
    realAmount = json['realAmount'];
    salePrice = json['salePrice'];
    skuId = json['skuId'];
    skuName = json['skuName'];
    thumbnailUrl = json['thumbnailUrl'];
    volume = json['volume'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createTime'] = this.createTime;
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['goodsPictureUrl'] = this.goodsPictureUrl;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['quantity'] = this.quantity;
    data['realAmount'] = this.realAmount;
    data['salePrice'] = this.salePrice;
    data['skuId'] = this.skuId;
    data['skuName'] = this.skuName;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['volume'] = this.volume;
    data['weight'] = this.weight;
    return data;
  }
}

class SkuList {
  int quantity;
  int skuId;

  SkuList({this.quantity, this.skuId});

  SkuList.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    skuId = json['skuId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['skuId'] = this.skuId;
    return data;
  }
}
