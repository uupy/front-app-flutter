import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/fonts/iconfont.dart';

class HeaderSearch extends StatefulWidget {
  HeaderSearch({
    this.onChange,
    this.onSearch,
  });

  final Function onChange;
  final Function onSearch;

  @override
  State<StatefulWidget> createState() {
    return _HeaderSearch();
  }
}

class _HeaderSearch extends State<HeaderSearch> {
  String keywords = '';
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          handleSearch(keywords);
        }
      });
  }

  void handleSearch(String value) {
    if (widget.onSearch != null) {
      widget.onSearch(value);
    }
  }

  void _textFieldChanged(String value) {
    keywords = value;
    if (widget.onChange != null) {
      widget.onChange(value);
    }
  }

  void _onSubmitted(String value) {
    handleSearch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.w),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
        child: TextField(
          focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            icon: Icon(
              IconFont.icon_search,
              size: 18.w,
            ),
            hintText: '关键词搜索',
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          onChanged: _textFieldChanged,
          onSubmitted: _onSubmitted,
          autofocus: false,
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}
