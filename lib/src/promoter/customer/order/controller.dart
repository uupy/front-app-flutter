import 'package:get/get.dart';
import 'package:wine/api/promoter.dart';
import 'package:wine/src/promoter/customer/order/model.dart';

class CustomerOrderController extends GetxController {
  List<CustomerOrder> dataList = [];
  int _current = 1;
  int _pageSize = 20;
  bool isLoadAll = false;
  bool isLoading = false;
  String userId = Get.arguments;

  queryList() async {
    isLoading = true;
    final res = await getCustomerOrderPage({
      'current': _current,
      'pageSize': _pageSize,
      'userId': userId,
    });
    final data = res.data['data'] ?? {};
    List list = data['data'] ?? [];
    List<CustomerOrder> items =
        list.map((item) => CustomerOrder.fromJson(item)).toList();

    if (_current == 1) {
      dataList = items;
    } else {
      dataList = [...dataList, ...items];
    }
    isLoadAll = _current >= data['totalPages'];
    isLoading = false;
    update();
  }

  Future reload() async {
    _current = 1;
    queryList();
  }

  void loadMore() async {
    if (!isLoadAll && !isLoading) {
      _current++;
      queryList();
    }
  }
}
