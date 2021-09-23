class OrderDetailVo {
  double amount;
  String assignTime;
  String clubOrderId;
  String contactName;
  String contactNumber;
  double couponAmount;
  List<CouponList> couponList;
  String createTime;
  String deliveryName;
  String deliveryNumber;
  DeliveryStatus deliveryStatus;
  String deliveryTime;
  DeliveryStatus deliveryType;
  String finishTime;
  String id;
  List<ItemList> itemList;
  String logisticsName;
  String logisticsNumber;
  String modifyTime;
  String paymentMethodCode;
  String paymentMethodId;
  String paymentMethodName;
  String paymentRemark;
  DeliveryStatus paymentStatus;
  double realAmount;
  String receiveAddress;
  String receiveAddressId;
  String remark;
  List<SkuList> skuList;
  DeliveryStatus status;
  String tradeNo;
  String tradePictureUrl;
  String userId;

  OrderDetailVo({
    this.amount,
    this.assignTime,
    this.clubOrderId,
    this.contactName,
    this.contactNumber,
    this.couponAmount,
    this.couponList,
    this.createTime,
    this.deliveryName,
    this.deliveryNumber,
    this.deliveryStatus,
    this.deliveryTime,
    this.deliveryType,
    this.finishTime,
    this.id,
    this.itemList,
    this.logisticsName,
    this.logisticsNumber,
    this.modifyTime,
    this.paymentMethodCode,
    this.paymentMethodId,
    this.paymentMethodName,
    this.paymentRemark,
    this.paymentStatus,
    this.realAmount,
    this.receiveAddress,
    this.receiveAddressId,
    this.remark,
    this.skuList,
    this.status,
    this.tradeNo,
    this.tradePictureUrl,
    this.userId,
  });

  OrderDetailVo.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    assignTime = json['assignTime'];
    clubOrderId = json['clubOrderId'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    couponAmount = json['couponAmount'];
    if (json['couponList'] != null) {
      couponList = <CouponList>[];
      json['couponList'].forEach((v) {
        couponList.add(new CouponList.fromJson(v));
      });
    }
    createTime = json['createTime'];
    deliveryName = json['deliveryName'];
    deliveryNumber = json['deliveryNumber'];
    deliveryStatus = json['deliveryStatus'] != null
        ? new DeliveryStatus.fromJson(json['deliveryStatus'])
        : null;
    deliveryTime = json['deliveryTime'];
    deliveryType = json['deliveryType'] != null
        ? new DeliveryStatus.fromJson(json['deliveryType'])
        : null;
    finishTime = json['finishTime'];
    id = json['id'];
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList.add(new ItemList.fromJson(v));
      });
    }
    logisticsName = json['logisticsName'];
    logisticsNumber = json['logisticsNumber'];
    modifyTime = json['modifyTime'];
    paymentMethodCode = json['paymentMethodCode'];
    paymentMethodId = json['paymentMethodId'];
    paymentMethodName = json['paymentMethodName'];
    paymentRemark = json['paymentRemark'];
    paymentStatus = json['paymentStatus'] != null
        ? new DeliveryStatus.fromJson(json['paymentStatus'])
        : null;
    realAmount = json['realAmount'];
    receiveAddress = json['receiveAddress'];
    receiveAddressId = json['receiveAddressId'];
    remark = json['remark'];
    if (json['skuList'] != null) {
      skuList = <SkuList>[];
      json['skuList'].forEach((v) {
        skuList.add(new SkuList.fromJson(v));
      });
    }
    status = json['status'] != null
        ? new DeliveryStatus.fromJson(json['status'])
        : null;
    tradeNo = json['tradeNo'];
    tradePictureUrl = json['tradePictureUrl'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['assignTime'] = this.assignTime;
    data['clubOrderId'] = this.clubOrderId;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['couponAmount'] = this.couponAmount;
    if (this.couponList != null) {
      data['couponList'] = this.couponList.map((v) => v.toJson()).toList();
    }
    data['createTime'] = this.createTime;
    data['deliveryName'] = this.deliveryName;
    data['deliveryNumber'] = this.deliveryNumber;
    if (this.deliveryStatus != null) {
      data['deliveryStatus'] = this.deliveryStatus.toJson();
    }
    data['deliveryTime'] = this.deliveryTime;
    if (this.deliveryType != null) {
      data['deliveryType'] = this.deliveryType.toJson();
    }
    data['finishTime'] = this.finishTime;
    data['id'] = this.id;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['logisticsName'] = this.logisticsName;
    data['logisticsNumber'] = this.logisticsNumber;
    data['modifyTime'] = this.modifyTime;
    data['paymentMethodCode'] = this.paymentMethodCode;
    data['paymentMethodId'] = this.paymentMethodId;
    data['paymentMethodName'] = this.paymentMethodName;
    data['paymentRemark'] = this.paymentRemark;
    if (this.paymentStatus != null) {
      data['paymentStatus'] = this.paymentStatus.toJson();
    }
    data['realAmount'] = this.realAmount;
    data['receiveAddress'] = this.receiveAddress;
    data['receiveAddressId'] = this.receiveAddressId;
    data['remark'] = this.remark;
    if (this.skuList != null) {
      data['skuList'] = this.skuList.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['tradeNo'] = this.tradeNo;
    data['tradePictureUrl'] = this.tradePictureUrl;
    data['userId'] = this.userId;
    return data;
  }
}

class CouponList {
  String couponId;
  int useCount;

  CouponList({this.couponId, this.useCount});

  CouponList.fromJson(Map<String, dynamic> json) {
    couponId = json['couponId'];
    useCount = json['useCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponId'] = this.couponId;
    data['useCount'] = this.useCount;
    return data;
  }
}

class DeliveryStatus {
  String desc;
  int value;

  DeliveryStatus({this.desc, this.value});

  DeliveryStatus.fromJson(Map<String, dynamic> json) {
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
  int deliveredQuantity;
  double discount;
  String goodsId;
  String goodsName;
  String goodsPictureUrl;
  String id;
  bool isGift;
  String modifyTime;
  int quantity;
  double realAmount;
  int returnedQuantity;
  double salePrice;
  String skuId;
  String skuName;
  String thumbnailUrl;
  double volume;
  double weight;

  ItemList({
    this.amount,
    this.createTime,
    this.deliveredQuantity,
    this.discount,
    this.goodsId,
    this.goodsName,
    this.goodsPictureUrl,
    this.id,
    this.isGift,
    this.modifyTime,
    this.quantity,
    this.realAmount,
    this.returnedQuantity,
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
    deliveredQuantity = json['deliveredQuantity'];
    discount = json['discount'];
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    goodsPictureUrl = json['goodsPictureUrl'];
    id = json['id'];
    isGift = json['isGift'];
    modifyTime = json['modifyTime'];
    quantity = json['quantity'];
    realAmount = json['realAmount'];
    returnedQuantity = json['returnedQuantity'];
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
    data['deliveredQuantity'] = this.deliveredQuantity;
    data['discount'] = this.discount;
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['goodsPictureUrl'] = this.goodsPictureUrl;
    data['id'] = this.id;
    data['isGift'] = this.isGift;
    data['modifyTime'] = this.modifyTime;
    data['quantity'] = this.quantity;
    data['realAmount'] = this.realAmount;
    data['returnedQuantity'] = this.returnedQuantity;
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
  String skuId;

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
