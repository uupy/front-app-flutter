import 'package:wine/common/http/request.dart';

/// 我的积分明细分页
getScorePage([Object data]) {
  return request.get('/app/score/page', queryParameters: data);
}
