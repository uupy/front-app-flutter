import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';
import 'package:wine/src/my_promotion/model.dart';

import 'controller.dart';

class MyPromotion extends StatefulWidget {
  @override
  _MyPromotionState createState() => _MyPromotionState();
}

class _MyPromotionState extends State<MyPromotion> {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(MyPromotionController());

  @override
  void initState() {
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
        title: '我的推广',
        brightness: Brightness.dark,
      ),
      body: RefreshIndicator(
        onRefresh: () => _controller.reload(),
        child: GetBuilder<MyPromotionController>(
          builder: (c) {
            return Column(
              children: [
                pageHeader(c.totalPeople ?? '0'),
                Expanded(
                  flex: 1,
                  child: pageBody(c?.dataList),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 头部人数统计
  Widget pageHeader(String total) {
    return Container(
      height: 100.w,
      color: AppTheme.primaryColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$total',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'PingFang SC',
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: Text(
              '当前邀请人数',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 内容列表
  Widget pageBody(List<MyPromotionVo> list) {
    bool loading = _controller.isLoading;
    if (!loading && list?.length == 0) {
      return ListNoData();
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        MyPromotionVo item;
        String userName;
        if (index == list.length) {
          return loading ? _buildProgressIndicator() : Container();
        } else {
          item = list[index];
          if (item.newUserRealName.isNotEmpty) {
            userName = item?.newUserRealName;
          } else {
            userName = item?.newUserNickname;
          }
        }
        return Card(
          margin: EdgeInsets.fromLTRB(10.w, 5.w, 10.w, 5.w),
          child: Container(
            padding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(userName),
                ),
                Container(
                  child: Row(
                    children: [
                      if (item.newUserTelephone?.isNotEmpty)
                        Container(
                          padding: EdgeInsets.only(top: 4.w, right: 10.w),
                          child: Text(
                            item.newUserTelephone,
                            style: TextStyle(
                              color: AppTheme.subTextColor,
                            ),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.only(top: 3.w),
                        child: Text(
                          item.createTime,
                          style: TextStyle(
                            color: AppTheme.subTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15.w),
                        child: OutlinedButton(
                          child: Text('订单详情'),
                          onPressed: () {
                            Get.toNamed(
                              'customer-order-list',
                              arguments: '${item.newUserId}',
                            );
                          },
                        ),
                      ),
                      OutlinedButton(
                        child: Text('用户详情'),
                        onPressed: () {
                          _controller.currentUser = item;
                          Get.toNamed('my-promotion-details');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 加载更多进度
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _controller.isLoading ? 1 : 0,
          child: new CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
