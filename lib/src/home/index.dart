import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/app_store.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/router/router.dart';
import 'package:wine/src/home/home_banner.dart';
import 'package:wine/src/home/home_my_promote.dart';
import 'package:wine/src/home/home_sales_top.dart';
import 'package:wine/src/mine/model.dart';

import 'home_club.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPage();
  }
}

final routerController = Get.put(AppRouterController());

class _IndexPage extends State with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int userRole = 0;

  @override
  void initState() {
    initPage();

    /// 延时2s 检测更新
    Future.delayed(Duration(seconds: 1), handleNewVersion);
    super.initState();
  }

  void initPage() async {
    final info = await loginUser.get();
    final UserVo user = UserVo.fromJson(info ?? {});
    setState(() {
      userRole = user?.isAdmin == true ? -1 : user?.roleType?.value;
    });
  }

  /// 下拉刷新
  Future refreshPage() async {
    await Future.wait([
      getAds(),
      if (userRole == -1 || userRole == 1) getClubData(),
      getMyPromoteDatas(),
      if (userRole != 0) getSalesTopData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData _rootThemeData = Theme.of(context); // 获取默认主题
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('首页'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        brightness: Brightness.dark,
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 100,
              color: AppTheme.primaryColor,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 30,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: RefreshIndicator(
              onRefresh: () {
                print('--------- 下拉刷新 ----------');
                return refreshPage();
              },
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// banner
                      HomeBanner(),

                      /// 业务统计
                      if (userRole == -1 || userRole == 1) HomeClub(),

                      /// 我的推广统计
                      MyPromote(),

                      /// 销量排行
                      if (userRole != 0) HomeSalesTop(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  /// 检查更新
  handleNewVersion() async {
    await routerController.queryVersion();
    print('------ 检查更新 ------ ${routerController.versionInfo}');
    if (routerController.hasNewVersion) {
      /// 有新版本
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('版本更新'),
            content: Text(
              '版本：${routerController.newVersion} \n ${routerController.versionContent}',
            ),
            actions: [
              if (routerController.versionInfo['upgradeType']['value'] != 0)
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('取消'),
                ),
              TextButton(
                onPressed: () {
                  Get.back();
                  handleUpdateApp(routerController.versionInfo, context);
                },
                child: Text('更新'),
              ),
            ],
          );
        },
      );
    }
  }

  /// 更新操作
  handleUpdateApp(info, context) async {
    print('--- platform ${Platform.isAndroid}');
    if (Platform.isAndroid) {
      downLoadApk(info, context);
    } else {
      /// iOS 跳转商店
      if (await canLaunch(info['fileUrl'])) {
        await launch(info['fileUrl']);
      } else {
        app.showToast('无法跳转应用商店');
      }
    }
  }

  Future<void> downLoadApk(info, context) async {
    String url = '';
    if (info != null && info != '') {
      url = info['fileUrl'];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('版本更新'),
          content: GetBuilder<AppRouterController>(
            builder: (controller) {
              return Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        child: Text('正在更新中...'),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          '${controller.progressValue}%',
                        ),
                      )
                    ],
                  ));
            },
          ),
          actions: [],
        );
      },
    );
    try {
      OtaUpdate()
          .execute(url, destinationFilename: 'luoyang_laojiu.apk')
          .listen(
        (OtaEvent event) {
          print(
              '-------- 下载中 --------- ${event.value}% ${OtaStatus.INSTALLING}');
          setState(() {
            if (event.value != '') {
              routerController.updateValue(event.value);
            }
          });
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }
}
