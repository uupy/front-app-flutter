import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';

import 'controller.dart';
import 'model.dart';

class MyProfit extends StatefulWidget {
  @override
  _MyProfitState createState() => _MyProfitState();
}

class _MyProfitState extends State<MyProfit> {
  String walletId = Get.parameters['walletId'];
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(MyProfitController());

  @override
  void initState() {
    super.initState();
    _controller.queryList(walletId: walletId);

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
        title: '分润明细',
        textColor: Colors.black,
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
      ),
      body: RefreshIndicator(
        onRefresh: () => _controller.reload(),
        child: GetBuilder<MyProfitController>(
          builder: (c) {
            return pageBody(c?.dataList);
          },
        ),
      ),
    );
  }

  /// 内容列表
  Widget pageBody(List<ProfitVo> list) {
    bool loading = _controller.isLoading;
    if (!loading && list?.length == 0) {
      return ListNoData();
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        ProfitVo item;
        if (index == list.length) {
          return loading ? _buildProgressIndicator() : Container();
        } else {
          item = list[index];
        }
        return Card(
          margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.w),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 10.w),
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('分润'),
                ),
                Text('￥${item.profitAmount ?? 0}'),
              ],
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.remark}'),
                  Container(
                    margin: EdgeInsets.only(top: 4.w),
                    child: Text('${item.profitTime ?? ''}'),
                  ),
                ],
              ),
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
