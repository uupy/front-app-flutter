import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wine/api/common.dart';
import 'package:wine/common/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var _adsFutureBuilder;
List homeAds;

class HomeBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeBanner();
  }
}

class _HomeBanner extends State<HomeBanner> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    _adsFutureBuilder = getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 15.w),
        child: FutureBuilder(
          future: _adsFutureBuilder,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Swiper(
                /// 解决滑动切换时，下一个图片加载慢的问题
                viewportFraction: 0.99999,
                autoplay: true,
                autoplayDelay: 5000,
                itemCount: homeAds.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.bottomBorderColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(homeAds[index]['pictureUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                pagination: new SwiperPagination(),
                onTap: (index) {
                  print('---------- data $index');
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

Future getAds() async {
  var response = await getAdsByCode({'positionCode': 'home-top-app'});
  homeAds = response.data['data']['data'];
  return homeAds;
}
