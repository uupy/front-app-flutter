import 'package:get/get.dart';
import 'package:wine/api/order.dart';
import 'model.dart';

class OrderOnlineController extends GetxController {
  int _status;
  int _current = 1;
  int _pageSize = 10;
  String _keyword = '';
  bool loading = false;
  bool isAllLoaded = false;
  List<OrderOnlineVo> orderList = [];

  /// 查询列表
  void queryOrders() async {
    try {
      loading = true;
      final res = await getOrderPage({
        'current': _current,
        'pageSize': _pageSize,
        'status': _status,
        'keyword': _keyword,
      });
      final data = res.data['data'];
      List dataList = data['data'] ?? [];
      List<OrderOnlineVo> items =
          dataList.map((item) => OrderOnlineVo.fromJson(item)).toList();
      isAllLoaded = _current >= data['totalPages'];
      if (_current == 1) {
        orderList = items;
      } else {
        orderList = [...orderList, ...items];
      }
    } catch (e) {
      print('queryOrders error: $e');
    } finally {
      loading = false;
      update();
    }
  }

  /// 重新加载
  Future reload({
    int status,
    String keyword,
  }) async {
    if (loading) return;
    _current = 1;
    _status = status;
    _keyword = keyword ?? _keyword;
    queryOrders();
  }

  /// 刷新
  Future onRefresh() async {
    return reload(status: _status, keyword: _keyword);
  }

  /// 加载更多
  void loadMore() {
    if (!isAllLoaded && !loading) {
      _current += 1;
      queryOrders();
    }
  }

  /// 状态过滤
  void onSearchByStatus({int status}) {
    print('onSearchByStatus: $status');
    reload(status: status);
  }

  /// 关键词过滤查询
  void onSearchByKeyword({String keyword}) {
    reload(keyword: keyword, status: _status);
  }
}
