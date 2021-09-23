import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';
import 'package:wine/src/stock/logs/controller.dart';

class StockLog extends StatefulWidget {
  @override
  _StockLogState createState() => _StockLogState();
}

class _StockLogState extends State<StockLog> {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(StockLogController());

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
        title: '库存调整记录',
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _controller.reload();
        },
        child: GetBuilder<StockLogController>(builder: (controller) {
          if (!controller.isLoading && controller?.dataList?.length == 0) {
            return ListNoData();
          } else {
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: controller.dataList.length,
              itemBuilder: (context, index) {
                return Container(child: buildItems(controller.dataList[index]));
              },
            );
          }
        }),
      ),
    );
  }

  Widget buildItems(item) {
    if (item != null) {
      return Container(
        margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
        padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                color: AppTheme.bodyBackgroundColor,
                borderRadius: BorderRadius.circular(6.w),
                image: DecorationImage(
                  image: NetworkImage(item.goodsPictureUrl),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.goodsName}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    '调整：${item.adjustCount}',
                    style: TextStyle(
                      color: AppTheme.subTextColor,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '原因：${item.remark}',
                    style: TextStyle(
                      color: AppTheme.subTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return ListNoData();
    }
  }
}
