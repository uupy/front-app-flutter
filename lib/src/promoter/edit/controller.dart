import 'package:get/get.dart';
import 'package:wine/api/promoter.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/http/request.dart';

class PromoterEditController extends GetxController {
  String errMsg = '';

  void create(data) async {
    await createPromoter(data);
    app.showToast('操作成功');
    Get.back(result: true);
  }

  @override
  void onInit() {
    print('------- onInit -----: ${Get.arguments}');
    super.onInit();
  }

  void edit(data) async {
    await updatePromoter({
      ...{'id': Get.arguments.id},
      ...data
    });
    app.showToast('编辑成功');
    Get.back(result: true);
  }

  /// 手机号改变
  Future handlePhoneNumberChange(String phoneNumber, {Function success}) async {
    final res = await getUserByPhoneNumber(phoneNumber);
    final data = res.data ?? {};
    final info = data['data'] ?? {};
    logger.i('user info: $info');
    if (info['id'] != null) {
      errMsg = '';
    } else {
      errMsg = '用户未注册';
    }
    if (success is Function) {
      success(info);
    }
    update();
  }
}
