import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

import 'controller.dart';
import 'model.dart';

class MyPromotionDetails extends StatefulWidget {
  @override
  _MyPromotionDetailsState createState() => _MyPromotionDetailsState();
}

class _MyPromotionDetailsState extends State<MyPromotionDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: '用户详情',
        result: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.fromLTRB(15.w, 20.w, 15.w, 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: GetBuilder<MyPromotionController>(
              builder: (c) {
                MyPromotionVo item = c.currentUser ?? {};
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextItems('用户昵称', getConText(item.newUserNickname)),
                    buildTextItems('用户名称', getConText(item.newUserRealName)),
                    buildTextItems('用户电话', getConText(item.newUserTelephone)),
                    buildTextItems('订单金额', '￥${item.orderAmount}'),
                    buildTextItems('订单数量', item.orderCount),
                    buildTextItems('注册时间', item.createTime),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextItems(text, value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      child: Text(
        '$text：$value',
        style: TextStyle(color: AppTheme.subTextColor),
      ),
    );
  }

  String getConText(String content) {
    if (content == null || content.isEmpty) {
      return '未绑定';
    }
    return content;
  }
}
