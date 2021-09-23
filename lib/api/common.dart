import 'package:dio/dio.dart';
import 'package:wine/common/http/request.dart';

/// 登录
login(data) {
  return request.postJson('/uaa/login', data: data);
}

/// 根据code获取广告列表
getAdsByCode(data) {
  return request.get('/common/ad/pageByPositionCode', queryParameters: data);
}

/// 修改密码
changePassword(data) {
  return request.put('/uaa/password', data: data);
}

/// 获取新版本
queryNewVersion(data) {
  return request.get('/common/appVersion/queryNewVersion',
      queryParameters: data);
}

/// 获取用户信息
getUserInfo() {
  return request.get('/app/my/info', options: Options(extra: {'silent': true}));
}
