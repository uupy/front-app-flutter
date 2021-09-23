import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import "package:merge_map/merge_map.dart";
import 'package:wine/common/app_store.dart';
import 'package:wine/config/config.dart';
import 'package:wine/common/app.dart';

Map<int, String> errorMessages = {
  400: 'Bad Request',
  401: '权限已过期',
  403: '无权访问',
  502: '502 Bad Gateway',
};

var logger = Logger();

/// 请求拦截器
Interceptor requestInterceptor() {
  int code = 0;
  String msg = '';
  String _token;
  return InterceptorsWrapper(
    onRequest: (options, handler) async {
      /// 获取token
      _token = await authToken.get();

      /// headers
      List<Map<String, dynamic>> headersMaps = [
        {'token': _token},
        options?.headers,
      ];

      /// options
      RequestOptions _options = options ?? Options();

      /// 合并headers
      _options.headers = mergeMap(headersMaps);

      return handler.next(options);
    },
    onResponse: (options, handler) {
      return handler.next(options);
    },
    onError: (error, handler) {
      var errReq = error.requestOptions;
      var errRes = error.response;
      code = errRes?.statusCode;

      if (errRes?.data != null && code != 502) {
        msg = errRes.data['message'];
      }
      msg = msg ?? errorMessages[code] ?? '服务器异常';

      /// 登录过期
      if (code == null ||
          code == 401 ||
          (code == 500 && errReq?.path == '/app/my/info')) {
        app.logout();
      }
      logger.e('error.response: $code, $errRes');

      if (errReq?.extra['silent'] != true || code == 500) {
        app.showToast(msg);
      }
      handler.next(error);
    },
  );
}

class HttpRequest {
  /// 单例对象
  static HttpRequest _instance;

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory HttpRequest.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    _instance ??= HttpRequest._internal();
    return _instance;
  }

  Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: 10000,
  ));

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  HttpRequest._internal() {
    /// 添加请求拦截器
    dio.interceptors.add(requestInterceptor());
  }

  /// get请求
  Future get(String path, {data, queryParameters, Options options}) async {
    return await dio.get(
      path,
      queryParameters: data ?? queryParameters,
      options: options,
    );
  }

  /// post请求
  Future post(String path, {data, Options options}) async {
    /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
    /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
    /// 就会自动编码请求体.
    Options _options = options ?? Options();
    _options.contentType = Headers.formUrlEncodedContentType;
    return await dio.post(
      path,
      data: data,
      options: _options,
    );
  }

  /// post请求
  Future postJson(String path, {data, Options options}) async {
    return await dio.post(
      path,
      data: data,
      options: options,
    );
  }

  /// post请求
  Future put(String path, {data, Options options}) async {
    return await dio.put(
      path,
      data: data,
      options: options,
    );
  }

  /// post请求
  Future delete(String path, {data, Options options}) async {
    return await dio.delete(
      path,
      data: data,
      options: options,
    );
  }
}

final HttpRequest request = HttpRequest.getInstance();
