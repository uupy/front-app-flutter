import 'package:flutter/material.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/fonts/iconfont.dart';

class ForgetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ForgetPassword();
  }  
}

class _ForgetPassword extends State<ForgetPassword>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(
            IconFont.icon_arrow_left,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text('忘记密码'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Container()
    );
  }
  
}