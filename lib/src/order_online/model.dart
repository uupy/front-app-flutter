class OrderOnlineVo {
  String assignTime;
  String clubId;
  String contactName;
  String contactNumber;
  String deliveryName;
  String deliveryNumber;
  DeliveryStatus deliveryStatus;
  String deliveryTime;
  DeliveryStatus deliveryType;
  String id;
  List<ItemList> itemList;
  String logisticsName;
  String logisticsNumber;
  String orderId;
  double realAmount;
  String receiveAddress;
  String remark;

  OrderOnlineVo({
    this.assignTime,
    this.clubId,
    this.contactName,
    this.contactNumber,
    this.deliveryName,
    this.deliveryNumber,
    this.deliveryStatus,
    this.deliveryTime,
    this.deliveryType,
    this.id,
    this.itemList,
    this.logisticsName,
    this.logisticsNumber,
    this.orderId,
    this.realAmount,
    this.receiveAddress,
    this.remark,
  });

  OrderOnlineVo.fromJson(Map<String, dynamic> json) {
    assignTime = json['assignTime'];
    clubId = json['clubId'];
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
    deliveryName = json['deliveryName'];
    deliveryNumber = json['deliveryNumber'];
    deliveryStatus = json['deliveryStatus'] != null
        ? new DeliveryStatus.fromJson(json['deliveryStatus'])
        : null;
    deliveryTime = json['deliveryTime'];
    deliveryType = json['deliveryType'] != null
        ? new DeliveryStatus.fromJson(json['deliveryType'])
        : null;
    id = json['id'];
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList.add(new ItemList.fromJson(v));
      });
    }
    logisticsName = json['logisticsName'];
    logisticsNumber = json['logisticsNumber'];
    orderId = json['orderId'];
    realAmount = json['realAmount'];
    receiveAddress = json['receiveAddress'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignTime'] = this.assignTime;
    data['clubId'] = this.clubId;
    data['contactName'] = this.contactName;
    data['contactNumber'] = this.contactNumber;
    data['deliveryName'] = this.deliveryName;
    data['deliveryNumber'] = this.deliveryNumber;
    if (this.deliveryStatus != null) {
      data['deliveryStatus'] = this.deliveryStatus.toJson();
    }
    data['deliveryTime'] = this.deliveryTime;
    if (this.deliveryType != null) {
      data['deliveryType'] = this.deliveryType.toJson();
    }
    data['id'] = this.id;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['logisticsName'] = this.logisticsName;
    data['logisticsNumber'] = this.logisticsNumber;
    data['orderId'] = this.orderId;
    data['realAmount'] = this.realAmount;
    data['receiveAddress'] = this.receiveAddress;
    data['remark'] = this.remark;
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
