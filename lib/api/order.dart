import 'package:wine/common/http/request.dart';

/// 会馆发货
orderDelivery(data) {
  return request.postJson('/app/order/delivery/club', data: data);
}

/// 物流发货
logisticsDelivery(data) {
  return request.postJson('/app/order/delivery/logistics', data: data);
}

/// 订单详情
getOrderDetail(id) {
  return request.get('/app/order/detail/$id');
}

/// 订单分页
getOrderPage([Object data]) {
  return request.get('/app/order/page', queryParameters: data);
}

/// 订单状态LableValue
getOrderStatusLabel([Object data]) {
  return request.get('/app/order/status/LabelValue', data: data);
}

/// 线下订单接口
/// 线下订单分页
getOrderOfflinePage([Object data]) {
  return request.get('/app/order/offline/page', data: data);
}

/// 线下订单详情
getOrderOfflineDetail(id) {
  return request.get('/app/order/offline/detail/$id');
}

/// 线下订单下单
createOrderOffline(data) {
  return request.postJson('/app/order/offline/createNew', data: data);
}

/// 线下订单取消
cancelOrderOffline(String id) {
  return request.postJson('/app/order/offline/cancel', data: {'id': id});
}

/// 线下订单支付
paidOrderOffline(String id) {
  return request.postJson('/app/order/offline/paid', data: {'id': id});
}

/// 通过手机获取会员和所属创客
getUserInfoByPhoneNumber(String phoneNumber) {
  return request.get(
    '/app/order/offline/userInfo',
    data: {'phoneNumber': phoneNumber},
  );
}

/// 商品分类LabelValue列表
getGoodsCategoryKv() {
  return request.get('/app/order/offline/goodsCategory/labelValue');
}

/// 分类商品LabelValue
getGoodsKv(String categoryId) {
  return request.get(
    '/app/order/offline/goodsList',
    data: {'categoryId': categoryId},
  );
}

/// 商品SKU列表
getGoodsSkuKv(String goodsId) {
  return request.get(
    '/app/order/offline/sku/labelValue',
    data: {'goodsId': goodsId},
  );
}
