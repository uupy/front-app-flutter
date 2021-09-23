import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/src/account/edit/controller.dart';

class AccountEdit extends StatefulWidget {
  @override
  _AccountEdit createState() => _AccountEdit();
}

final _controller = Get.put(AccountEditController());
GlobalKey<FormState> formKey = GlobalKey<FormState>();
String realName;
String phoneNumber;
String initPassword;
bool isEdit = false;
int roleType = 2;

class _AccountEdit extends State<AccountEdit> {
  @override
  void initState() {
    isEdit = Get.arguments != null ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: isEdit ? '编辑账号' : '添加账号',
      ),
      body: Container(
        margin: EdgeInsets.all(15.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                      child: Text('真实姓名'),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: isEdit ? Get.arguments.name : '',
                        onSaved: (value) {
                          realName = value;
                        },
                        validator: (value) {
                          return value.length > 0 ? null : '必填项不能为空';
                        },
                        decoration: InputDecoration(
                          hintText: '请输入真实姓名',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                      child: Text('手机号码'),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: isEdit ? Get.arguments.phoneNumber : '',
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          phoneNumber = value;
                        },
                        validator: (value) {
                          return value.length > 0 ? null : '必填项不能为空';
                        },
                        decoration: InputDecoration(
                          hintText: '请输入手机号码',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (!isEdit)
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                        child: Text('初始密码'),
                      ),
                      Expanded(
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (value) {
                            initPassword = value;
                          },
                          validator: (value) {
                            return value.length > 0 ? null : '必填项不能为空';
                          },
                          decoration: InputDecoration(hintText: '请输入密码'),
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                      child: Text('所属角色'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Radio(
                                activeColor: AppTheme.primaryColor,
                                value: 1,
                                groupValue: roleType,
                                onChanged: (value) {
                                  setState(() {
                                    roleType = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                                child: GestureDetector(
                              child: Text('店长'),
                              onTap: () {
                                setState(() {
                                  roleType = 1;
                                });
                              },
                            )),
                            Container(
                              margin: EdgeInsets.only(left: 25.w),
                              child: Radio(
                                activeColor: AppTheme.primaryColor,
                                value: 2,
                                groupValue: roleType,
                                onChanged: (value) {
                                  setState(() {
                                    roleType = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                                child: GestureDetector(
                              child: Text('店员'),
                              onTap: () {
                                setState(() {
                                  roleType = 2;
                                });
                              },
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 40.h, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    handleSave();
                  },
                  child: Text('保存'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleSave() async {
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();

      print(' --- params ---: $roleType');
      Map params = {
        'realName': realName,
        'phoneNumber': phoneNumber,
        'roleType': roleType
      };
      if (isEdit) {
        _controller.edit(params);
      } else {
        _controller.create({
          ...params,
          ...{'initPassword': initPassword}
        });
      }
    }
  }
}
