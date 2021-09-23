import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppListTitle extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String title;
  final Function onTap;

  AppListTitle({
    this.icon,
    this.iconSize,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}
