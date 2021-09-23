import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/src/order_offline/list/view.dart';
import 'package:wine/src/order_online/view.dart';

class Order extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Order();
  }
}

class _Order extends State with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<String> _tabItems = [
    '线上订单',
    '线下订单',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        brightness: Brightness.dark,
        title: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: _tabItems
              .map(
                (name) => Tab(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 17.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          OrderOnline(),
          OrderOffline(),
        ],
      ),
    );
  }
}
