import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wine/common/app_store.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/common/app_theme_data.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:wine/index.dart';

/// 封装一些常用的东西
class App {
  /// 单例对象
  static App _instance;

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  App._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory App.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    _instance ??= App._internal();
    return _instance;
  }

  /// MaterialApp主题配置
  ThemeData themeData = appThemeData;

  /// 状态栏高度
  double statusBarHeight;

  /// 应用初始化
  void init(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
  }

  /// 设置状态栏颜色
  void setStatusBarColor({
    Color statusBarColor,
    Brightness statusBarIconBrightness,
  }) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? AppTheme.primaryColor,
      statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// showToast
  void showToast(String msg) {
    if (msg.isNotEmpty) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppTheme.toastBackgroundColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  /// 退出登录
  Future logout() async {
    final indexController = Get.find<IndexController>();
    await authToken.remove();
    await loginUser.remove();

    if (indexController != null) {
      indexController.currentIndex = 0;
    }

    /// 防止重复跳转
    if (Get.currentRoute != 'login') {
      Get.offAllNamed('login');
    }
  }

  /// 设置appBar
  setAppBar({
    String title,
    Brightness brightness,
    Color backgroundColor,
    Color textColor,
    double height,
    List actions,
    bool result,
  }) {
    return PreferredSize(
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor ?? AppTheme.primaryColor,
        brightness: brightness ?? Brightness.dark,
        leading: IconButton(
          icon: Icon(
            IconFont.icon_arrow_left,
            color: textColor,
          ),
          onPressed: () {
            Get.back(result: result ?? false);
          },
        ),
        title: Text(
          '$title',
          style: TextStyle(
            color: textColor,
          ),
        ),
        actions: actions,
      ),
      preferredSize: Size.fromHeight(height ?? 50.w),
    );
  }
}

final App app = App.getInstance();
