import 'package:get/get.dart';
import 'package:wine/api/wallet.dart';
import 'package:wine/common/app.dart';

class MyWithdrawApplyController extends GetxController {
  bool isSubmiting = false;

  Future submit(data) async {
    isSubmiting = true;
    try {
      await withdrawApply(data);
      app.showToast('操作成功');
      Get.back(result: true);
    } finally {
      isSubmiting = false;
    }
  }
}
