import 'package:flutter/material.dart';
import 'package:wine/api/stock.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

final purchaseTextFieldController = TextEditingController();
final remarkTextFieldController = TextEditingController();
showAdjustConfirmDialog(context, currentStock) {
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
                          '调整库存',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 16.sp),
                          decoration: InputDecoration(
                            // hintText: '${currentStock['stockCount']}',
                            hintText: '请输入数量',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.w),
                              ),
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
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                        child: TextField(
                          maxLines: 2,
                          style: TextStyle(fontSize: 16.sp),
                          decoration: InputDecoration(
                            hintText: "请输入备注",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.w),
                              ),
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
                          controller: remarkTextFieldController,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  5.w,
                  0,
                  15.w,
                  20.w,
                ),
                child: TextButton(
                  onPressed: () {
                    purchaseTextFieldController.clear();
                    remarkTextFieldController.clear();
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
                margin: EdgeInsets.fromLTRB(
                  0,
                  0,
                  10.w,
                  20.w,
                ),
                child: TextButton(
                  onPressed: () {
                    handlePurchase(context, currentStock);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.primaryColor,
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
  var adjustCount = purchaseTextFieldController.text;
  var remark = remarkTextFieldController.text;
  if (adjustCount == '') {
    app.showToast('请输入数量');
    return;
  }

  await setStock({
    "adjustCount": adjustCount,
    "remark": remark,
    "skuId": currentStock['skuId']
  });
  purchaseTextFieldController.clear();
  remarkTextFieldController.clear();
  Navigator.of(context).pop(true);
  app.showToast('操作成功');
}
