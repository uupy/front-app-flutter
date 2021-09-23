import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
// import 'package:wine/common/http/request.dart';
import 'package:wine/fonts/iconfont.dart';

import 'controller.dart';

class OrderOfflineGoodsSelect extends StatefulWidget {
  @override
  _OrderOfflineGoodsSelectState createState() =>
      _OrderOfflineGoodsSelectState();
}

class _OrderOfflineGoodsSelectState extends State<OrderOfflineGoodsSelect> {
  final _controller = Get.put(OrderOfflineGoodsSelectController());
  bool isEdit = Get.parameters['isEdit'] == '1';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: '商品',
        actions: <Widget>[
          if (isEdit)
            IconButton(
              onPressed: () {
                _controller.handleRemove(context);
              },
              icon: Icon(
                IconFont.icon_remove,
                color: Colors.red,
                size: 24,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OrderOfflineGoodsSelectController>(
          builder: (c) {
            return Container(
              child: Column(
                children: [
                  formCard(),
                  formBtn(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget formCard() {
    String categoryName = _controller.categoryName ?? '';
    String goodsName = _controller.goodsName ?? '';
    String skuName = _controller.skuName ?? '';
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
        child: Column(
          children: [
            formItem(
              '商品分类',
              content: Text(
                categoryName.isEmpty ? '请选择' : categoryName,
                style: TextStyle(
                  color: categoryName.isEmpty
                      ? AppTheme.subTextColor
                      : AppTheme.contentTextColor,
                ),
              ),
              suffix: Icon(
                IconFont.icon_arrow_right,
                size: 20.sp,
              ),
              onTap: () {
                _controller.showCategoryPicker(context);
              },
            ),
            rowDivider(),
            formItem(
              '商品名称',
              content: Text(
                goodsName.isEmpty ? '请选择' : goodsName,
                style: TextStyle(
                  color: goodsName.isEmpty
                      ? AppTheme.subTextColor
                      : AppTheme.contentTextColor,
                ),
              ),
              suffix: Icon(
                IconFont.icon_arrow_right,
                size: 20.sp,
              ),
              onTap: () {
                _controller.showGoodsPicker(context);
              },
            ),
            rowDivider(),
            formItem(
              '商品规格',
              content: Text(
                skuName.isEmpty ? '请选择' : skuName,
                style: TextStyle(
                  color: skuName.isEmpty
                      ? AppTheme.subTextColor
                      : AppTheme.contentTextColor,
                ),
              ),
              suffix: Icon(
                IconFont.icon_arrow_right,
                size: 20.sp,
              ),
              onTap: () {
                _controller.showSkuPicker(context);
              },
            ),
            rowDivider(),
            formItem('商品价格',
                content: Text(
                  '${_controller.salePrice ?? ''}',
                )),
            rowDivider(),
            formItem(
              '商品数量',
              field: 'quantity',
              isNumber: true,
              onChanged: (value) {
                if (value != null && value != '') {
                  _controller.quantity = int.parse(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget rowDivider([double left]) {
    return Container(
      padding: EdgeInsets.only(left: left ?? 0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppTheme.bottomBorderColor,
      ),
    );
  }

  Widget formItem(
    String label, {
    String field,
    String hintText,
    bool isNumber,
    Widget content,
    Widget suffix,
    Function onTap,
    Function onChanged,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 5.w),
        child: Row(
          children: [
            Container(
              width: 70.w,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.w,
                ),
              ),
            ),
            if (content == null)
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    if (onChanged is Function) {
                      onChanged(value);
                    }
                  },
                  keyboardType: isNumber == true ? TextInputType.number : null,
                  decoration: InputDecoration(
                    hintText: hintText ?? '请输入$label',
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 12.w, bottom: 12.w),
                  child: content,
                ),
              ),
            if (suffix != null) suffix,
          ],
        ),
      ),
    );
  }

  Widget formBtn() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: ElevatedButton(
        child: Text(
          _controller.isSubmiting ? '提交中...' : '完成',
          style: TextStyle(
            fontSize: 17.sp,
          ),
        ),
        onPressed: () {
          _controller.submit();
        },
      ),
    );
  }
}
