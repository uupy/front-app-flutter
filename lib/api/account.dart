import 'package:wine/common/http/request.dart';

/// 新增账号
createAccount(data) {
  return request.postJson('/app/account/create', data: data);
}

/// 重置密码
resetPassword(id) {
  return request.post('/app/account/resetPassword/$id');
}

/// 账号分页
getAccountPage(data) {
  return request.get('/app/account/page', queryParameters: data);
}

/// 编辑账号
updateAccount(data) {
  return request.postJson('/app/account/update', data: data);
}

/// 删除账号
removeAccount(id) {
  return request.delete('/app/account/$id');
}
