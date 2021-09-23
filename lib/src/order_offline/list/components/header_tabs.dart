import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/src/order_offline/list/controller.dart';

class HeaderTabs extends StatefulWidget {
  HeaderTabs({this.onTabChange});

  final Function onTabChange;

  @override
  State<StatefulWidget> createState() {
    return _HeaderTabs();
  }
}

class _HeaderTabs extends State<HeaderTabs>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = [
    {'title': '全部', 'value': null},
    {'title': '未付款', 'value': 0},
    {'title': '已付款', 'value': 1}
  ];
  int currentIndex = 0;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: headerTabs(),
        ),
        OutlinedButton(
          onPressed: () {
            Get.toNamed('order-offline-create').then((result) {
              if (result) {
                final _c = Get.find<OrderOfflineController>();
                _c.reload();
              }
            });
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: AppTheme.primaryColor,
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.fromLTRB(10.w, 4.w, 10.w, 5.w),
            ),
          ),
          child: Text(
            '+ 下单',
            style: TextStyle(
              fontSize: 15.w,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget headerTabs() {
    return TabBar(
      controller: _controller,
      tabs: _tabs.map((tab) {
        return Tab(
          text: tab['title'],
        );
      }).toList(),
      isScrollable: true,
      indicator: const BoxDecoration(),
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 17.w,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: AppTheme.helpTextColor,
      unselectedLabelStyle: TextStyle(
        fontSize: 15.w,
        fontWeight: FontWeight.normal,
      ),
      onTap: (index) {
        int status = _tabs[index]['value'];
        currentIndex = index;
        if (widget.onTabChange != null) {
          widget.onTabChange(status);
        }
      },
    );
  }
}
