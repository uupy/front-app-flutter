import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/fonts/iconfont.dart';

import 'controller.dart';
import 'model.dart';

class MyWalletIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyWalletIndex();
  }
}

class _MyWalletIndex extends State {
  final _controller = Get.put(MyWalletController());

  @override
  void initState() {
    super.initState();
    _controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        title: _controller.title ?? '我的钱包',
        brightness: Brightness.dark,
      ),
      body: Stack(
        children: [
          // 背景色块
          Positioned(
            child: Container(
              color: AppTheme.primaryColor,
              height: 62.w,
            ),
          ),
          RefreshIndicator(
            onRefresh: () => _controller.fetchData(),
            child: GetBuilder<MyWalletController>(
              builder: (c) {
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.w, 12.w, 10.w, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        baseInfoCard(),
                        menuCard(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 基本信息
  Widget baseInfoCard() {
    WalletVo info = _controller.detail;

    return Card(
      margin: EdgeInsets.only(bottom: 10.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            children: [
              Text(
                '${info?.balanceAmount ?? 0}',
                style: TextStyle(
                  fontSize: 36.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5.w, 0, 15.w),
                child: Text(
                  '账户余额 (元)',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppTheme.subTextColor,
                  ),
                ),
              ),
              Container(
                width: 180.w,
                height: 40.w,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(16.w, 2.w, 16.w, 2.w),
                    ),
                  ),
                  child: Text(
                    '提现',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  onPressed: () {
                    String cardId = _controller.cardId ?? '';
                    if (_controller.loading) return;
                    if (cardId.isNotEmpty) {
                      String params =
                          'walletId=${info.id}&balanceAmount=${info.balanceAmount}&cardId=$cardId';
                      Get.toNamed('my-withdraw-apply?$params')
                          .then((value) => {_controller.fetchData()});
                    } else {
                      app.showToast('请先绑定银行卡');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// menuRow
  Widget menuRow({
    IconData icon,
    double iconSize,
    String title,
    Function onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(15.w, 5.h, 13.w, 5.h),
      leading: Container(
        width: 25.w,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: iconSize ?? 20.sp,
        ),
      ),
      minLeadingWidth: 20.w,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
        ),
      ),
      trailing: Icon(
        IconFont.icon_arrow_right,
        size: 15.sp,
      ),
      onTap: onTap,
    );
  }

  /// 导航菜单
  Widget menuCard() {
    WalletVo info = _controller.detail;
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
        child: Column(
          children: [
            menuRow(
              icon: IconFont.icon_mingxi,
              title: '分润明细',
              onTap: () {
                Get.toNamed('my-profit?walletId=${info.id}');
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 55.w),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.bottomBorderColor,
              ),
            ),
            menuRow(
              icon: IconFont.icon_card,
              iconSize: 15.sp,
              title: '银行卡',
              onTap: () {
                Get.toNamed('my-wallet-card?walletId=${info.id}')
                    .then((value) => _controller.fetchData());
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 55.w),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.bottomBorderColor,
              ),
            ),
            menuRow(
              icon: IconFont.icon_record,
              title: '提现记录',
              onTap: () {
                Get.toNamed('my-withdraw-record?walletId=${info.id}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
