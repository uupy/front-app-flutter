class UserWithPromoterVo {
  Promoter promoter;
  User user;

  UserWithPromoterVo({this.promoter, this.user});

  UserWithPromoterVo.fromJson(Map<String, dynamic> json) {
    promoter = json['promoter'] != null
        ? new Promoter.fromJson(json['promoter'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promoter != null) {
      data['promoter'] = this.promoter.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Promoter {
  int clubId;
  String createTime;
  int customerCount;
  int id;
  String modifyTime;
  String name;
  String phoneNumber;
  int profitAmount;
  RoleType roleType;
  int userId;

  Promoter(
      {this.clubId,
      this.createTime,
      this.customerCount,
      this.id,
      this.modifyTime,
      this.name,
      this.phoneNumber,
      this.profitAmount,
      this.roleType,
      this.userId});

  Promoter.fromJson(Map<String, dynamic> json) {
    clubId = json['clubId'];
    createTime = json['createTime'];
    customerCount = json['customerCount'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    profitAmount = json['profitAmount'];
    roleType = json['roleType'] != null
        ? new RoleType.fromJson(json['roleType'])
        : null;
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
    data['phoneNumber'] = this.phoneNumber;
    data['profitAmount'] = this.profitAmount;
    if (this.roleType != null) {
      data['roleType'] = this.roleType.toJson();
    }
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

class User {
  String avatar;
  String email;
  RoleType gender;
  int id;
  String idNumber;
  String lastLoginTime;
  String nickname;
  String password;
  String realName;
  String salt;
  RoleType state;
  int systemId;
  String telephone;
  String username;

  User(
      {this.avatar,
      this.email,
      this.gender,
      this.id,
      this.idNumber,
      this.lastLoginTime,
      this.nickname,
      this.password,
      this.realName,
      this.salt,
      this.state,
      this.systemId,
      this.telephone,
      this.username});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    email = json['email'];
    gender =
        json['gender'] != null ? new RoleType.fromJson(json['gender']) : null;
    id = json['id'];
    idNumber = json['idNumber'];
    lastLoginTime = json['lastLoginTime'];
    nickname = json['nickname'];
    password = json['password'];
    realName = json['realName'];
    salt = json['salt'];
    state = json['state'] != null ? new RoleType.fromJson(json['state']) : null;
    systemId = json['systemId'];
    telephone = json['telephone'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    if (this.gender != null) {
      data['gender'] = this.gender.toJson();
    }
    data['id'] = this.id;
    data['idNumber'] = this.idNumber;
    data['lastLoginTime'] = this.lastLoginTime;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['realName'] = this.realName;
    data['salt'] = this.salt;
    if (this.state != null) {
      data['state'] = this.state.toJson();
    }
    data['systemId'] = this.systemId;
    data['telephone'] = this.telephone;
    data['username'] = this.username;
    return data;
  }
}
