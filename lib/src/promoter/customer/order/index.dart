import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';

import 'controller.dart';
import 'model.dart';

class CustomerOrderList extends StatefulWidget {
  @override
  _CustomerOrderListState createState() => _CustomerOrderListState();
}

class _CustomerOrderListState extends State<CustomerOrderList> {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(CustomerOrderController());

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
        title: '客户购买记录',
        result: false,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _controller.reload();
        },
        child: GetBuilder<CustomerOrderController>(
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

  Widget buildItems(CustomerOrder item) {
    if (item != null) {
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
            buildTextItems('订单编号', item.id),
            buildTextItems('订单时间', item.createTime),
            buildTextItems('订单内容', '-'),
            buildTextItems('订单金额', '￥${item.realAmount}'),
            buildTextItems('订单状态', item.status.desc),
          ],
        ),
      );
    } else {
      return ListNoData();
    }
  }

  Widget buildTextItems(text, value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      child: Text(
        '$text：$value',
        style: TextStyle(color: AppTheme.subTextColor),
      ),
    );
  }
}
