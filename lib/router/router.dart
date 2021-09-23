import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wine/api/common.dart';
import 'package:wine/common/utils/utils.dart';
import 'package:wine/router/routes.dart';

class AppRoute {
  const AppRoute({
    @required this.name,
    @required this.page,
    this.transition,
    this.tabBar,
    this.children,
  }) : assert(name != null && page != null);

  /// 路由别名
  final String name;

  /// 页面
  final Widget page;

  /// transition
  final Transition transition;

  /// tabBar配置
  final BottomNavigationBarItem tabBar;

  /// 子项（占坑）
  final List<AppRoute> children;
}

GetPage routeToGetPage(AppRoute route) {
  Transition _transition = route.transition;
  if (_transition == null && route.tabBar == null) {
    _transition = Transition.rightToLeft;
  }
  return GetPage(
    name: route.name,
    page: () => route.page,
    transition: _transition,
    transitionDuration: Duration(milliseconds: 220),
  );
}

/// 路由管理
class AppRouter {
  /// 单例对象
  static AppRouter _instance;

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory AppRouter.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    _instance ??= AppRouter._internal();
    return _instance;
  }

  final String initialRoute = '/';

  /// 路由集合
  final List<AppRoute> _routes = routes;

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  AppRouter._internal();

  /// GetX 路由配置
  List<GetPage> get getPages =>
      _routes.where((r) => r.tabBar == null).map(routeToGetPage).toList();
}

AppRouter appRouter = AppRouter.getInstance();

class AppRouterController extends GetxController {
  bool hasNewVersion = false;
  String versionContent = '';
  String currentVersion = '';
  String newVersion = '';
  var versionInfo;
  var progressValue = 0.0;

  AppRouter router = appRouter;

  /// PageView控制器
  PageController pageController;

  /// tabBar当前下标
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex);
  }

  /// 切换导航tab
  void switchTabBar(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  /// 检查更新
  queryVersion() async {
    currentVersion = await Utils.getCurrentVersion();
    var res = await queryNewVersion({
      'terminalType': Platform.isAndroid ? 0 : 1,
      'currentVersion': currentVersion
    });
    versionInfo = res.data['data'];
    if (versionInfo != null) {
      hasNewVersion = true;
      versionContent = versionInfo['content'];
      newVersion = versionInfo['version'];
    }
    print('--- 检查更新, 是否有新版本: $hasNewVersion');
  }

  updateValue(value) {
    progressValue = double.parse(value);
    print('---- updateValue ---- $value');
    update();
  }
}
