import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/components/radio_list_title_super.dart';

class AppRadio {
  AppRadio({
    @required this.label,
    @required this.value,
    this.width,
  }) : assert(label != null && value != null);
  Widget label;
  dynamic value;
  double width;
}

class AppRadioGroup extends StatefulWidget {
  AppRadioGroup({
    @required this.items,
    this.value,
    this.useWrap = false,
    this.onChanged,
  }) : assert(items != null);

  /// 单选集合
  final List<AppRadio> items;

  /// 当前选中
  final value;

  /// 当前选中
  final useWrap;

  /// 改变触发
  final Function onChanged;
  @override
  _AppRadioGroupState createState() => _AppRadioGroupState();
}

class _AppRadioGroupState extends State<AppRadioGroup> {
  var _radioGroupValue;

  @override
  void initState() {
    super.initState();
    _radioGroupValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useWrap) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ...widget.items.map((item) {
              return Container(
                width: item.width ?? 86.w,
                child: radioItem(item),
              );
            }).toList(),
          ],
        ),
      );
    }
    return Container(
      child: Row(
        children: <Widget>[
          ...widget.items.map((item) {
            return Flexible(
              child: radioItem(item),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget radioItem(AppRadio item) {
    return RadioListTileSuper(
      title: item.label,
      value: item.value,
      groupValue: _radioGroupValue,
      activeColor: AppTheme.primaryColor,
      dense: true,
      contentPadding: EdgeInsets.all(0),
      onChanged: (value) {
        setState(() {
          _radioGroupValue = value;
        });
        if (widget.onChanged is Function) {
          widget.onChanged(value);
        }
      },
    );
  }
}
