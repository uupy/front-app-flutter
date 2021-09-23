import 'package:get/get.dart';
import 'package:wine/api/stock.dart';
import 'package:wine/src/stock/logs/model.dart';

class StockLogController extends GetxController{
  List<StockLog> dataList = [];
  int _current = 1;
  int _pageSize = 20;
  bool isLoadAll = false;
  bool isLoading = false;

  queryList() async{
    isLoading = true;
    var res = await getStockSettingPage(
      {
        'current': _current,
        'pageSize': _pageSize
      }
    );
    List list = res.data['data']['data'] ?? [];
    List<StockLog> items = list.map((item) => StockLog.fromJson(item)).toList();
    if (_current == 1) {
      dataList = items;
    } else {
      dataList = [...dataList, ...items];
    }
    isLoading = false;
    print('----------- queryList -------------: $dataList');
    update();
  }

  Future reload() async{
    _current = 1;
    queryList();
  }

  void loadMore() async{
    if (!isLoadAll && !isLoading) {
      _current++;
      queryList();
    }
  }
}