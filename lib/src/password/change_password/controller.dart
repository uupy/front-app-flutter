import 'package:get/get.dart';
import 'package:wine/api/common.dart';
import 'package:wine/common/app.dart';

class ChangePasswordControll extends GetxController{
  void onSave(data) async{
    await changePassword(data);
    app.showToast('已修改');
    Get.offAndToNamed('login');
  }
}