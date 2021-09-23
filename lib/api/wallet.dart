import 'package:wine/common/http/request.dart';

/// 绑定银行卡
bindCard(data) {
  return request.postJson('/common/wallet/card/bind', data: data);
}

/// 解绑银行卡
unbindCard(data) {
  return request.postJson('/common/wallet/card/unbind', data: data);
}

/// 获取绑定的卡列表
queryCardList(String walletId) {
  return request.get('/common/wallet/card/list/$walletId');
}

/// 获取我的钱包
getMyWallet() {
  return request.get('/common/wallet/myWallet');
}

/// 获取业务钱包
getBizWallet() {
  return request.get('/app/my/bizWallet');
}

/// 获取钱包的分润明细分页
queryMyProfitPage(String walletId, {data}) {
  return request.get(
    '/common/wallet/myProfit/page/$walletId',
    queryParameters: data,
  );
}

/// 获取钱包的提现分页
queryMyWithdrawPage(String walletId, {data}) {
  return request.get(
    '/common/wallet/myWithdraw/page/$walletId',
    queryParameters: data,
  );
}

/// 提现申请
withdrawApply(data) {
  return request.postJson('/common/wallet/withdraw/apply', data: data);
}
