import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

import 'controller.dart';
import 'model.dart';

class MyWalletCard extends StatefulWidget {
  @override
  _MyWalletCardState createState() => _MyWalletCardState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _MyWalletCardState extends State<MyWalletCard> {
  String walletId = Get.parameters['walletId'];
  Map form = {
    "cardNumber": "",
    "openingBank": "",
    "openingSubBank": "",
    "ownerIdCardNo": "",
    "ownerName": "",
    "ownerPhoneNumber": "",
    "walletId": ""
  };
  final _controller = Get.put(MyWalletCardController());
  @override
  void initState() {
    super.initState();
    print('MyWalletCard initState');
    form['walletId'] = walletId;
    _controller.fetchData(walletId: walletId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: '绑定银行卡',
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MyWalletCardController>(
          builder: (c) {
            bool isBind = c.detail == null;
            return Container(
              margin: EdgeInsets.all(10.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    formCard(),
                    Container(
                      padding: EdgeInsets.only(top: 20.h),
                      child: ElevatedButton(
                        child: Text(
                          c.isSubmiting ? '提交中...' : (isBind ? '绑定' : '解除绑定'),
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                        ),
                        onPressed: () {
                          if (isBind) {
                            handleBind();
                          } else {
                            c.unbind(c.detail?.id);
                          }
                        },
                      ),
                    )
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
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        child: Column(
          children: [
            formItem('开户名', field: 'ownerName'),
            rowDivider(),
            formItem('开户银行', field: 'openingBank'),
            rowDivider(),
            formItem('开户支行', field: 'openingSubBank'),
            rowDivider(),
            formItem(
              '银行卡号',
              field: 'cardNumber',
              isNumber: true,
            ),
            rowDivider(),
            formItem('身份证号', field: 'ownerIdCardNo'),
            rowDivider(),
            formItem(
              '手机号',
              field: 'ownerPhoneNumber',
              isNumber: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget rowDivider() {
    return Container(
      padding: EdgeInsets.only(left: 15.w),
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
  }) {
    WalletCardVo info = _controller.detail;
    Map row = info?.toJson();

    return Padding(
      padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
          if (info == null)
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.right,
                onChanged: (value) {
                  form[field] = value;
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
                margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
                alignment: Alignment.centerRight,
                child: Text(row[field] ?? ''),
              ),
            )
        ],
      ),
    );
  }

  void handleBind() async {
    if (form['ownerName'].isEmpty) {
      app.showToast('请输入开户名');
      return;
    }
    if (form['openingBank'].isEmpty) {
      app.showToast('请输入开户银行');
      return;
    }
    if (form['openingSubBank'].isEmpty) {
      app.showToast('请输入开户支行');
      return;
    }
    if (form['cardNumber'].isEmpty) {
      app.showToast('请输入银行卡号');
      return;
    }
    if (form['ownerIdCardNo'].isEmpty) {
      app.showToast('请输入身份证号');
      return;
    }
    if (form['ownerPhoneNumber'].isEmpty) {
      app.showToast('请输入手机号');
      return;
    }
    print('form data: $form');
    await _controller.bind(form);
    form.clear();
  }
}
