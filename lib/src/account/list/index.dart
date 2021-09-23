import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';
import 'package:wine/fonts/iconfont.dart';

import 'controller.dart';

class AccountList extends StatefulWidget {
  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(AccountListController());

  @override
  void initState() {
    print('------------- init State --------');
    super.initState();
    _controller.queryList();

    /// 监听滚动
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _controller.loadMore();
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
        title: '账号管理',
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              Get.toNamed('account-edit').then(
                (isReload) {
                  print('---------- back ---------- $isReload');
                  if (isReload) {
                    _controller.queryList();
                  }
                },
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _controller.reload();
        },
        child: GetBuilder<AccountListController>(
          builder: (controller) {
            if (!controller.isLoading && controller?.dataList?.length == 0) {
              return ListNoData();
            } else {
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: controller.dataList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: buildItems(controller.dataList[index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildItems(item) {
    if (item != null) {
      return Container(
        margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
        padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${item.name} ${item.phoneNumber}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(IconFont.icon_edit),
                    onPressed: () {
                      Get.toNamed('account-edit', arguments: item).then(
                        (result) {
                          if (result) {
                            _controller.queryList();
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              child: Text(
                '核心${item.roleType.desc}, ${item.createTime}',
                style: TextStyle(color: AppTheme.subTextColor),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 18.w, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButtons(
                    '重置密码',
                    () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('提示'),
                            content: Text('确定要将密码重置为123456吗？'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('取消')),
                              TextButton(
                                onPressed: () {
                                  _controller.resetAccountPassword(item.id);
                                },
                                child: Text('确定'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  buildButtons(
                    '删除',
                    () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('提示'),
                            content: Text('确定要删除吗？'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('取消')),
                              TextButton(
                                onPressed: () {
                                  _controller.remove(item.id);
                                },
                                child: Text('确定'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: TextStyle(color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return ListNoData();
    }
  }

  Widget buildButtons(text, onPressed, {TextStyle style}) {
    return Expanded(
      // flex: 1,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(text, style: style, softWrap: false),
        ),
      ),
    );
  }
}
