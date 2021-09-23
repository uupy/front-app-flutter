import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/order.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_dialog.dart';

class LogisticsShipDialog extends FormDialog {
  String logisticsName = '';
  String logisticsNumber = '';

  @override
  String getDialogTitle(state) {
    String orderId = '';
    if (state != null) {
      orderId = state.orderId;
    }
    return '物流发货($orderId)';
  }

  @override
  Widget getDialogBody() {
    return Container(
      child: Column(
        children: [
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: '物流公司名称',
              contentPadding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 5.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                borderSide: BorderSide(
                  color: Color(0xff707070),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff707070),
                  width: 1,
                ),
              ),
            ),
            onChanged: (value) {
              logisticsName = value;
            },
          ),
          Container(
            height: 10.w,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: '物流单号',
              contentPadding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 5.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                borderSide: BorderSide(
                  color: Color(0xff707070),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff707070),
                  width: 1,
                ),
              ),
            ),
            onChanged: (value) {
              logisticsNumber = value;
            },
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    logisticsName = '';
    logisticsNumber = '';
  }

  @override
  Future onSubmit() async {
    super.onSubmit();
    if (logisticsName.isEmpty) {
      app.showToast('请输入物流公司名称');
      return throw Error();
    }
    if (logisticsNumber.isEmpty) {
      app.showToast('请输入物流单号');
      return throw Error();
    }
    var data = {
      'clubOrderId': this.state?.id,
      'logisticsName': logisticsName,
      'logisticsNumber': logisticsNumber,
    };
    await logisticsDelivery(data);
  }
}

LogisticsShipDialog logisticsShipDialog = LogisticsShipDialog();
