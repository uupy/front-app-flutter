import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';

/// 配置MaterialApp主题
final ThemeData appThemeData = ThemeData(
  primaryColor: AppTheme.primaryColor,
  backgroundColor: Colors.black,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    headline2: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    headline3: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    headline4: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    headline5: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    headline6: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    subtitle1: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    subtitle2: TextStyle(
      color: AppTheme.contentTextColor,
    ),
    bodyText1: TextStyle(
      fontSize: AppTheme.fontSize16,
      color: AppTheme.contentTextColor,
    ),
    bodyText2: TextStyle(
      fontSize: AppTheme.fontSize16,
      color: AppTheme.contentTextColor,
    ),
    button: TextStyle(
      fontSize: AppTheme.fontSize14,
      color: AppTheme.contentTextColor,
    ),
  ),

  /// 输入框
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppTheme.textFieldBorderColor,
        width: 1,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppTheme.helpTextColor,
        width: 1,
      ),
    ),
  ),

  // 字体主题
  iconTheme: IconThemeData(color: AppTheme.iconColor),

  /// 有背景的button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        Size(double.infinity, 10.w),
      ),
      backgroundColor: MaterialStateProperty.all(AppTheme.primaryColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: AppTheme.fontSize17,
        ),
      ),

      /// 形状、圆角
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.fromLTRB(16.w, 15.w, 16.w, 15.w),
      ),
    ),
  ),

  /// 有边框的button
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        Size(70.w, 10.w),
      ),
      textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: AppTheme.fontSize14, color: AppTheme.contentTextColor)),
      backgroundColor:
          MaterialStateProperty.all(AppTheme.buttonBackgroundColor),
      foregroundColor: MaterialStateProperty.all(
        AppTheme.buttonTextColor,
      ),
      side: MaterialStateProperty.all(
        BorderSide(
          color: Color(0xffEBEBEB),
          width: 1,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
      ),
    ),
  ),

  /// TextButton 无边框无背景
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        Size(70.w, 10.w),
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: AppTheme.fontSize14,
          color: AppTheme.contentTextColor,
        ),
      ),
      foregroundColor: MaterialStateProperty.all(
        AppTheme.buttonTextColor,
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
      ),
    ),
  ),

  /// 卡片主题
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.w),
      ),
    ),
  ),
);
