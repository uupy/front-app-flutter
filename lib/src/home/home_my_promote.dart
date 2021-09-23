import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:wine/api/home.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:wine/common/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String currentText = '今天';
Map promoteData;
double subTextFontSize = 12.sp;
var _myPromoteFutureBuilder;
String startTime;
String endTime;

class MyPromote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPromote();
  }
}

class _MyPromote extends State<MyPromote> {
  @override
  void initState() {
    _myPromoteFutureBuilder = getMyPromoteDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: AppTheme.bottomBorderColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '我的推广统计',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                  ),
                ),
                Container(
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          currentText,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Icon(
                            IconFont.icon_drop_down,
                            color: AppTheme.primaryColor,
                            size: 8.sp,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      showMyPromotePickerModal(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _myPromoteFutureBuilder,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${promoteData['newUserCount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '推广人数',
                                      style: TextStyle(
                                        color: AppTheme.subTextColor,
                                        fontSize: subTextFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${promoteData['orderCount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '订单数',
                                      style: TextStyle(
                                        color: AppTheme.subTextColor,
                                        fontSize: subTextFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${promoteData['orderAmount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '订单金额(元)',
                                      style: TextStyle(
                                        color: AppTheme.subTextColor,
                                        fontSize: subTextFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${promoteData['profit']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '我的收益(元)',
                                      style: TextStyle(
                                        color: AppTheme.subTextColor,
                                        fontSize: subTextFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  showMyPromotePickerModal(BuildContext context) {
    const PickerData = ['全部', '今天', '昨天', '本月', '上月'];
    new Picker(
      adapter: PickerDataAdapter<String>(pickerdata: PickerData),
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List value) {
        currentText = PickerData[value[0]];
        getMyPromoteDatas().then((res) {
          setState(() {});
        });
      },
      cancelText: '取消',
      confirmText: '确定',
      itemExtent: 50,
      height: 300,
      confirmTextStyle: TextStyle(
        color: AppTheme.contentTextColor,
        fontSize: 20.sp,
      ),
      cancelTextStyle: TextStyle(
        color: AppTheme.contentTextColor,
        fontSize: 20.sp,
      ),
    ).showModal(this.context); //_scaffoldKey.currentState);
  }
}

Future getMyPromoteDatas() async {
  startTime = Utils.getTimeByRange(currentText)['startTime'];
  endTime = Utils.getTimeByRange(currentText)['endTime'];
  var response = await getMyPromote(currentText != '全部'
      ? {'startTime': startTime, 'endTime': endTime}
      : null);

  promoteData = response.data['data'];
  return promoteData;
}
