import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';

import 'controller.dart';
import 'model.dart';

class MyWithdrawRecord extends StatefulWidget {
  @override
  _MyWithdrawRecordState createState() => _MyWithdrawRecordState();
}

class _MyWithdrawRecordState extends State<MyWithdrawRecord> {
  String walletId = Get.parameters['walletId'];
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(MyWithdrawRecordController());

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
        title: '提现记录',
        textColor: Colors.black,
        backgroundColor: AppTheme.bodyBackgroundColor,
        brightness: Brightness.light,
      ),
      body: RefreshIndicator(
        onRefresh: () => _controller.reload(),
        child: GetBuilder<MyWithdrawRecordController>(
          builder: (c) {
            return pageBody(c?.dataList);
          },
        ),
      ),
    );
  }

  /// 内容列表
  Widget pageBody(List<WithdrawRecordVo> list) {
    bool loading = _controller.isLoading;
    if (!loading && list?.length == 0) {
      return ListNoData();
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        WithdrawRecordVo item;
        if (index == list.length) {
          return loading ? _buildProgressIndicator() : Container();
        } else {
          item = list[index];
        }
        return Card(
          margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('提现'),
                ),
                Text('￥${item.amount ?? 0}'),
              ],
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 4.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('${item.createTime}'),
                  ),
                  Text(
                    '${item.auditStatus?.desc ?? ''}',
                    style: TextStyle(
                      color: item.auditStatus?.value == 2
                          ? AppTheme.primaryColor
                          : AppTheme.subTextColor,
                    ),
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
