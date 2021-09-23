import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine/api/home.dart';
import 'package:wine/common/app_theme.dart';
import 'package:wine/common/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSalesTop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeSalesTop();
}

String startTime;
String endTime;
bool hasData = false;
var _salesTopFutureBuilder;
var salesTopData;
String currentTimeText = '今天';
final tabsItems = [
  {'name': '今天', 'active': true},
  {'name': '本周', 'active': false},
  {'name': '上周', 'active': false},
  {'name': '本月', 'active': false},
  {'name': '上月', 'active': false},
  {'name': '全部', 'active': false}
];

class _HomeSalesTop extends State<HomeSalesTop> {
  @override
  void initState() {
    _salesTopFutureBuilder = getSalesTopData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: AppTheme.bottomBorderColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabsItems.map(
                (item) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
                    margin: item['active']
                        ? EdgeInsets.fromLTRB(0, 0, 0, 0)
                        : EdgeInsets.fromLTRB(0, 0, 0, 2.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: item['active']
                            ? BorderSide(width: 2, color: AppTheme.primaryColor)
                            : BorderSide.none,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        tabsItems.forEach((it) {
                          it['active'] = false;
                        });
                        item['active'] = true;
                        currentTimeText = item['name'];
                        getSalesTopData().then((res) {
                          setState(() {});
                        });
                      },
                      child: Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: item['active']
                              ? AppTheme.primaryColor
                              : AppTheme.subTextColor,
                          fontWeight: item['active']
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            child: FutureBuilder(
              future: _salesTopFutureBuilder,
              builder: (context, snapshot) {
                if (hasData) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: salesTopData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 15.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppTheme.bottomBorderColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // seq
                              Container(
                                width: 25.w,
                                height: 25.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.w),
                                  border: Border.all(
                                    width: 1,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text('${index + 1}'),
                                ),
                              ),

                              /// info
                              Container(
                                margin: EdgeInsets.fromLTRB(15.w, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60.w,
                                      height: 60.w,
                                      decoration: BoxDecoration(
                                        color: AppTheme.bottomBorderColor,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            salesTopData[index]
                                                ['goodsPictureUrl'],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10.w),
                                            child: Text(
                                              '${salesTopData[index]['goodsName']}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '销量：${salesTopData[index]['quantity']}',
                                              style: TextStyle(
                                                color: AppTheme.subTextColor,
                                                fontSize: 15.sp,
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
                      },
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.all(30.w),
                    child: Center(
                      child: Text(
                        '暂无数据...',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future getSalesTopData() async {
  startTime = Utils.getTimeByRange(currentTimeText)['startTime'];
  endTime = Utils.getTimeByRange(currentTimeText)['endTime'];

  var response = await getSaleTop(currentTimeText != '全部'
      ? {'startTime': startTime, 'endTime': endTime}
      : null);

  salesTopData = response.data['data'] ?? [];

  hasData = salesTopData.length > 0;
  return salesTopData;
}
