import 'package:get/get.dart';
import 'package:wine/index.dart';
import 'package:wine/router/router.dart';
import 'package:wine/src/account/edit/index.dart';
import 'package:wine/src/account/list/index.dart';
import 'package:wine/src/login/login.dart';
import 'package:wine/src/my_promotion/details.dart';
import 'package:wine/src/my_promotion/index.dart';
import 'package:wine/src/my_score_record/index.dart';
import 'package:wine/src/my_wallet/card/view.dart';
import 'package:wine/src/my_wallet/index/index.dart';
import 'package:wine/src/my_wallet/my_profit/index.dart';
import 'package:wine/src/my_wallet/withdraw_apply/index.dart';
import 'package:wine/src/my_wallet/withdraw_record/index.dart';
import 'package:wine/src/order_detail/index.dart';
import 'package:wine/src/order_offline/create/view.dart';
import 'package:wine/src/order_offline/detail/view.dart';
import 'package:wine/src/order_offline/goods_select/view.dart';
import 'package:wine/src/password/change_password/index.dart';
import 'package:wine/src/promoter/customer/list/index.dart';
import 'package:wine/src/promoter/customer/order/index.dart';
import 'package:wine/src/promoter/edit/index.dart';
import 'package:wine/src/promoter/list/index.dart';
import 'package:wine/src/purcharse_log/purcharse_log.dart';
import 'package:wine/src/agreement/register_agreement.dart';
import 'package:wine/src/agreement/using_agreement.dart';
import 'package:wine/src/password/forget_password/index.dart';
import 'package:wine/src/stock/logs/index.dart';

final List<AppRoute> routes = [
  AppRoute(
    name: '/login',
    page: Login(),
    transition: Transition.fade,
  ),
  AppRoute(
    name: '/index',
    page: IndexPage(),
    transition: Transition.fade,
  ),
  AppRoute(name: '/using-agreement', page: Using()),
  AppRoute(name: '/register-agreement', page: Register()),
  AppRoute(name: '/forget-password', page: ForgetPassword()),
  AppRoute(name: '/purcharse-log', page: PurcharseLog()),
  AppRoute(name: '/promoter-list', page: Promoter()),
  AppRoute(name: '/promoter-edit', page: PromoterEdit()),
  AppRoute(name: '/order-detail', page: OrderDetail()),
  AppRoute(name: '/order-offline-detail', page: OrderOfflineDetail()),
  AppRoute(name: '/order-offline-create', page: OrderOfflineCreate()),
  AppRoute(
      name: '/order-offline-goods-select', page: OrderOfflineGoodsSelect()),
  AppRoute(name: '/customer-list', page: CustomerList()),
  AppRoute(name: '/customer-order-list', page: CustomerOrderList()),
  AppRoute(name: '/account-list', page: AccountList()),
  AppRoute(name: '/account-edit', page: AccountEdit()),
  AppRoute(name: '/change-password', page: ChangePassword()),
  AppRoute(name: '/stock-log', page: StockLog()),
  AppRoute(name: '/my-promotion', page: MyPromotion()),
  AppRoute(name: '/my-promotion-details', page: MyPromotionDetails()),
  AppRoute(name: '/my-score-record', page: MyScoreRecord()),
  AppRoute(name: '/my-wallet', page: MyWalletIndex()),
  AppRoute(name: '/my-profit', page: MyProfit()),
  AppRoute(name: '/my-withdraw-record', page: MyWithdrawRecord()),
  AppRoute(name: '/my-withdraw-apply', page: MyWithdrawApply()),
  AppRoute(name: '/my-wallet-card', page: MyWalletCard()),
];
