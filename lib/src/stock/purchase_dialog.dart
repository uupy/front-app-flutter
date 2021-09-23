import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/stock.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

final purchaseTextFieldController = TextEditingController();
double price;
showPurchaseConfirmDialog(context, currentStock) {
  price = currentStock['price'] ?? 0;
  print('--------- price ---------$price');
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 6.w, 0, 20.w),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '采购',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19.sp,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${(NumUtil.getNumByValueDouble(price, 2)).toStringAsFixed(2)}元',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 19.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: '请输入数量',
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
                    controller: purchaseTextFieldController,
                    onChanged: (value) {
                      double _num;
                      if (value != '') {
                        _num = double.parse(value) ?? 0;
                      } else {
                        _num = 0;
                        price = currentStock['price'];
                        state(() {});
                        return;
                      }
                      price = currentStock['price'];
                      price = price * _num;
                      state(() {});
                    },
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(12.w, 0, 15.w, 20.w),
                child: TextButton(
                  onPressed: () {
                    purchaseTextFieldController.clear();
                    Navigator.of(context).pop(false);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.buttonCancelColor,
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(
                        40.w,
                        15.w,
                        40.w,
                        15.w,
                      ),
                    ),
                  ),
                  child: Text(
                    '取消',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 12.w, 20.w),
                child: TextButton(
                  onPressed: () {
                    handlePurchase(context, currentStock);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.w,
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.primaryColor,
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(40.w, 15.w, 40.w, 15.w),
                    ),
                  ),
                  child: Text(
                    '确定',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

handlePurchase(context, currentStock) async {
  var purchaseCount = purchaseTextFieldController.text;
  if (purchaseCount == '') {
    app.showToast('请输入数量');
    return;
  }

  await stockPurchase({
    "purchaseCount": purchaseCount,
    "purchaseTime": Uri.decodeFull((DateTime.now()).format('Y-m-d H:i:s')),
    "remark": "",
    "skuId": currentStock['skuId']
  });

  // await setStock(
  //   {
  //     "adjustCount": purchaseCount,
  //     "remark": "",
  //     "skuId": currentStock['skuId']
  //   }
  // );
  purchaseTextFieldController.clear();
  Navigator.of(context).pop(true);

  app.showToast('操作成功');
}
