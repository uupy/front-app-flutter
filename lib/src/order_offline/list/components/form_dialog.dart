import 'package:flutter/material.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

class FormDialog {
  BuildContext _context;
  // StateSetter _reloadStateSetter;
  dynamic _state;

  /// 打开弹窗
  open(BuildContext context, {state}) {
    _state = state;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        _context = context;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, stateSetter) {
              // _reloadStateSetter = stateSetter;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.fromLTRB(0, 5.h, 0, 10.h),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getDialogTitle(state),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.w,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  getDialogBody(state),
                ],
              );
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(13.w, 0, 13.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  footerButton(
                    '取消',
                    onPressed: () {
                      _handleCancel();
                    },
                  ),
                  footerButton(
                    '确定',
                    primary: true,
                    margin: EdgeInsets.only(left: 15.w),
                    onPressed: () {
                      _handleSubmit();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// 对话框按钮
  Widget footerButton(
    String text, {
    Function onPressed,
    bool primary,
    EdgeInsetsGeometry margin,
  }) {
    return Container(
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            primary == true
                ? AppTheme.primaryColor
                : AppTheme.buttonCancelColor,
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.fromLTRB(40.w, 15.w, 40.w, 15.w),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: primary == true ? Colors.white : AppTheme.primaryColor,
            fontSize: AppTheme.fontSize17,
          ),
        ),
      ),
    );
  }

  dynamic get state => _state;

  /// 对话框标题
  String getDialogTitle(state) {
    return '';
  }

  /// 对话框内容
  Widget getDialogBody(state) {
    return Container();
  }

  Future onSubmit() async {}
  void onClose() {}

  void submitSuccessCallback() {
    onClose();
    Navigator.of(_context).pop(true);
    app.showToast('操作成功');
  }

  void _handleCancel() {
    onClose();
    Navigator.of(_context).pop(false);
  }

  void _handleSubmit() async {
    await onSubmit();
    submitSuccessCallback();
  }
}
