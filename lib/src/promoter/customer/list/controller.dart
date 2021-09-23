import 'package:get/get.dart';
import 'package:wine/api/promoter.dart';
import 'package:wine/src/promoter/customer/list/model.dart';

class CustomerListController extends GetxController {
  List<Customer> dataList = [];
  int _current = 1;
  int _pageSize = 20;
  bool isLoadAll = false;
  bool isLoading = false;
  String promoterUserId = Get.parameters['promoterUserId'];

  queryList() async {
    isLoading = true;
    final res = await getCustomerPage({
      'current': _current,
      'pageSize': _pageSize,
      'promoterUserId': promoterUserId
    });
    final data = res.data['data'] ?? {};
    List list = data['data'] ?? [];
    List<Customer> items = list.map((item) => Customer.fromJson(item)).toList();

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
