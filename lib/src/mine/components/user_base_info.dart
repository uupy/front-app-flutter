import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/src/mine/controller.dart';
import 'package:wine/src/mine/model.dart';

class UserBaseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.w,
      child: GetBuilder<MineController>(
        builder: (c) {
          return Stack(
            children: [
              /// 主内容区
              Card(
                margin: EdgeInsets.only(top: 35.w),
                child: Column(
                  children: [
                    cardBody(c?.user),
                    Divider(
                      height: 5,
                      thickness: 1,
                      color: AppTheme.bottomBorderColor,
                    ),
                    cardFooter(c?.user),
                  ],
                ),
              ),

              userAvatar(c?.user),
            ],
          );
        },
      ),
    );
  }

  /// 用户头像
  Widget userAvatar(UserVo user) {
    String _avatar =
        'https://wine-oss-product.oss-cn-hangzhou.aliyuncs.com/app/images/default_avatar.png';
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          color: AppTheme.bottomBorderColor,
          borderRadius: BorderRadius.circular(70.w),
          image: DecorationImage(
            image: NetworkImage(user?.avatarUrl ?? _avatar),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// 用户基本信息
  Widget cardBody(UserVo user) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10.w, 44.w, 10.w, 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.w),
            child: Text(
              user?.name ?? '',
              style: TextStyle(fontSize: AppTheme.fontSize17),
            ),
          ),
          Text(
            user?.phoneNumber ?? '',
            style: TextStyle(
              fontSize: AppTheme.fontSize14,
              color: AppTheme.subTextColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 用户积分信息
  Widget cardFooter(UserVo user) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 12.w, 10.w, 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '积分：${user?.score ?? 0}',
              style: TextStyle(fontSize: 15.w),
            ),
          ),
          Container(
            width: 70.w,
            height: 30.w,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('my-score-record?totalScore=${user?.score ?? 0}');
              },
              child: Text('明细'),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 14.w,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.w),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.fromLTRB(10.w, 0, 10.w, 3.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
