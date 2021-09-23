import 'package:get/get.dart';
import 'package:wine/api/order.dart';
import 'model.dart';

class OrderDetailController extends GetxController {
  bool loading = false;
  OrderOfflineDetailVo detail;

  /// 获取订单详情
  Future fetchData(id) async {
    try {
      loading = true;
      final res = await getOrderOfflineDetail(id);
      detail = OrderOfflineDetailVo.fromJson(res.data['data']);
    } catch (e) {
      print('getOrderDetail error: $e');
    } finally {
      loading = false;
      update();
    }
  }
}
