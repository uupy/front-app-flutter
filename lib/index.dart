import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app_store.dart';
import 'package:wine/common/http/request.dart';
import 'package:wine/src/home/index.dart';
import 'package:wine/src/mine/model.dart';
import 'package:wine/src/order/index.dart';
import 'package:wine/src/stock/index.dart';
import 'package:wine/src/mine/mine.dart';

import 'common/app_theme.dart';
import 'fonts/iconfont.dart';

class TabBarRoute {
  const TabBarRoute({
    @required this.page,
    @required this.navBarItem,
    this.permission,
  }) : assert(page != null && navBarItem != null);
  final Widget page;
  final BottomNavigationBarItem navBarItem;
  final List<int> permission;
}

class IndexController extends GetxController {
  /// PageView控制器
  PageController pageController;

  /// tabBar当前下标
  int currentIndex = 0;

  List<TabBarRoute> fullRoutes = [
    TabBarRoute(
      page: HomePage(),
      navBarItem: BottomNavigationBarItem(
        label: '首页',
        icon: Icon(IconFont.icon_home1),
        activeIcon: Icon(IconFont.icon_home_fill),
      ),
    ),
    TabBarRoute(
      page: Stock(),
      navBarItem: BottomNavigationBarItem(
        label: '库存',
        icon: Icon(IconFont.icon_inspection),
        activeIcon: Icon(IconFont.icon_inspection_fill),
      ),
      permission: [-1],
    ),
    TabBarRoute(
      page: Order(),
      navBarItem: BottomNavigationBarItem(
        label: '订单',
        icon: Icon(IconFont.icon_default_template),
        activeIcon: Icon(IconFont.icon_default_template_fill),
      ),
      permission: [-1, 1, 2],
    ),
    TabBarRoute(
      page: MyPage(),
      navBarItem: BottomNavigationBarItem(
        label: '我的',
        icon: Icon(IconFont.icon_bussiness_man),
        activeIcon: Icon(IconFont.icon_bussiness_man_fill),
      ),
    ),
  ];

  /// tabBar页面
  List<Widget> pages = [];

  /// tabBar导航集合
  List<BottomNavigationBarItem> navs = [];

  @override
  void onInit() async {
    super.onInit();
    await onInitPage();
    pageController = PageController(initialPage: currentIndex);
  }

  Future onInitPage() async {
    final info = await loginUser.get();
    final UserVo user = UserVo.fromJson(info ?? {});
    int userRole = user?.isAdmin == true ? -1 : user?.roleType?.value;
    logger.i('login userRole: $userRole');
    pages = [];
    navs = [];
    fullRoutes.forEach((route) {
      if (route.permission == null || route.permission.contains(userRole)) {
        pages.add(route.page);
        navs.add(route.navBarItem);
      }
    });
    update();
  }

  /// 切换导航tab
  void switchTabBar(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    update();
  }
}

class IndexPage extends StatelessWidget {
  final routerController = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IndexController>(
        builder: (c) {
          return PageView(
            controller: c.pageController,
            children: c.pages,
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
          );
        },
      ),

      /// 底部导航栏
      bottomNavigationBar: GetBuilder<IndexController>(
        builder: (c) {
          if (c.navs.length < 2) {
            return Container();
          }
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: Colors.black54,
            currentIndex: c.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              c.switchTabBar(index);
            },
            items: c.navs,
          );
        },
      ),
    );
  }
}
