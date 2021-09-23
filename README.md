# 老酒客

老酒客

## 启动

flutter run

## 修改应用图标

#### Android

    1. 在 \android\app\src\main\res 下对应的文件夹（mipmap-hdpi、mipmap-mdpi。。。）添加图片
    2. \android\app\src\main\AndroidManifest.xml 修改引用的图片路径

#### iOS

    1. 在 \ios\Runner\Assets.xcassets\AppIcon.appiconset 修改图片文件
    2. 在 \ios\Runner\Assets.xcassets\AppIcon.appiconset\Contents.json 修改引用文件

## Iconfont 使用方法

    1. 下载iconfont 到本地，解压，iconfont.tff 文件放到 assets/fonts目录下
    2. 将iconfont.css 转成dart文件 ：https://xwrite.gitee.io/blog/
    3. 在lib下新建文件夹fonts，将转化后的iconfont.dart 放到该目录下
    4. 修改pubspec.yarml
        fonts:
            - family: IconFont
            fonts:
                - asset: assets/fonts/iconfont.ttf
    5. 使用： Icon(Iconfont.icon_arrow)

## 修改启动页

#### For Android

    /android/app/src/main/res/drawable/launch_background.xml

    只需修改这个文件即可。

    其他根据需求也可以自行修改values下的style文件，然后在AndroidManifest.xml文件设置给activity即可

#### For iOS

    /ios/Runner/Assets.xcassets/LaunchImage.imageset

    根据需求修改LaunchImage图片文件，并在同级别的Contents.json文件中配置即可

## 网络请求 Dio

## 文件上传

## 本地数据存储 shared_preferences

## 打包 apk

    1: 在命令行输入flutter doctor -v找到Android toolchain栏目下的Java binary at：,
        cd 进入这个目录：
        例如：C:\Program Files\Java\jdk-12.0.1\bin\

        生成keystore：

        命令行输入：
        keytool -genkey -v -keyalg RSA -keysize 2048 -validity 10000 -alias key -keystore /D:\AndroidFile/key.jks/

        输入秘钥口令：例如：123456
        再次输入确认
        最后生成 这个key.jks文件, 把key.jks 文件拷贝到项目android目录下

    2. 在项目android/app路径下修改build.gradle配置

        signingConfigs {
            release {
                // keyAlias "创建的密钥别名，如果不知道可以去key.jsk文件所在目录输入keytool -list -v -keystore key.jks -storepass 对应的密码"
                keyAlias "key"
                keyPassword "对应的密码"
                storeFile file('../key.jks')
                storePassword "对应的密码"
            }
        }
        buildTypes {
            release {
                signingConfig signingConfigs.release
            }
        }

    3. 运行flutter build apk , 打包生成的apk在build\app\outputs\flutter-apk 目录下

## 微信支付、支付宝支付

## Dio 请求错误

    报错：Unhandled Exception: DioError [DioErrorType.other]: Bad state: Insecure HTTP is not allowed by platform:

#### For Android:

    Just add in android/app/src/main/AndroidManifest.xml:

    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="receipt"
        android:usesCleartextTraffic="true" <!-- This Line -->
        android:icon="@mipmap/ic_launcher">

#### For iOS

    ios/Runner/info.plist:

    <key>NSAppTransportSecurity</key>
    <dict>
            <key>NSAllowsArbitraryLoads</key>
            <true/>
    </dict>
