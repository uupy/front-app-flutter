import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/common/http/request.dart';
import 'package:wine/components/app_radio_group.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:wine/src/order_offline/goods_select/controller.dart';

import 'controller.dart';
// import 'model.dart';

class OrderOfflineCreate extends StatefulWidget {
  @override
  _OrderOfflineCreateState createState() => _OrderOfflineCreateState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

FocusNode _numberFocusNode;
TextEditingController _nameEditingController;

class _OrderOfflineCreateState extends State<OrderOfflineCreate> {
  final _controller = Get.put(OrderOfflineCreateController());

  @override
  void initState() {
    super.initState();
    _nameEditingController = new TextEditingController();
    _numberFocusNode = new FocusNode();
    _numberFocusNode.addListener(() {
      if (!_numberFocusNode.hasFocus) {
        _controller.handleContactNumberChange(success: (data) {
          final info = data['data'] ?? {};
          final user = info['user'] ?? {};
          logger.i('data: $info');
          logger.i('data user: $user');
          logger.i('data realName: ${user['realName']}');
          _nameEditingController.text = user['realName'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: '下单',
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OrderOfflineCreateController>(
          builder: (c) {
            return Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    formCard(),
                    formBtn(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget formCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
        child: Column(
          children: [
            formItem(
              '会员手机',
              isNumber: true,
              focusNode: _numberFocusNode,
              onChanged: (value) {
                _controller.form['contactNumber'] = value;
              },
            ),
            rowDivider(),
            formItem(
              '会员姓名',
              controller: _nameEditingController,
              onChanged: (value) {
                _controller.form['contactName'] = value;
              },
            ),
            rowDivider(),
            formItem('所属创客', content: Text(_controller.promoter['name'] ?? '')),
            rowDivider(),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  goodsList(),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('order-offline-goods-select');
                    },
                    child: Text(
                      '添加商品',
                      style: TextStyle(
                        color: Color(0xfff0079FE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            rowDivider(),
            formItem(
              '订单金额',
              content: Text('${_controller.totalPrice ?? ''}'),
            ),
            rowDivider(),
            formItem(
              '优惠金额',
              isNumber: true,
              onChanged: (value) {
                _controller.form['couponAmount'] = value;
                _controller.updatePrice();
              },
            ),
            rowDivider(),
            formItem(
              '优惠备注',
              isNumber: true,
              onChanged: (value) {
                _controller.form['remark'] = value;
              },
            ),
            rowDivider(),
            formItem(
              '实付金额',
              content: Text('${_controller.realAmount ?? ''}'),
            ),
            rowDivider(),
            formItem(
              '优惠承担',
              content: AppRadioGroup(
                value: _controller.form['couponType'],
                items: [
                  AppRadio(label: Text('共同承担'), value: 0),
                  AppRadio(label: Text('体验馆'), value: 1),
                  AppRadio(label: Text('创客'), value: 2),
                ],
                onChanged: (value) {
                  _controller.form['couponType'] = value;
                },
              ),
            ),
            rowDivider(),
            formItem(
              '是否支付',
              content: AppRadioGroup(
                useWrap: true,
                value: _controller.form['paymentStatus'],
                items: [
                  AppRadio(label: Text('未支付'), value: 0),
                  AppRadio(label: Text('已支付'), value: 1),
                ],
                onChanged: (value) {
                  _controller.form['paymentStatus'] = value;
                  _controller.update();
                },
              ),
            ),
            rowDivider(),
            if (_controller.form['paymentStatus'] == 1)
              formItem(
                '支付类型',
                content: AppRadioGroup(
                  useWrap: true,
                  value: _controller.form['paymentType'],
                  items: [
                    AppRadio(label: Text('微信'), value: 0),
                    AppRadio(label: Text('支付宝'), value: 1),
                    AppRadio(label: Text('现金'), value: 2),
                  ],
                  onChanged: (value) {
                    _controller.form['paymentType'] = value;
                  },
                ),
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

  Widget goodsList() {
    final itemList = _controller.goodsList;
    return Container(
      padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
      child: Column(
        children: itemList.map((goods) => goodsItemRow(goods)).toList(),
      ),
    );
  }

  /// 每条商品信息
  Widget goodsItemRow(Map goods) {
    double price = goods['salePrice'];
    int quantity = goods['quantity'];

    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 5.w, 10.w, 5.w),
      child: GestureDetector(
        onTap: () {
          final _c = Get.put(OrderOfflineGoodsSelectController());
          if (_c != null) {
            _c.init(goods);
            Get.toNamed('order-offline-goods-select?isEdit=1').then((value) {
              _c.reset();
            });
          }
        },
        child: Row(
          children: [
            Container(
              child: Container(
                width: 60.w,
                height: 60.w,
                margin: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  color: AppTheme.bottomBorderColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      goods['goodsPictureUrl'],
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(goods['goodsName']),
                      ),
                      Text(
                        '￥$price',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                  Container(height: 5.w),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          goods['skuName'],
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppTheme.subTextColor,
                          ),
                        ),
                      ),
                      Text(
                        'x$quantity',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppTheme.subTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.w),
              child: Icon(
                IconFont.icon_arrow_right,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formItem(
    String label, {
    String hintText,
    bool isNumber,
    Widget content,
    Widget suffix,
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
  }) {
    return Padding(
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
                controller: controller,
                focusNode: focusNode,
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
                margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
                child: content,
              ),
            ),
          if (suffix != null) suffix,
        ],
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
          _controller.create();
        },
      ),
    );
  }
}
