import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/api/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/app_store.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/common/http/request.dart';
import 'package:wine/index.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isLoading = false;
  String userName;
  String password;

  @override
  initState() {
    super.initState();
    checkAgreementAcceptStatus();
  }

  checkAgreementAcceptStatus() async {
    String hasAccept = await hasAcceptAgreement.get();
    if (hasAccept != '1') {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('温馨提示'),
            content: Container(
              height: 220,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('欢迎您使用老酒客'),
                    ),
                    Container(
                      child: Text('请你务必审慎阅读、充分理解”使用协议”和“隐私政策”各条款，包括但不限于:'),
                    ),
                    Container(
                      child: Text('1.为了向你提供内容分享等服务， 我们需要收集你的设备信息、操作日志等个人信息。'),
                    ),
                    Container(
                      child: Text('2.你可以在“设置”中查看、变更、删除个人信息并管理你的授权。'),
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: AppTheme.contentTextColor,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(text: '3.你可阅读'),
                            textSpanButton('《使用协议》', () {
                              Navigator.of(context)
                                  .pushNamed('using-agreement');
                            }),
                            TextSpan(text: '和'),
                            textSpanButton('《隐私政策》', () {
                              Navigator.of(context)
                                  .pushNamed('register-agreement');
                            }),
                            TextSpan(text: '了解详细信息。如你同意，请点击"同意”开始接受我们的服务。'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await hasAcceptAgreement.set('1');
                  Get.back();
                },
                child: Text('同意'),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(double.infinity, 10.w),
                  ),
                ),
                child: Text('不同意'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: AppTheme.primaryColor,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 100.w,
                child: Form(
                  key: loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: 162.w,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 750.w,
                                    height: 120.w,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: new BorderRadius.vertical(
                                        bottom: Radius.elliptical(200.w, 40.w),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 162.w,
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 5.w,
                                          color: Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      child:
                                          Image.asset('assets/images/logo.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 36.w),
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10.w),
                                          color: Colors.white,
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize: AppTheme.fontSize17,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: '请输入手机号码',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0XFFededed),
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: Color(0XFFededed),
                                                width: 1,
                                              )),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: AppTheme.primaryColor,
                                                width: 1,
                                              )),
                                            ),
                                            onSaved: (value) {
                                              userName = value;
                                            },
                                            validator: (value) {
                                              return value.length > 0
                                                  ? null
                                                  : '必填项不能为空';
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10.w),
                                          color: Colors.white,
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize: AppTheme.fontSize17,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                            obscureText: true, // 输入内容不可见
                                            decoration: InputDecoration(
                                              hintText: '请输入密码',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0XFFededed),
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: Color(0XFFededed),
                                                width: 1,
                                              )),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: AppTheme.primaryColor,
                                                width: 1,
                                              )),
                                            ),
                                            onSaved: (value) {
                                              password = value;
                                            },
                                            validator: (value) {
                                              return value.length > 0
                                                  ? null
                                                  : '必填项不能为空';
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 0, 15.h),
                                          margin: EdgeInsets.fromLTRB(
                                              0, 30.h, 0, 0),
                                          color: Colors.white,
                                          child: ElevatedButton(
                                            child: Text(
                                                isLoading ? '登录中...' : '登录'),
                                            onPressed: () {
                                              if (isLoading) return;
                                              handleLogin();
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '忘记密码？',
                                              style: TextStyle(
                                                  color: AppTheme.primaryColor,
                                                  fontSize:
                                                      AppTheme.fontSize14),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          'forget-password');
                                                },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20.w),
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '登录即代表您已同意',
                      style: TextStyle(
                        color: AppTheme.subTextColor,
                        fontSize: AppTheme.fontSize14,
                      ),
                      children: [
                        textSpanButton('《使用协议》', () {
                          Navigator.of(context).pushNamed('using-agreement');
                        }),
                        TextSpan(text: '及'),
                        textSpanButton('《隐私政策》', () {
                          Navigator.of(context).pushNamed('register-agreement');
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan textSpanButton(String text, Function onTap) {
    return TextSpan(
      text: text,
      recognizer: TapGestureRecognizer()..onTap = onTap,
      style: TextStyle(
        color: AppTheme.primaryColor,
        fontSize: AppTheme.fontSize14,
      ),
    );
  }

  Future handleLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    //读取当前 Form 状态
    var loginForm = loginKey.currentState;
    //验证 Form表单
    if (loginForm.validate()) {
      loginForm.save();
      print('userName：' + userName + '，password：' + password);
      setState(() {
        isLoading = true;
      });
      try {
        var response = await login({
          'clientId': 3,
          'organizationId': 0,
          'password': password,
          'username': userName
        });
        var result = response.data['data'];
        var code = response.data['code'];
        if (code != 5) {
          await authToken.set(result['token']);
          final res = await getUserInfo();
          final data = res.data['data'];
          await loginUser.set(data);
          final _c = Get.find<IndexController>();
          if (_c != null) {
            await _c.onInitPage();
          }
          Get.offAllNamed('index');
        } else {
          String msg = response.data['msg'];
          app.showToast(msg);
        }
      } catch (err) {
        logger.e('login err: $err');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
