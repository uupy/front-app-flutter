import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/src/password/change_password/controller.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final _controller = Get.put(ChangePasswordControll());
String newPassword;
String oldPassword;
String newPassword1;
String newPassword2;

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    app.setStatusBarColor(
      statusBarColor: Colors.white,
    );
    return Scaffold(
      appBar: app.setAppBar(
        brightness: Brightness.dark,
        title: '修改密码'
      ),
      body: Container(        
        margin: EdgeInsets.all(15.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w)
        ),
        child: Form(
          key: formKey,
          child:Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10.w
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70.w,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                      child: Text('旧密码'),
                    ),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (value) {
                          oldPassword = value;
                        },
                        validator: (value) {
                          return value.length > 0
                              ? null
                              : '必填项不能为空';
                        },                      
                        decoration: InputDecoration(
                          hintText: '请输入旧密码',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10.w
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70.w,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                      child: Text('新密码'),
                    ),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (value) {
                          newPassword1 = value;
                        },
                        onChanged: (value){
                          newPassword1 = value;
                        },
                        validator: (value) {
                          if (value.length > 0) {
                            if (newPassword2 != newPassword1) {
                              return '两次输入的密码不一致';
                            }
                            return null;
                          } else {
                            return '必填项不能为空';
                          }
                        },                      
                        decoration: InputDecoration(
                          hintText: '请输入新密码',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10.w
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70.w,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                      child: Text('确认密码'),
                    ),
                    
                    Expanded(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        onSaved: (value) {
                          newPassword2 = value;
                        },
                        onChanged: (value){
                          newPassword2 = value;
                        },
                        validator: (value) {
                          if (value.length > 0) {
                            if (newPassword2 != newPassword1) {
                              return '两次输入的密码不一致';
                            }
                            return null;
                          } else {
                            return '必填项不能为空';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: '请再次输入新密码'
                        )
                      ),
                    )
                  ],
                ),
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(0, 40.w, 0, 0),
                child: ElevatedButton(
                  onPressed: (){
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

  handleSave() {
    var formData = formKey.currentState;
    if (formData.validate()){
      formData.save();
      newPassword = newPassword2;
      _controller.onSave(
        {
          'newPassword': newPassword,
          'oldPassword': oldPassword
        }
      );
    }
  }
}