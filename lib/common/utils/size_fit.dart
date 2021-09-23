import 'dart:ui';

class SizeFit {
  static num physicalWidth;
  static num physicalHeight;
  static num screenWidth;
  static num screenHeight;
  static num dpr;
  static num statusHeight;

  static num rpx;
  static num px;

  static void initialize({standardSize = 750}) {
    // 1. 手机的物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    // 2. 求出dpr
    dpr = window.devicePixelRatio;

    // 3. 求出逻辑的宽高
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    // 4. 状态栏高度
    statusHeight = window.padding.top / dpr;

    // 5. 计算rpx
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static num setRpx(num size) {
    return size * rpx;
  }

  static num setPx(num size) {
    return size * px;
  }
}
