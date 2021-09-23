/// 应用全局配置
class AppConfig {
  AppConfig._();

  /// 是否生产环境
  static const bool isProd = const bool.fromEnvironment('dart.vm.product');

  /// 应用名称
  static String appName = '老酒客${!isProd ? '(Debug)' : ''}';

  /// 开发环境
  static String devBaseUrl = 'https://app.luoyanglaojiu.com/api';

  // static String devBaseUrl = 'http://wine-admin.antengtech.com/api';

  /// 生产环境
  static String prodBaseUrl = 'https://app.luoyanglaojiu.com/api';

  /// api基础路径
  static String baseUrl = isProd ? prodBaseUrl : devBaseUrl;

  /// api白名单
  static List<String> whitelist = ['/uaa/login'];
}
