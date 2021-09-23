import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/components/app_list_title.dart';
import 'package:wine/src/mine/components/user_base_info.dart';
import 'package:wine/src/mine/controller.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPage();
  }
}

class _MyPage extends State with AutomaticKeepAliveClientMixin {
  final _controller = Get.put(MineController());

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    _controller.getUser();
    _controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: AppTheme.primaryColor,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Stack(
        children: [
          // 背景色块
          Positioned(
            child: Container(
              color: AppTheme.primaryColor,
              height: 160,
            ),
          ),
          Container(
            child: RefreshIndicator(
              onRefresh: () => _controller.fetchData(),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15.w, 35.h, 15.w, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: GetBuilder<MineController>(
                    builder: (c) {
                      return Column(
                        children: [
                          UserBaseInfo(),
                          menuCards(c.menusList),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuCards(List<List<MineMenu>> menusList) {
    return Column(
      children: [
        Container(
          height: 10.w,
        ),
        ...menusList.map((menus) {
          return Card(
            margin: EdgeInsets.only(bottom: 10.w),
            child: Column(
              children: [
                ...menus.asMap().keys.map((i) {
                  return Column(
                    children: [
                      if (i != 0)
                        Container(
                          padding: EdgeInsets.only(left: 50.w),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: AppTheme.bottomBorderColor,
                          ),
                        ),
                      AppListTitle(
                        icon: menus[i].icon,
                        title: menus[i].name,
                        onTap: () {
                          handleActions(menus[i]);
                        },
                      )
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void handleActions(MineMenu item) async {
    if (item.path != '') {
      Get.toNamed('${item.path}?title=${item.name}&key=${item.key}');
    } else if (item.key == 'logout') {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('确定要退出吗？'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  app.logout();
                },
                child: Text('确定'),
              ),
            ],
          );
        },
      );
    }
  }
}
