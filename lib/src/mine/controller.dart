import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wine/api/common.dart';
import 'package:wine/common/app_store.dart';
import 'package:wine/fonts/iconfont.dart';
import 'package:wine/src/mine/model.dart';

class MineMenu {
  const MineMenu({
    @required this.name,
    @required this.icon,
    this.path,
    this.key,
    this.permission,
  }) : assert(name != null && icon != null);
  final String name;
  final IconData icon;
  final String path;
  final String key;

  /// -1 老板 0 推广员 1 股东 2 员工
  final List<int> permission;
}

final List<List<MineMenu>> fullMenus = [
  [
    MineMenu(
      name: '账号管理',
      icon: IconFont.icon_user_manager,
      path: 'account-list',
      permission: [-1],
    ),
    MineMenu(
      name: '创客管理',
      icon: IconFont.icon_user_manager2,
      path: 'promoter-list',
      permission: [-1, 1],
    ),
  ],
  [
    MineMenu(
      name: '采购记录',
      icon: IconFont.icon_order,
      path: 'purcharse-log',
      permission: [-1],
    ),
    MineMenu(
      name: '库存调整记录',
      icon: IconFont.icon_stock,
      path: 'stock-log',
      permission: [-1, 1],
    ),
  ],
  [
    MineMenu(
      name: '我的推广',
      icon: IconFont.icon_sound,
      path: 'my-promotion',
    ),
  ],
  [
    MineMenu(
      name: '体验馆钱包',
      icon: IconFont.icon_wallet,
      path: 'my-wallet',
      key: 'bizWallet',
      permission: [-1],
    ),
    MineMenu(
      name: '我的钱包',
      icon: IconFont.icon_wallet,
      path: 'my-wallet',
      key: 'myWallet',
    ),
  ],
  [
    MineMenu(
      name: '修改密码',
      icon: IconFont.icon_lock,
      path: 'change-password',
    ),
    MineMenu(
      name: '退出登录',
      icon: IconFont.icon_logout,
      path: '',
      key: 'logout',
    ),
  ],
];

class MineController extends GetxController {
  UserVo user;
  List<List<MineMenu>> menusList = [];

  Future getUser() async {
    menusList = [];
    final info = await loginUser.get();
    user = UserVo.fromJson(info ?? {});
    int userRole = user?.isAdmin == true ? -1 : user?.roleType?.value;
    fullMenus.forEach((items) {
      List<MineMenu> list = items.where((item) {
        if (item.permission == null) {
          return true;
        }
        if (item.permission.contains(userRole)) {
          return true;
        }
        return false;
      }).toList();
      if (!list.isBlank) {
        menusList.add(list);
      }
    });
    update();
  }

  Future fetchData() async {
    final res = await getUserInfo();
    final data = res.data['data'];
    await loginUser.set(data);
    getUser();
  }
}
