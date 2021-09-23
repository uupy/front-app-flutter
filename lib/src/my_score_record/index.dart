import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wine/common/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/list_no_data.dart';

import 'controller.dart';
import 'model.dart';

class MyScoreRecord extends StatefulWidget {
  @override
  _MyScoreRecordState createState() => _MyScoreRecordState();
}

class _MyScoreRecordState extends State<MyScoreRecord> {
  ScrollController _scrollController = new ScrollController();
  final _controller = Get.put(MyScoreRecordController());

  @override
  void initState() {
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
        title: '积分记录',
        brightness: Brightness.dark,
      ),
      body: RefreshIndicator(
        onRefresh: () => _controller.reload(),
        child: GetBuilder<MyScoreRecordController>(
          builder: (c) {
            return Column(
              children: [
                pageHeader(c.totalScore ?? '0'),
                Expanded(
                  flex: 1,
                  child: pageBody(c?.dataList),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 头部统计
  Widget pageHeader(String total) {
    return Container(
      height: 100.w,
      color: AppTheme.primaryColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$total',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'PingFang SC',
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: Text(
              '您的积分',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 内容列表
  Widget pageBody(List<MyScoreVo> list) {
    bool loading = _controller.isLoading;
    if (!loading && list?.length == 0) {
      return ListNoData();
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        MyScoreVo item;
        String score = '';
        if (index == list.length) {
          return loading ? _buildProgressIndicator() : Container();
        } else {
          item = list[index];
          score = item.scoreChange;
        }
        return Card(
          margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.w),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15.w, 8.w, 15.w, 8.w),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('积分${int.parse(score) > 0 ? '增加' : '减少'}'),
                  flex: 1,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    '${int.parse(score) > 0 ? '+' : ''}$score',
                    style: TextStyle(
                      color: int.parse(score) > 0
                          ? AppTheme.contentTextColor
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.remark ?? ''),
                  Container(
                    margin: EdgeInsets.only(top: 4.w),
                    child: Text('${item.createTime ?? ''}'),
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
