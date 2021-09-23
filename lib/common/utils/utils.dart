import 'dart:async';

import 'package:package_info/package_info.dart'
    if (dart.library.html) 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_format/date_time_format.dart';

class Utils {
  /// 获取token
  static getStorage(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  // 根据时间段获取开始时间、结束时间
  static getTimeByRange(range) {
    String startTime;
    String endTime;
    var dateTime = DateTime.now();
    var day = dateTime.day;
    var week = dateTime.weekday;

    switch (range) {
      case '今天':
        startTime = Uri.decodeFull(dateTime.format('Y-m-d 00:00:00'));
        endTime = Uri.decodeFull(dateTime.format('Y-m-d 23:59:59'));
        break;
      case '昨天':
        startTime = Uri.decodeFull(
            (dateTime.subtract(Duration(days: 1))).format('Y-m-d 00:00:00'));
        endTime = Uri.decodeFull(
            (dateTime.subtract(Duration(days: 1))).format('Y-m-d 23:59:59'));
        break;
      case '本周':
        startTime = Uri.decodeFull((dateTime.subtract(Duration(days: week - 1)))
            .format('Y-m-d 00:00:00'));
        endTime = Uri.decodeFull(dateTime.format('Y-m-d 23:59:59'));
        break;
      case '上周':
        startTime = Uri.decodeFull(
            (dateTime.subtract(Duration(days: (7 - week + 1))))
                .format('Y-m-d 00:00:00'));
        endTime = Uri.decodeFull(
            (dateTime.subtract(Duration(days: (7 - week + 1) - 6)))
                .format('Y-m-d 23:59:59'));
        break;
      case '本月':
        startTime = Uri.decodeFull(dateTime.format('Y-m-01 00:00:00'));
        endTime = Uri.decodeFull(dateTime.format('Y-m-d 23:59:59'));
        break;
      case '上月':
        startTime = Uri.decodeFull((dateTime
                .subtract(Duration(days: day))
                .subtract(Duration(
                    days: dateTime.subtract(Duration(days: day)).day - 1)))
            .format('Y-m-d 00:00:00'));
        endTime = Uri.decodeFull(
            dateTime.subtract(Duration(days: day)).format('Y-m-d 23:59:59'));
        break;
      default:
        break;
    }

    Map time = {'startTime': startTime, 'endTime': endTime};
    return time;
  }

  /// 检测当前app版本
  static getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var currentVersion = packageInfo.version;
    return currentVersion;
  }

  /// 函数防抖
  ///
  /// [func]: 要执行的方法
  /// [delay]: 要迟延的时长
  static Function debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 600),
  ]) {
    Timer timer;
    Function target = () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func?.call();
      });
    };
    return target;
  }
}
