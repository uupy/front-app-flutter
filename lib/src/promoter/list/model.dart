class Promoter {
  String clubId;
  String createTime;
  String customerCount;
  String id;
  String modifyTime;
  String name;
  String phoneNumber;
  double profitAmount;
  String score;
  String userId;

  Promoter(
      {this.clubId,
      this.createTime,
      this.customerCount,
      this.id,
      this.modifyTime,
      this.name,
      this.phoneNumber,
      this.profitAmount,
      this.score,
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
    score = json['score'];
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
    data['score'] = this.score;
    data['userId'] = this.userId;
    return data;
  }
}
