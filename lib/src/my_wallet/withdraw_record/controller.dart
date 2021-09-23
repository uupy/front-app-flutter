import 'package:get/get.dart';
import 'package:wine/api/wallet.dart';

import 'model.dart';

class MyWithdrawRecordController extends GetxController {
  int _current = 1;
  int _pageSize = 10;
  bool isLoading = false;
  bool isLoadAll = false;
  String _walletId;
  List<WithdrawRecordVo> dataList = [];

  /// 查询列表
  void queryList({String walletId}) async {
    try {
      _walletId = walletId ?? _walletId;
      isLoading = true;
      final res = await queryMyWithdrawPage(_walletId, data: {
        'current': _current,
        'pageSize': _pageSize,
      });
      final data = res.data['data'];
      List items = data['data'] ?? [];
      List<WithdrawRecordVo> _dataList =
          items.map((item) => WithdrawRecordVo.fromJson(item)).toList();

      /// 是否已加载全部
      isLoadAll = _current >= data['totalPages'];

      /// 列表数据
      if (_current == 1) {
        dataList = _dataList;
      } else {
        dataList = [...dataList, ..._dataList];
      }
    } catch (e) {
      print('queryOrders error: $e');
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
