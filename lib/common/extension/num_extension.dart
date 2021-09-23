import 'package:wine/common/utils/size_fit.dart';

extension NumFit on num {
  num get px {
    return SizeFit.setPx(this);
  }

  num get rpx {
    return SizeFit.setRpx(this);
  }
}
