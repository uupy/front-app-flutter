import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 应用存储
class AppStore<T> {
  SharedPreferences _store;
  String name;
  bool isJson;

  /// 构造
  AppStore(this.name, {this.isJson}) : assert(name.isNotEmpty);

  Future<SharedPreferences> getPrefs() async {
    _store ??= await SharedPreferences.getInstance();
    return _store;
  }

  Future<T> get() async {
    await getPrefs();
    var _value;
    if (T is String || isJson == true) {
      _value = _store.getString(name);
      if (isJson == true && _value != null) {
        _value = json.decode(_value);
      }
    } else if (T is bool) {
      _value = _store.getBool(name);
    } else if (T is int) {
      _value = _store.getInt(name);
    } else if (T is double) {
      _value = _store.getDouble(name);
    } else if (T is List<String>) {
      _value = _store.getStringList(name);
    } else {
      _value = _store.get(name);
    }
    return _value;
  }

  Future set(T value) async {
    await getPrefs();
    if (value is String || isJson == true) {
      await _store.setString(name, isJson == true ? json.encode(value) : value);
    } else if (value is bool) {
      await _store.setBool(name, value);
    } else if (value is int) {
      await _store.setInt(name, value);
    } else if (value is double) {
      await _store.setDouble(name, value);
    } else if (value is List<String>) {
      await _store.setStringList(name, value);
    }
    return value;
  }

  Future<bool> remove() async {
    await getPrefs();
    bool result = await _store.remove(name);
    return result;
  }
}

/// 认证token
AppStore<String> authToken = new AppStore('token');

/// 登录用户信息
AppStore<dynamic> loginUser = new AppStore('userInfo', isJson: true);

/// 用户是否同意隐私政策
AppStore<String> hasAcceptAgreement = new AppStore('hasAcceptAgreement');
