import 'package:wine/common/http/request.dart';

/// 调整库存
setStock(data) {
  return request.postJson('/app/stock/adjust', data: data);
}

/// 库存调整记录分页
getStockSettingPage([Object data]) {
  return request.get('/app/stock/adjust/page', queryParameters: data);
}

/// 库存分页
getStockPage([Object data]) {
  return request.get('/app/stock/page', queryParameters: data);
}

/// 采购
stockPurchase(data) {
  return request.postJson('/app/stock/purchase', data: data);
}

/// 调整采购数量
setPurchaseCount(data) {
  return request.post('/app/stock/purchase/adjustCount', data: data);
}

/// 采购记录分页
getPurchasePage([Object data]) {
  return request.get('/app/stock/purchase/page', queryParameters: data);
}

/// 采购收货
receivePurchase(data) {
  return request.post('/app/stock/purchase/receive', data: data);
}

/// 采购取消
cancelPurchase(data) {
  return request.post('/app/stock/purchase/cancel', data: data);
}
