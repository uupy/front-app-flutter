class MyPromotionVo {
  String createTime;
  String id;
  String inviteUserId;
  String modifyTime;
  String newUserAvatar;
  String newUserId;
  String newUserNickname;
  String newUserRealName;
  String newUserTelephone;
  double orderAmount;
  String orderCount;

  MyPromotionVo(
      {this.createTime,
      this.id,
      this.inviteUserId,
      this.modifyTime,
      this.newUserAvatar,
      this.newUserId,
      this.newUserNickname,
      this.newUserRealName,
      this.newUserTelephone,
      this.orderAmount,
      this.orderCount});

  MyPromotionVo.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    id = json['id'];
    inviteUserId = json['inviteUserId'];
    modifyTime = json['modifyTime'];
    newUserAvatar = json['newUserAvatar'];
    newUserId = json['newUserId'];
    newUserNickname = json['newUserNickname'];
    newUserRealName = json['newUserRealName'];
    newUserTelephone = json['newUserTelephone'];
    orderAmount = json['orderAmount'];
    orderCount = json['orderCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['inviteUserId'] = this.inviteUserId;
    data['modifyTime'] = this.modifyTime;
    data['newUserAvatar'] = this.newUserAvatar;
    data['newUserId'] = this.newUserId;
    data['newUserNickname'] = this.newUserNickname;
    data['newUserRealName'] = this.newUserRealName;
    data['newUserTelephone'] = this.newUserTelephone;
    data['orderAmount'] = this.orderAmount;
    data['orderCount'] = this.orderCount;
    return data;
  }
}
