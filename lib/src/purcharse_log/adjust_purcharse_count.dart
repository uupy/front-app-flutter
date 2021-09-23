import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/stock.dart';
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
                  padding: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '调整采购数量',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${(NumUtil.getNumByValueDouble(price, 2)).toStringAsFixed(2)}元',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 20,
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
                    style: TextStyle(fontSize: 18),
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
                margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.w),
                child: ElevatedButton(
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
                      fontSize: AppTheme.fontSize17,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 15.w, 20.w),
                child: ElevatedButton(
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
                      fontSize: AppTheme.fontSize17,
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

  await setPurchaseCount(
      {"adjustCount": purchaseCount, "purcharseId": currentStock['id']});
  purchaseTextFieldController.clear();
  Navigator.of(context).pop(true);

  app.showToast('操作成功');
}
