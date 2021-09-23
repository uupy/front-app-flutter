class UserVo {
  String clubId;
  String createTime;
  String customerCount;
  String id;
  String modifyTime;
  String name;
  String avatarUrl;
  String phoneNumber;
  double profitAmount;
  RoleType roleType;
  String score;
  String userId;
  bool isAdmin;

  UserVo(
      {this.clubId,
      this.createTime,
      this.customerCount,
      this.id,
      this.modifyTime,
      this.name,
      this.avatarUrl,
      this.phoneNumber,
      this.profitAmount,
      this.roleType,
      this.score,
      this.isAdmin,
      this.userId});

  UserVo.fromJson(Map<String, dynamic> json) {
    clubId = json['clubId'];
    createTime = json['createTime'];
    customerCount = json['customerCount'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    phoneNumber = json['phoneNumber'];
    profitAmount = json['profitAmount'];
    roleType = json['roleType'] != null
        ? new RoleType.fromJson(json['roleType'])
        : null;
    score = json['score'];
    isAdmin = json['isAdmin'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clubId'] = this.clubId;
    data['createTime'] = this.createTime;
    data['customerCount'] = this.customerCount;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['phoneNumber'] = this.phoneNumber;
    data['profitAmount'] = this.profitAmount;
    if (this.roleType != null) {
      data['roleType'] = this.roleType.toJson();
    }
    data['score'] = this.score;
    data['isAdmin'] = this.isAdmin;
    data['userId'] = this.userId;
    return data;
  }
}

class RoleType {
  String desc;
  int value;

  RoleType({this.desc, this.value});

  RoleType.fromJson(Map<String, dynamic> json) {
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
