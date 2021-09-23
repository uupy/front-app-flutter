import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/api/stock.dart';
import 'package:wine/common/app.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'adjust_purcharse_count.dart';

class PurcharseLog extends StatefulWidget {
  @override
  _PurcharseLogState createState() => _PurcharseLogState();
}

TabController _controller;

class _PurcharseLogState extends State<PurcharseLog>
    with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();

  final tabItems = [
    Tab(text: '全部'),
    Tab(text: '未支付'),
    Tab(text: '待收货'),
    Tab(text: '已收货'),
    Tab(text: '已取消'),
  ];
  List purcharseLogList = [];
  var _listFuture;

  int current = 1;
  int pageSize = 10;
  int totalPages;
  var currentStatus = -1;

  @override
  void initState() {
    _controller = TabController(length: 5, vsync: this);
    _listFuture = queryList();

    /// 监听滚动
    _scrollController.addListener(() {
      ScrollPosition _position = _scrollController.position;
      if (_position.pixels == _position.maxScrollExtent) {
        if (current <= totalPages) {
          current++;
          queryList();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppTheme.bodyBackgroundColor,
          leading: IconButton(
            icon: Icon(
              IconFont.icon_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            '采购记录',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: AppTheme.primaryColor,
            labelStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: AppTheme.helpTextColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
            ),
            indicatorColor: AppTheme.primaryColor,
            tabs: tabItems,
            indicator: const BoxDecoration(),
            onTap: (index) {
              currentStatus = index - 1;
              switch (index) {
                case 0:

                  ///全部
                  currentStatus = -1;
                  break;
                case 1:

                  /// 未支付
                  currentStatus = 0;
                  break;
                case 2:

                  /// 待收货
                  currentStatus = 2;
                  break;
                case 3:

                  /// 已收货
                  currentStatus = 3;
                  break;
                case 4:

                  /// 已取消
                  currentStatus = 4;
                  break;
              }
              purcharseLogList = [];
              current = 1;
              setState(() {});
              queryList();
            },
          ),
        ),
        preferredSize: Size.fromHeight(80.w),
      ),
      body: Container(
        child: RefreshIndicator(
          // 下拉刷新组件
          displacement: 20,
          backgroundColor: Colors.grey[200],
          onRefresh: () {
            current = 1;
            return queryList();
          },
          child: FutureBuilder(
            future: _listFuture,
            builder: (BuildContext context, snapshot) {
              if (purcharseLogList.length == 0) {
                return ListNoData();
              }
              return ListView.builder(
                itemCount: purcharseLogList.length,
                itemBuilder: (context, index) {
                  var item = purcharseLogList[index];
                  return buildListItem(item ?? {});
                },
                controller: _scrollController,
              );
            },
          ),
        ),
      ),
    );
  }

  /// 构建列表项
  Widget buildListItem(item) {
    final deliveryStatus = item['deliveryStatus'] ?? {};
    final paymentStatus = item['paymentStatus'] ?? {};

    return Container(
      margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    '${item['cancelled'] ? '已取消' : paymentStatus['desc'] ?? ''}',
                    style: TextStyle(
                      color: AppTheme.subTextColor,
                    ),
                  ),
                ),
                if (!item['cancelled'])
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: Text(
                      '${deliveryStatus['desc'] ?? ''}',
                      style: TextStyle(
                        color: AppTheme.subTextColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: AppTheme.bodyBackgroundColor,
                    borderRadius: BorderRadius.circular(6.w),
                    image: DecorationImage(
                      image: NetworkImage(
                        item['goodsPictureUrl'],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10.w),
                          child: Text(
                            '${item['goodsName']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          '${item['skuName']}',
                          style: TextStyle(
                            color: AppTheme.subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.w),
                        child: Text(
                          '￥${item['purchaseAmount']}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: AppTheme.subTextColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.w),
                        child: Text(
                          'x${item['purchaseCount']}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: AppTheme.subTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.w),
            padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.bodyBackgroundColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '下单时间：${item['purchaseTime']}',
                    style: TextStyle(
                      color: AppTheme.subTextColor,
                    ),
                  ),
                ),
                if (item['receiveTime'] != null)
                  Container(
                    child: Text(
                      '收货时间：${item['receiveTime']}',
                      style: TextStyle(
                        color: AppTheme.subTextColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// 已发货，显示收货按钮
                if (deliveryStatus['value'] == 1 && !item['cancelled'])
                  buildButton('收货', () {
                    handleAction(item, 'receive');
                  }),

                /// 未支付 未发货，显示取消按钮
                if (paymentStatus['value'] == 1 &&
                    deliveryStatus['value'] == 0 &&
                    !item['cancelled'])
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: buildButton('取消', () {
                      handleAction(item, 'cancel');
                    }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 按钮
  Widget buildButton(String text, Function onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Color(0xffEBEBEB),
            width: 1,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
      ),
    );
  }

  Future queryList() async {
    var res = await getPurchasePage(currentStatus > -1
        ? {'current': current, 'pageSize': pageSize, 'status': currentStatus}
        : {'current': current, 'pageSize': pageSize});
    totalPages = res.data['data']['totalPages'];
    if (current == 1) {
      purcharseLogList = [];
    }
    purcharseLogList = [...purcharseLogList, ...res.data['data']['data']];
    setState(() {});
  }

  handleAction(data, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('确定${action == 'receive' ? '收货' : '取消'}吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (action == 'receive') {
                  await receivePurchase({'purchaseId': data['id']});
                } else if (action == 'cancel') {
                  await cancelPurchase({'purchaseId': data['id']});
                }
                app.showToast('操作成功');
                queryList();
                Get.back();
              },
              child: Text(
                '确定',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  handleAdjustCount(data) async {
    showPurchaseConfirmDialog(
      context,
      data,
    ).then(
      (refresh) {
        if (refresh) {
          current = 1;
          queryList();
        }
      },
    );
  }
}
