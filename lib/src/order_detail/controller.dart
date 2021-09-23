import 'package:get/get.dart';
import 'package:wine/api/order.dart';
import 'model.dart';

class OrderDetailController extends GetxController {
  bool loading = false;
  OrderDetailVo detail;

  /// 获取订单详情
  Future fetchData(id) async {
    try {
      loading = true;
      final res = await getOrderDetail(id);
      detail = OrderDetailVo.fromJson(res.data['data']);
    } catch (e) {
      print('getOrderDetail error: $e');
    } finally {
      loading = false;
      update();
    }
  }
}
