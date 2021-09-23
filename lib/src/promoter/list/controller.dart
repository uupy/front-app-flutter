import 'package:get/get.dart';
import 'package:wine/api/promoter.dart';
import 'package:wine/common/app.dart';
import 'package:wine/src/promoter/list/model.dart';

class PromoterListController extends GetxController {
  List<Promoter> dataList = [];
  int _current = 1;
  int _pageSize = 20;
  bool isLoadAll = false;
  bool isLoading = false;

  queryList() async {
    isLoading = true;
    var res =
        await getPromoterPage({'current': _current, 'pageSize': _pageSize});
    List list = res.data['data']['data'] ?? [];
    List<Promoter> items = list.map((item) => Promoter.fromJson(item)).toList();
    if (_current == 1) {
      dataList = items;
    } else {
      dataList = [...dataList, ...items];
    }
    isLoading = false;
    update();
  }

  void remove(id) async {
    await removePromoter(id);
    app.showToast('已删除');
    Get.back();
    reload();
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

  void resetPassword(userId) async {
    await resetPromoterPassword(userId);
    app.showToast('密码已重置');
    Get.back();
    reload();
  }
}
