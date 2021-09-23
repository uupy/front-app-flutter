import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/src/promoter/edit/controller.dart';

class PromoterEdit extends StatefulWidget {
  @override
  _PromoterEditState createState() => _PromoterEditState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
String realName;
String phoneNumber;
String initPassword;
bool isEdit = false;

FocusNode _numberFocusNode;
TextEditingController _nameEditingController;

class _PromoterEditState extends State<PromoterEdit> {
  final _controller = Get.put(PromoterEditController());

  @override
  void initState() {
    super.initState();
    isEdit = Get.arguments != null ? true : false;
    _nameEditingController = new TextEditingController(
      text: isEdit ? Get.arguments.phoneNumber : '',
    );
    _numberFocusNode = new FocusNode();
    _numberFocusNode.addListener(() {
      if (!_numberFocusNode.hasFocus) {
        _controller.handlePhoneNumberChange(
          phoneNumber,
          success: (data) {
            realName = data['realName'];
            _nameEditingController.text = data['realName'];
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app.setAppBar(
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
        textColor: Colors.black,
        title: isEdit ? '编辑创客' : '添加创客',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.w),
                  child: GetBuilder<PromoterEditController>(
                    builder: (c) {
                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                            child: Text('手机号码'),
                          ),
                          Expanded(
                            child: TextFormField(
                              focusNode: _numberFocusNode,
                              initialValue:
                                  isEdit ? Get.arguments.phoneNumber : '',
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                phoneNumber = value;
                              },
                              decoration: InputDecoration(
                                hintText: '请输入手机号码',
                              ),
                            ),
                          ),
                          if (c?.errMsg != '')
                            Container(
                              child: Text(
                                c?.errMsg ?? '',
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.w),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                        child: Text('真实姓名'),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _nameEditingController,
                          onChanged: (value) {
                            realName = value;
                          },
                          decoration: InputDecoration(
                            hintText: '请输入真实姓名',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (!isEdit)
                  Container(
                    margin: EdgeInsets.only(bottom: 10.w),
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
                            decoration: InputDecoration(hintText: '请输入密码'),
                          ),
                        )
                      ],
                    ),
                  ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 40.w, 0, 0),
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
      ),
    );
  }

  void handleSave() async {
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      Map params = {'realName': realName, 'phoneNumber': phoneNumber};
      if (phoneNumber == null || phoneNumber == '') {
        app.showToast('请输入会员手机号');
        return;
      }
      if (realName == null || realName == '') {
        app.showToast('请输入会员真实姓名');
        return;
      }
      if (_controller.errMsg != '') {
        app.showToast('此用户未注册');
        return;
      }
      if (isEdit) {
        _controller.edit(params);
      } else {
        if (initPassword == null || initPassword == '') {
          app.showToast('请输入初始密码');
          return;
        }
        _controller.create({
          ...params,
          ...{'initPassword': initPassword}
        });
      }
    }
  }
}
