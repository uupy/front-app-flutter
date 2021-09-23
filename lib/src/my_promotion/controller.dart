import 'package:get/get.dart';
import 'package:wine/api/promotion.dart';
import 'package:wine/common/http/request.dart';

import 'model.dart';

class MyPromotionController extends GetxController {
  int _current = 1;
  int _pageSize = 10;
  String totalPeople = '0';
  bool isLoading = false;
  bool isLoadAll = false;
  List<MyPromotionVo> dataList = [];
  MyPromotionVo currentUser;

  /// 查询列表
  void queryList() async {
    try {
      isLoading = true;
      final res = await getPromotionPage({
        'current': _current,
        'pageSize': _pageSize,
      });
      final data = res.data['data'];

      List items = data['data'] ?? [];
      List<MyPromotionVo> _dataList =
          items.map((item) => MyPromotionVo.fromJson(item)).toList();

      /// 总人数
      logger.i('${data['total']}');
      totalPeople = data['total'];

      /// 是否已加载全部
      isLoadAll = _current >= data['totalPages'];

      /// 列表数据
      if (_current == 1) {
        dataList = _dataList;
      } else {
        dataList = [...dataList, ..._dataList];
      }
    } catch (e) {
      logger.e('getPromotionPage error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  /// 重新加载
  Future reload() async {
    if (isLoading) return;
    _current = 1;
    queryList();
  }

  /// 加载更多
  void loadMore() {
    if (!isLoadAll && !isLoading) {
      _current += 1;
      queryList();
    }
  }
}
