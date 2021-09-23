import 'package:get/get.dart';
import 'package:wine/api/wallet.dart';
import 'package:wine/common/app.dart';

import 'model.dart';

class MyWalletCardController extends GetxController {
  bool isLoading = false;
  bool isSubmiting = false;
  String _walletId;
  WalletCardVo detail;

  /// 查询列表
  void fetchData({String walletId}) async {
    try {
      _walletId = walletId ?? _walletId;
      isLoading = true;
      final res = await queryCardList(_walletId);
      List items = res.data['data'] ?? [];
      if (items.length > 0) {
        detail = WalletCardVo.fromJson(items[0]);
      } else {
        detail = null;
      }
    } catch (e) {
      print('queryOrders error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future bind(data) async {
    isSubmiting = true;
    try {
      await bindCard(data);
      app.showToast('操作成功');
      fetchData();
    } finally {
      isSubmiting = false;
    }
  }

  Future unbind(String bindingId) async {
    isSubmiting = true;
    try {
      await unbindCard({'bindingId': bindingId});
      app.showToast('操作成功');
      fetchData();
    } finally {
      isSubmiting = false;
    }
  }
}
