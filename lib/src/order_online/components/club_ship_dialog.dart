import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/order.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_dialog.dart';

class ClubShipDialog extends FormDialog {
  String deliveryName = '';
  String deliveryNumber = '';

  @override
  String getDialogTitle(state) {
    String orderId = '';
    if (state != null) {
      orderId = state.orderId;
    }
    return '配送发货($orderId)';
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
              hintText: '配送员名称',
              contentPadding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
              deliveryName = value;
            },
          ),
          Container(
            height: 10.w,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: '配送员电话',
              contentPadding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
              deliveryNumber = value;
            },
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    deliveryName = '';
    deliveryNumber = '';
  }

  @override
  Future onSubmit() async {
    super.onSubmit();
    if (deliveryName.isEmpty) {
      app.showToast('请输入配送员名称');
      return throw Error();
    }
    if (deliveryNumber.isEmpty) {
      app.showToast('请输入配送员电话');
      return throw Error();
    }
    var data = {
      'clubOrderId': this.state?.id,
      'deliveryName': deliveryName,
      'deliveryNumber': deliveryNumber,
    };
    print('post data: $data');
    await logisticsDelivery(data);
  }
}

ClubShipDialog clubShipDialog = ClubShipDialog();
