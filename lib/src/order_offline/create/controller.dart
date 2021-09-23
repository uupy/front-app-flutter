import 'package:get/get.dart';
import 'package:wine/api/order.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/http/request.dart';
// import 'package:wine/common/http/request.dart';

// import 'model.dart';

class OrderOfflineCreateController extends GetxController {
  bool isLoading = false;
  bool isSubmiting = false;
  List goodsList = [];
  double totalPrice;
  double realAmount;
  Map bindUser = {};
  Map promoter = {};
  Map<String, dynamic> form = {
    "contactNumber": "",
    "contactName": "",
    "couponAmount": "",
    "remark": "",
    "userId": "",
    "couponType": 0,
    "paymentType": 0,
    "paymentStatus": 0,
    "skuList": [],
  };

  /// 手机号改变
  Future handleContactNumberChange({Function success}) async {
    final res = await getUserInfoByPhoneNumber(form['contactNumber']);
    final data = res.data ?? {};
    final info = data['data'] ?? {};
    bindUser = info['user'] ?? {};
    promoter = info['promoter'] ?? {};
    form['contactName'] = bindUser['realName'] ?? '';
    form['userId'] = bindUser['id'] ?? '';
    if (success is Function) {
      success(data);
    }
    update();
  }

  /// 更新价格
  updatePrice() {
    double _price = 0;
    if (goodsList.length == 0) {
      totalPrice = null;
      realAmount = null;
    } else {
      goodsList.forEach((goods) {
        _price += goods['salePrice'] * goods['quantity'];
      });
      totalPrice = _price;
      realAmount = _price;
      if (form['couponAmount'] != '') {
        realAmount = totalPrice - double.parse(form['couponAmount']);
      }
    }
    update();
  }

  /// 添加商品
  addGoods(data) {
    goodsList.add(data);
    updatePrice();
    update();
  }

  /// 移除商品
  removeGoods(data) {
    goodsList.remove(data);
    updatePrice();
    update();
  }

  /// 下单
  Future create() async {
    if (isSubmiting) return;
    if (form['contactNumber'] == '') {
      app.showToast('请输入会员手机号');
      return;
    }
    if (form['contactName'].isEmpty) {
      app.showToast('请输入会员姓名');
      return;
    }
    if (goodsList.isEmpty) {
      app.showToast('请添加商品');
      return;
    }
    isSubmiting = true;
    List<Map> skuList = [];
    goodsList.forEach((goods) {
      skuList.add({
        'skuId': goods['skuId'],
        'quantity': goods['quantity'],
      });
    });
    form['skuList'] = skuList;
    logger.i('createOrderOffline data: $form');
    try {
      await createOrderOffline(form);
      form.clear();
      form['skuList'] = [];
      goodsList = [];
      app.showToast('操作成功');
      Get.back(result: true);
    } finally {
      isSubmiting = false;
    }
  }
}
