import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/order.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_dialog.dart';

class OrderCancelDialog extends FormDialog {
  @override
  String getDialogTitle(state) {
    String orderId = '';
    if (state != null) {
      orderId = state.id;
    }
    return '订单取消($orderId)';
  }

  @override
  Widget getDialogBody(state) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 30.w),
      child: Text('请确认是否取消订单'),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future onSubmit() async {
    super.onSubmit();
    await cancelOrderOffline(this.state?.id);
  }
}

OrderCancelDialog orderCancelDialog = OrderCancelDialog();
