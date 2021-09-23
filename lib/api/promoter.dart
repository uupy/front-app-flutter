import 'package:wine/common/http/request.dart';

/// 删除
removePromoter(id) {
  return request.delete('/app/promoter/$id');
}

/// 新增
createPromoter(data) {
  return request.postJson('/app/promoter/create', data: data);
}

/// 编辑
updatePromoter(data) {
  return request.postJson('/app/promoter/update', data: data);
}

/// 重置密码
resetPromoterPassword(userId) {
  return request.post('/app/promoter/resetPassword/$userId');
}

/// 创客分页
getPromoterPage([Object data]) {
  return request.get('/app/promoter/page', queryParameters: data);
}

/// 创客的推广客户分页
getCustomerPage([Object data]) {
  return request.get('/app/promoter/customer/page', queryParameters: data);
}

/// 客户订单分页
getCustomerOrderPage([Object data]) {
  return request.get('/app/promoter/customer/orderPage', queryParameters: data);
}

/// 通过手机号查询用户
getUserByPhoneNumber(String phoneNumber) {
  return request.get(
    '/app/promoter/findUser',
    data: {'phoneNumber': phoneNumber},
  );
}
