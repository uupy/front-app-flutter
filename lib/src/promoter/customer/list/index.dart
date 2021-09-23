import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';

import 'controller.dart';
import 'model.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(CustomerListController());

  @override
  void initState() {
    print('------------- init State --------');
    print(' ---------- arguments ------- ${Get.arguments}');
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
        title: '创客推广列表',
        result: false,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _controller.reload();
        },
        child: GetBuilder<CustomerListController>(
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
                    child: buildItems(
                      controller.dataList[index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildItems(Customer item) {
    if (item != null) {
      String userName = item.newUserRealName ?? '';
      if (userName == '') {
        userName = item.newUserNickname ?? '';
      }
      return Container(
        margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
        padding: EdgeInsets.fromLTRB(15.w, 20.w, 15.w, 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6.w),
              child: Text(
                '$userName ${item.newUserTelephone ?? ''}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 6.w),
              child: Text(
                '推广时间：${item.createTime}',
                style: TextStyle(
                  color: AppTheme.subTextColor,
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Text(
                      '下单数量：${item.orderCount}',
                      style: TextStyle(
                        color: AppTheme.subTextColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.w),
                    child: Text(
                      '下单金额：${item.orderAmount}元',
                      style: TextStyle(
                        color: AppTheme.subTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 15.w, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed(
                            'customer-order-list',
                            arguments: '${item.newUserId}',
                          );
                        },
                        child: Text('订单记录'),
                      ),
                    ),
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
}
