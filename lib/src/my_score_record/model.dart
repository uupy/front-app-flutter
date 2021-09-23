class MyScoreVo {
  String bizId;
  String bizParam;
  String bizType;
  String createTime;
  String id;
  String modifyTime;
  String remainScore;
  String remark;
  String scoreChange;
  String scoreTime;
  String userId;

  MyScoreVo({
    this.bizId,
    this.bizParam,
    this.bizType,
    this.createTime,
    this.id,
    this.modifyTime,
    this.remainScore,
    this.remark,
    this.scoreChange,
    this.scoreTime,
    this.userId,
  });

  MyScoreVo.fromJson(Map<String, dynamic> json) {
    bizId = json['bizId'];
    bizParam = json['bizParam'];
    bizType = json['bizType'];
    createTime = json['createTime'];
    id = json['id'];
    modifyTime = json['modifyTime'];
    remainScore = json['remainScore'];
    remark = json['remark'];
    scoreChange = json['scoreChange'];
    scoreTime = json['scoreTime'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bizId'] = this.bizId;
    data['bizParam'] = this.bizParam;
    data['bizType'] = this.bizType;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['remainScore'] = this.remainScore;
    data['remark'] = this.remark;
    data['scoreChange'] = this.scoreChange;
    data['scoreTime'] = this.scoreTime;
    data['userId'] = this.userId;
    return data;
  }
}
