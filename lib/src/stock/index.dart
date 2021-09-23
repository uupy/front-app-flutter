import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/stock.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';
import 'package:wine/src/stock/purchase_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'adjust_dialog.dart';

class Stock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Stock();
  }
}

class _Stock extends State with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int current = 1;
  int pageSize = 10;
  int totalPages = 0;
  List<dynamic> dataList = [];
  Future _stockFutureBuilder;
  Map currentStock;

  @override
  bool get wantKeepAlive => true; //保持页面状态 重写方法

  @override
  void initState() {
    current = 1;
    isPerformingRequest = false;
    print('------- stock initState ---------');
    _stockFutureBuilder = getData();
    super.initState();

    /// 监听滚动
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('---------------- 滚动到底部了 ------------');
        if (current < totalPages) {
          current++;
          getData();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '库存',
          style: TextStyle(
            color: AppTheme.titleTextColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.bodyBackgroundColor,
      ),
      body: Container(
        child: RefreshIndicator(
          // 下拉刷新组件
          onRefresh: () {
            current = 1;
            print('----下拉刷新----');
            return getData();
          },
          child: FutureBuilder(
            future: _stockFutureBuilder,
            builder: (context, snapshot) {
              return Container(
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),

                  /// 解决内容过少时不能下拉刷新的问题
                  // shrinkWrap: true,
                  itemCount: dataList.length + 1,
                  itemBuilder: (context, index) {
                    print('isPerformingRequest: $isPerformingRequest');
                    print('dataList.length: ${dataList.length}');
                    if (!isPerformingRequest && dataList.length == 0) {
                      return Container(
                        padding: EdgeInsets.only(top: 140.w),
                        child: ListNoData(),
                      );
                    }
                    if (index == dataList.length) {
                      return isPerformingRequest
                          ? _buildProgressIndicator()
                          : Container();
                    } else {
                      return Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              child: Container(
                                width: 110.w,
                                height: 110.w,
                                margin: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.w),
                                  color: AppTheme.bottomBorderColor,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      dataList[index]['goodsPictureUrl'],
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataList[index]['goodsName'],
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                              0,
                                              5.w,
                                              0,
                                              18.w,
                                            ),
                                            child: Text(
                                              '库存：${dataList[index]['stockCount']}',
                                              style: TextStyle(
                                                color: AppTheme.subTextColor,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                            0,
                                            0,
                                            15.w,
                                            0,
                                          ),
                                          child: OutlinedButton(
                                            child: Text(
                                              '采购',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            onPressed: () {
                                              currentStock = dataList[index];
                                              showPurchaseConfirmDialog(
                                                context,
                                                currentStock,
                                              ).then(
                                                (refresh) {
                                                  if (refresh) {
                                                    current = 1;
                                                    getData();
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: OutlinedButton(
                                            child: Text(
                                              '调整',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            onPressed: () {
                                              currentStock = dataList[index];
                                              showAdjustConfirmDialog(
                                                context,
                                                currentStock,
                                              ).then(
                                                (refresh) {
                                                  if (refresh) {
                                                    current = 1;
                                                    getData();
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  controller: _scrollController,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      try {
        final res =
            await getStockPage({'current': current, 'pageSize': pageSize});
        final resData = res.data['data'];
        if (current == 1) {
          dataList = [];
        }
        totalPages = resData['totalPages'];
        dataList = [...dataList, ...resData['data']];
        return dataList;
      } catch (e) {
        return dataList;
      } finally {
        setState(() {
          isPerformingRequest = false;
        });
      }
    }
  }

  /// 加载更多进度
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1 : 0,
          child: new CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
