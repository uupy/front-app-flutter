import 'package:wine/common/http/request.dart';

/// 会馆业务统计
getClub([Object data]) {
  return request.get('/app/home/statics/club', queryParameters: data);
}

/// 我的推广统计
getMyPromote([Object data]) {
  return request.get('/app/home/statics/myPromote', queryParameters: data);
}

/// 销售排名统计
getSaleTop([Object data]) {
  return request.get('/app/home/list/saleTop', queryParameters: data);
}
