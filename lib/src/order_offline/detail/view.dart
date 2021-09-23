import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/fonts/iconfont.dart';

import 'controller.dart';
import 'model.dart';

class OrderOfflineDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderDetail();
  }
}

class _OrderDetail extends State {
  String orderId = Get.parameters['id'];
  final _controller = Get.put(OrderDetailController());

  @override
  void initState() {
    super.initState();
    _controller.fetchData(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      builder: (s) {
        final status = s.detail?.status;
        final paymentStatus = s.detail?.paymentStatus;
        final paymentType = s.detail?.paymentType;
        String title = '订单详情';
        if (status?.value == 1) {
          title = status?.desc ?? '';
        } else {
          if (paymentStatus?.value == 0) {
            title = paymentStatus?.desc ?? '';
          } else {
            title = '${paymentStatus?.desc ?? ''}(${paymentType?.desc ?? ''})';
          }
        }
        return Scaffold(
          appBar: app.setAppBar(
            title: title ?? '订单详情',
            brightness: Brightness.dark,
          ),
          body: RefreshIndicator(
            // 下拉刷新组件
            displacement: 20,
            backgroundColor: Colors.grey[200],
            onRefresh: () => _controller.fetchData(orderId),
            child: Stack(
              children: [
                // 背景色块
                Positioned(
                  child: Container(
                    color: AppTheme.primaryColor,
                    height: 62.w,
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10.w, 12.w, 10.w, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Column(
                      children: [
                        contactInfoCard(),
                        goodsInfoCard(),
                        orderInfoCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 联系人信息
  Widget contactInfoCard() {
    OrderOfflineDetailVo detail = _controller.detail;
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.w),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: ListTile(
          leading: ClipOval(
            child: Container(
              color: AppTheme.primaryColor,
              width: 35.w,
              height: 35.w,
              child: Center(
                child: Icon(
                  IconFont.icon_location,
                  size: 18.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text('${detail?.contactName ?? ''}'),
          subtitle: Text('${detail?.contactNumber ?? ''}'),
        ),
      ),
    );
  }

  /// 商品信息
  Widget goodsInfoCard() {
    OrderOfflineDetailVo detail = _controller.detail;
    List<ItemList> itemList = detail?.itemList ?? [];
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.w),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            ...itemList.map((goods) => goodsItemRow(goods)).toList(),
            Divider(
              height: 6.w,
              thickness: 1,
              color: AppTheme.bottomBorderColor,
            ),
            Column(
              children: [
                footerRow('订单金额', '￥${detail?.amount ?? ''}'),
                footerRow('优惠金额', '￥${detail?.couponAmount ?? ''}'),
                footerRow('实付金额', '￥${detail?.realAmount ?? ''}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 每条商品信息
  Widget goodsItemRow(ItemList goods) {
    double price = goods.salePrice;
    int quantity = goods.quantity;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 5.w, 0, 8.w),
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

  /// 订单信息
  Widget orderInfoCard() {
    OrderOfflineDetailVo detail = _controller.detail;
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.w),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            footerRow('下单时间', '${detail?.createTime}'),
            footerRow('订单编号', '${detail?.id}'),
            footerRow('支付方式', '${detail?.paymentType?.desc ?? ''}'),
            footerRow('支付时间', '${detail?.paidTime ?? ''}'),
            footerRow('客户留言', '${detail?.remark}'),
          ],
        ),
      ),
    );
  }

  /// 底部内容行
  Widget footerRow(String label, String content) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6.w, 0, 6.w),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.contentTextColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                content ?? '',
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
}
