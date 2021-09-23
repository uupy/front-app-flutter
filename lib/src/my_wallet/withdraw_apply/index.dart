import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/common/extension/string_extension.dart';

import 'controller.dart';

class MyWithdrawApply extends StatefulWidget {
  @override
  _MyWithdrawApplyState createState() => _MyWithdrawApplyState();
}

class _MyWithdrawApplyState extends State<MyWithdrawApply> {
  String walletId = Get.parameters['walletId'];
  String cardId = Get.parameters['cardId'];
  String balanceAmount = Get.parameters['balanceAmount'];
  Map form = {"amount": "", "cardId": "", "walletId": ""};
  TextEditingController textController = TextEditingController();
  final _controller = Get.put(MyWithdrawApplyController());

  @override
  void initState() {
    super.initState();
    form['walletId'] = walletId;
    form['cardId'] = cardId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: '提现申请',
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MyWithdrawApplyController>(
          builder: (c) {
            return Container(
              margin: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  formCard(),
                  Container(
                    padding: EdgeInsets.only(top: 20.h),
                    child: ElevatedButton(
                      child: Text(
                        c.isSubmiting ? '提交中...' : '提现',
                        style: TextStyle(
                          fontSize: 17.w,
                        ),
                      ),
                      onPressed: () {
                        if (c.isSubmiting) return;
                        handleSubmit();
                      },
                    ),
                  )
                ],
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
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '提现金额',
                style: TextStyle(
                  fontSize: 13.w,
                  color: AppTheme.subTextColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 13.w,
                bottom: 13.w,
              ),
              child: Row(
                children: [
                  Text(
                    '￥',
                    style: TextStyle(
                      fontSize: 42.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      child: TextField(
                        controller: textController,
                        onChanged: (value) {
                          form['amount'] = value;
                          if (value.parseDouble() >
                              balanceAmount.parseDouble()) {
                            textController.text = balanceAmount;
                            form['amount'] = value;
                          }
                        },
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
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
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    '当前余额剩余${balanceAmount ?? 0}元',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppTheme.subTextColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    textController.text = balanceAmount;
                    form['amount'] = balanceAmount;
                  },
                  child: Text(
                    '全部提现',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleSubmit() async {
    if (form['amount'].isEmpty) {
      app.showToast('请输入提现金额');
      return;
    }
    _controller.submit(form);
  }

  @override
  dispose() {
    super.dispose();
    textController.dispose();
  }
}
