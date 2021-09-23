import 'package:wine/common/http/request.dart';

/// 我的推广
getPromotionPage([Object data]) {
  return request.get('/app/promotion/myPage', queryParameters: data);
}

/// 我的推广提成分页
getProfitPage({Object data}) {
  return request.get('/app/profit/promotion/page', queryParameters: data);
}
