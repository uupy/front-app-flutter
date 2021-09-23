import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wine/api/common.dart';
import 'package:wine/common/app_store.dart';
import 'package:wine/router/router.dart';
import 'package:wine/common/app.dart';

void main() {
  /// 设置沉浸式状态栏（需要在runApp前）
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(
    ScreenUtilInit(
      designSize: Size(375, 818),
      builder: () => GetMaterialApp(
        /// 主题设置
        theme: app.themeData,
        home: RootApp(),
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        initialRoute: appRouter.initialRoute,
        getPages: appRouter.getPages,
        unknownRoute: appRouter.getPages[0],
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class RootApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootApp();
  }
}

class _RootApp extends State<RootApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    String _token = await authToken.get();
    if (_token != null && _token.isNotEmpty) {
      final res = await getUserInfo();
      final data = res.data['data'];
      await loginUser.set(data);
      Get.offNamed('index');
      return null;
    }
    Get.offNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    app.init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 88.w,
          height: 88.w,
          margin: EdgeInsets.only(bottom: 100.w),
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
