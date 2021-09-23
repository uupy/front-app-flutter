class WalletVo {
  double balanceAmount;
  double frozenAmount;
  String id;
  String userId;

  WalletVo({this.balanceAmount, this.frozenAmount, this.id, this.userId});

  WalletVo.fromJson(Map<String, dynamic> json) {
    balanceAmount = json['balanceAmount'];
    frozenAmount = json['frozenAmount'];
    id = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balanceAmount'] = this.balanceAmount;
    data['frozenAmount'] = this.frozenAmount;
    data['id'] = this.id;
    data['userId'] = this.userId;
    return data;
  }
}
