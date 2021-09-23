import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:wine/api/order.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/common/http/request.dart';
import 'package:wine/src/order_offline/create/controller.dart';

// import 'model.dart';

class OrderOfflineGoodsSelectController extends GetxController {
  bool isLoading = false;
  bool isSubmiting = false;
  bool isEdit = Get.parameters['isEdit'] == '1';
  int quantity;
  double salePrice;
  String categoryName;
  String categoryId;
  String goodsName;
  String goodsPictureUrl;
  String goodsId;
  String skuName;
  String skuId;
  Map _goods;

  /// 显示商品分类picker
  Future showCategoryPicker(BuildContext context) async {
    if (isLoading || isEdit) return;
    try {
      isLoading = true;
      final res = await getGoodsCategoryKv();
      final data = res.data ?? {};
      List items = data['data'] ?? [];
      if (items.isEmpty) {
        app.showToast('暂无商品分类');
        return;
      }

      /// 选项id集合
      List ids = items.map((item) => item['value']).toList();

      /// 当前下标
      int currentIndex = ids.indexOf(categoryId);

      showPicker(
        context,
        selecteds: [currentIndex],
        options: items.map((item) => item['label']).toList(),
        onConfirm: (index) {
          String _id = items[index]['value'];
          if (categoryId != _id) {
            categoryName = items[index]['label'];
            categoryId = _id;
            goodsName = '';
            goodsPictureUrl = '';
            goodsId = '';
            skuName = '';
            skuId = '';
            salePrice = null;
            update();
          }
        },
      );
    } finally {
      isLoading = false;
    }
  }

  /// 显示商品picker
  Future showGoodsPicker(BuildContext context) async {
    if (isLoading || isEdit) return;
    try {
      if (categoryId == null || categoryId.isEmpty) {
        app.showToast('请选择商品分类');
        return;
      }
      isLoading = true;
      final res = await getGoodsKv(categoryId);
      final data = res.data ?? {};
      List items = data['data'] ?? [];
      if (items.isEmpty) {
        app.showToast('暂无商品');
        return;
      }

      /// 选项id集合
      List ids = items.map((item) => item['id']).toList();

      /// 当前下标
      int currentIndex = ids.indexOf(goodsId);

      showPicker(
        context,
        selecteds: [currentIndex],
        options: items.map((item) => item['name']).toList(),
        onConfirm: (index) {
          String _id = items[index]['id'];
          if (goodsId != _id) {
            goodsName = items[index]['name'];
            goodsPictureUrl = items[index]['pictureUrl'];
            goodsId = _id;
            skuName = '';
            skuId = '';
            salePrice = null;
            update();
          }
        },
      );
    } finally {
      isLoading = false;
    }
  }

  /// 显示商品sku picker
  Future showSkuPicker(BuildContext context) async {
    if (isLoading || isEdit) return;
    try {
      if (goodsId == null || goodsId.isEmpty) {
        app.showToast('请选择商品');
        return;
      }
      isLoading = true;
      final res = await getGoodsSkuKv(goodsId);
      final data = res.data ?? {};
      logger.i('sku data: $data');
      List items = data['data'] ?? [];
      if (items.isEmpty) {
        app.showToast('暂无商品规格');
        return;
      }

      /// 选项id集合
      List ids = items.map((item) => item['id']).toList();

      /// 当前下标
      int currentIndex = ids.indexOf(skuId);

      showPicker(
        context,
        selecteds: [currentIndex],
        options: items.map((item) => item['name']).toList(),
        onConfirm: (index) {
          String _id = items[index]['id'];
          if (skuId != _id) {
            skuName = items[index]['name'];
            skuId = _id;
            salePrice = items[index]['salePrice'];
            update();
          }
        },
      );
    } finally {
      isLoading = false;
    }
  }

  showPicker(
    BuildContext context, {
    List options,
    List<int> selecteds,
    Function onConfirm,
  }) {
    new Picker(
      adapter: PickerDataAdapter<String>(pickerdata: options ?? []),
      selecteds: selecteds,
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List value) {
        if (onConfirm is Function) {
          onConfirm(value[0]);
        }
      },
      cancelText: '取消',
      confirmText: '确定',
      itemExtent: 50,
      height: 300,
      confirmTextStyle: TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 20,
      ),
      cancelTextStyle: TextStyle(
        color: AppTheme.contentTextColor,
        fontSize: 20,
      ),
    ).showModal(context);
  }

  init(Map data) {
    if (data != null) {
      quantity = data['quantity'];
      salePrice = data['salePrice'];
      categoryName = data['categoryName'];
      categoryId = data['categoryId'];
      goodsName = data['goodsName'];
      goodsPictureUrl = data['goodsPictureUrl'];
      goodsId = data['goodsId'];
      skuName = data['skuName'];
      skuId = data['skuId'];
      _goods = data;
    }
    update();
  }

  reset() {
    quantity = null;
    salePrice = null;
    categoryName = '';
    categoryId = '';
    goodsName = '';
    goodsPictureUrl = '';
    goodsId = '';
    skuName = '';
    skuId = '';
    isEdit = false;
    update();
  }

  /// 删除商品
  handleRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('温馨提示'),
          content: Text('确定要移除此商品吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                final createController =
                    Get.find<OrderOfflineCreateController>();
                if (createController != null) {
                  createController.removeGoods(_goods);
                  _goods = null;
                }
                Get.back();
                Get.back();
                reset();
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  Future submit() async {
    if (categoryId == null || categoryId.isEmpty) {
      app.showToast('请选择商品分类');
      return;
    }
    if (goodsId == null || goodsId.isEmpty) {
      app.showToast('请选择商品');
      return;
    }
    if (skuId == null || skuId.isEmpty) {
      app.showToast('请选择商品规格');
      return;
    }
    if (quantity == null || quantity <= 0) {
      app.showToast('请输入商品数量');
      return;
    }
    final createController = Get.find<OrderOfflineCreateController>();
    if (createController != null) {
      createController.addGoods({
        'categoryName': categoryName,
        'categoryId': categoryId,
        'goodsName': goodsName,
        'goodsPictureUrl': goodsPictureUrl,
        'goodsId': goodsId,
        'skuName': skuName,
        'skuId': skuId,
        'quantity': quantity,
        'salePrice': salePrice,
      });
    }
    Get.back(result: true);
    reset();
  }
}
