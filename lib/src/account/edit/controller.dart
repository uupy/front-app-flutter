import 'package:get/get.dart';
import 'package:wine/api/account.dart';
import 'package:wine/common/app.dart';
class AccountEditController extends GetxController{
  
  void create(data) async{
    await createAccount(data);
    app.showToast('操作成功');
    Get.back(result: true);
  }

  @override
  void onInit(){
    print('------- onInit -----: ${Get.arguments}');
    super.onInit();
  }

  void edit(data) async {
    await updateAccount(
      {...{'id': Get.arguments.id}, ...data}
    );
    app.showToast('编辑成功');
    Get.back(result: true);
  }
}