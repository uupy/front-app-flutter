import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';

import 'components/header_search.dart';
import 'components/logistics_ship_dialog.dart';
import 'components/club_ship_dialog.dart';
import 'components/header_tabs.dart';
import 'controller.dart';
import 'model.dart';

class OrderOnline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderOnline();
  }
}

class _OrderOnline extends State with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(OrderOnlineController());

  @override
  void initState() {
    super.initState();
    _controller.reload();

    /// 监听滚动
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bodyBackgroundColor,
        title: HeaderTabs(
          onTabChange: (status) {
            _controller.onSearchByStatus(status: status);
          },
        ),
        bottom: PreferredSize(
          child: HeaderSearch(
            onSearch: (keyword) {
              _controller.onSearchByKeyword(keyword: keyword);
            },
          ),
          preferredSize: Size.fromHeight(45.w),
        ),
      ),
      body: RefreshIndicator(
        // 下拉刷新组件
        displacement: 20,
        backgroundColor: Colors.grey[200],
        onRefresh: () => _controller.onRefresh(),
        child: GetBuilder<OrderOnlineController>(
          builder: (s) {
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: s.orderList.length + 1,
              itemBuilder: (context, index) {
                OrderOnlineVo item;
                if (!s.loading && s.orderList.length == 0) {
                  return Container(
                    padding: EdgeInsets.only(top: 100.w),
                    child: ListNoData(),
                  );
                }
                if (index == s.orderList.length) {
                  return s.loading ? _buildProgressIndicator() : Container();
                } else {
                  item = s.orderList[index];
                }
                return Card(
                  elevation: 0,
                  margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.w),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      children: [
                        cardHeader(item),
                        cardBody(item),
                        Divider(
                          height: 5,
                          thickness: 1,
                          color: AppTheme.bottomBorderColor,
                        ),
                        cardFooter(item),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 加载更多进度
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _controller.loading ? 1 : 0,
          child: new CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  /// 卡片头部
  Widget cardHeader(OrderOnlineVo item) {
    int statusVal = item.deliveryStatus?.value;
    String statusName = item.deliveryStatus?.desc;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '订单 ${item.orderId}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          statusName,
          style: TextStyle(
            color:
                statusVal == 1 ? AppTheme.subTextColor : AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  /// 每条商品信息
  Widget goodsItemRow(ItemList goods) {
    double price = goods.salePrice;
    int quantity = goods.quantity;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 5.w, 0, 5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              width: 70.w,
              height: 70.w,
              margin: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                color: AppTheme.bottomBorderColor,
                image: DecorationImage(
                  image: NetworkImage(
                    goods.goodsPictureUrl,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(goods.goodsName),
                    ),
                    Text(
                      '￥$price',
                      style: TextStyle(fontSize: 13.w),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        goods.skuName,
                        style: TextStyle(
                          fontSize: 13.w,
                          color: AppTheme.subTextColor,
                        ),
                      ),
                    ),
                    Text(
                      'x$quantity',
                      style: TextStyle(
                        fontSize: 13.w,
                        color: AppTheme.subTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 卡片内容（商品信息）
  Widget cardBody(OrderOnlineVo item) {
    List<ItemList> itemList = item.itemList ?? [];
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
      child: Column(
        children: itemList.map((goods) => goodsItemRow(goods)).toList(),
      ),
    );
  }

  /// 底部内容行
  Widget footerRow(String label, String content) {
    return Container(
      margin: EdgeInsets.only(top: 5.w),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.subTextColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                content,
                style: TextStyle(
                  color: AppTheme.subTextColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 底部按钮
  Widget footerButton(String text, {Function onPressed}) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.w, 15.w, 0, 0),
      child: OutlinedButton(
        child: Text(
          text,
        ),
        onPressed: onPressed,
      ),
    );
  }

  /// 卡片底部
  Widget cardFooter(OrderOnlineVo item) {
    double amount = item.realAmount;
    int deliveryStatus = item.deliveryStatus?.value;

    return Column(
      children: [
        footerRow('总价', '￥${amount.toString()}'),
        footerRow('收件人', item.contactName),
        footerRow('收件地址', item.receiveAddress),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (deliveryStatus != 1)
              footerButton(
                '物流发货',
                onPressed: () {
                  logisticsShipDialog.open(context, state: item).then(
                    (refresh) {
                      if (refresh) {
                        _controller.onRefresh();
                      }
                    },
                  );
                },
              ),
            if (deliveryStatus != 1)
              footerButton(
                '配送发货',
                onPressed: () {
                  clubShipDialog.open(context, state: item).then(
                    (refresh) {
                      if (refresh) {
                        _controller.onRefresh();
                      }
                    },
                  );
                },
              ),
            footerButton(
              '订单详情',
              onPressed: () {
                Get.toNamed('order-detail?id=${item.id}');
              },
            ),
          ],
        ),
      ],
    );
  }
}
