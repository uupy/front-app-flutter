import 'package:get/get.dart';
import 'package:wine/api/wallet.dart';
import 'model.dart';

class MyWalletController extends GetxController {
  bool loading = false;
  String title = Get.parameters['title'];
  String menuKey = Get.parameters['key'];
  String cardId;
  WalletVo detail;

  /// 获取钱包详情
  Future fetchData() async {
    try {
      loading = true;
      var res;
      if (menuKey == 'bizWallet') {
        res = await getBizWallet();
      } else {
        res = await getMyWallet();
      }
      detail = WalletVo.fromJson(res.data['data']);
      final res1 = await queryCardList(detail?.id);
      List items = res1.data['data'] ?? [];
      if (items.length > 0) {
        cardId = items[0]['id'];
      } else {
        cardId = '';
      }
    } catch (e) {
      print('getMyWallet error: $e');
    } finally {
      loading = false;
      update();
    }
  }
}
