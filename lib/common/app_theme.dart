import 'package:flutter/material.dart';

/// 应用主题
class AppTheme {
  AppTheme._();

  /// 主题色
  static const Color primaryColor = Color(0xffF11B27);

  /// 警告颜色
  static const Color warningColor = Color(0xfffdb31a);

  /// 文字颜色
  /// 标题文本颜色
  static const Color titleTextColor = Colors.black;

  /// 正文文本颜色
  static const Color contentTextColor = Color(0xff333333);

  /// 辅助文本颜色
  static const Color helpTextColor = Color(0xff666666);

  /// 说明文本颜色
  static const Color subTextColor = Color(0xff999999);

  /// button 文本颜色
  static const Color buttonTextColor = Colors.black;

  /// button 背景色
  static const Color buttonBackgroundColor = Colors.white;

  /// 取消按钮颜色
  static const Color buttonCancelColor = Color(0xffFFEBEC);

  /// icon 颜色
  static const Color iconColor = Color(0xff888888);

  /// 底部边框颜色
  static const Color bottomBorderColor = Color(0xfff2f2f2);

  /// 背景色
  /// 页面内容背景色
  static const Color bodyBackgroundColor = Color(0xfff9f9f9);

  /// toast 背景颜色
  static const Color toastBackgroundColor = Color(0xff555555);

  /// textField border颜色
  static const Color textFieldBorderColor = Color(0xffededed);

  /// 字号
  static const double fontSize16 = 16.0;
  static const double fontSize14 = 14.0;
  static const double fontSize17 = 17.0;

  /// 圆角大小
  static const double radius10 = 10.0;
  static const double radius15 = 15.0;
}
