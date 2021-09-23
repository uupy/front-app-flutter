import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/order.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_dialog.dart';

class OrderPaidDialog extends FormDialog {
  @override
  String getDialogTitle(state) {
    String orderId = '';
    if (state != null) {
      orderId = state.id;
    }
    return '付款确认($orderId)';
  }

  @override
  Widget getDialogBody(state) {
    String realAmount = '';
    if (state != null) {
      realAmount = state.realAmount?.toString();
    }
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 30.w),
      child: Text('请确认已收到付款金额：￥$realAmount'),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future onSubmit() async {
    super.onSubmit();
    await paidOrderOffline(this.state?.id);
  }
}

OrderPaidDialog orderPaidDialog = OrderPaidDialog();
