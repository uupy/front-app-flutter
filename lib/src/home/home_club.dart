import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:wine/api/home.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:wine/common/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String currentClubText = '今天';
var startTime;
var endTime;
var clubData;
double subTextFontSize = 12.sp;
var _clubFutureBuilderFuture;
double rowWidth = 110.w;

class HomeClub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeClub();
  }
}

class _HomeClub extends State<HomeClub> {
  @override
  void initState() {
    _clubFutureBuilderFuture = getClubData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      // height: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
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
                  '体验馆业务统计',
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
                          currentClubText,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.w),
                          child: Icon(
                            IconFont.icon_drop_down,
                            color: AppTheme.primaryColor,
                            size: 8.sp,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      showClubPickerModal(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _clubFutureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: rowWidth,
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(
                                    '${clubData['orderCount']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                  Container(
                                    child: Text(
                                      '订单数量',
                                      softWrap: false,
                                      style: TextStyle(
                                        color: AppTheme.subTextColor,
                                        fontSize: subTextFontSize,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: rowWidth,
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(
                                    '${clubData['orderAmount']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                  Container(
                                    child: Text(
                                      '订单金额(元)',
                                      softWrap: false,
                                      style: TextStyle(
                                        color: AppTheme.subTextColor,
                                        fontSize: subTextFontSize,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: rowWidth,
                                child: Column(
                                  children: [
                                    Container(
                                        child: Text(
                                      '${clubData['clubProfit']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                    Container(
                                      child: Text(
                                        '体验馆收入(元)',
                                        softWrap: false,
                                        style: TextStyle(
                                          color: AppTheme.subTextColor,
                                          fontSize: subTextFontSize,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: rowWidth,
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${clubData['deliveriedOrderAmount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '送货订单金额(元)',
                                      softWrap: false,
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
                              width: rowWidth,
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${clubData['deliveriedOrderCount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '送货订单数量',
                                      softWrap: false,
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
                              width: rowWidth,
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      '${clubData['newUserCount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '新推会员数量',
                                      softWrap: false,
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

  showClubPickerModal(BuildContext context) {
    const PickerData = ['全部', '今天', '昨天', '本月', '上月'];
    new Picker(
      adapter: PickerDataAdapter<String>(pickerdata: PickerData),
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List value) {
        currentClubText = PickerData[value[0]];
        getClubData().then((res) {
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
    ).showModal(context); //_scaffoldKey.currentState);
  }
}

Future getClubData() async {
  startTime = Utils.getTimeByRange(currentClubText)['startTime'];
  endTime = Utils.getTimeByRange(currentClubText)['endTime'];

  var response = await getClub(currentClubText != '全部'
      ? {'startTime': startTime, 'endTime': endTime}
      : null);
  clubData = response.data['data'];
  return clubData;
}
