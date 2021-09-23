import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/fonts/iconfont.dart';

/// 暂无数据组件
class ListNoData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListNoData();
  }
}

class _ListNoData extends State<ListNoData> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 40, 20),
            child: Icon(
              IconFont.icon_no_data,
              color: Colors.grey,
              size: 100,
            ),
          ),
          Center(
            child: Text(
              '暂无数据',
              style: TextStyle(
                color: AppTheme.subTextColor,
                fontSize: AppTheme.fontSize17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
