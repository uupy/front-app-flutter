import 'package:get/get.dart';
import 'package:wine/api/stock.dart';

class PurcharseLogController extends GetxController {
  List purcharseLogList = [].obs;
  int current = 1;
  int pageSize = 10;
  int status;

  @override
  void onInit() {
    super.onInit();
    this.queryList();
  }

  /// 查询列表
  void queryList() async {
    var res = await getPurchasePage();
    purcharseLogList = res.data['data']['data'];
    print('-------- 查询列表 ---------- List: $purcharseLogList');
  }

  Future refresh() async {
    var res = await getPurchasePage({'current': 1, 'pageSize': 10});
    print('---  refresh ---: ${res.data['data']['data']}');
    var data = res.data['data']['data'];
    purcharseLogList = data;
    return purcharseLogList;
  }
}
