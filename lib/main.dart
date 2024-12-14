import 'package:flutter/material.dart';
import 'package:project_seven_nike_welcomeback/data/favorite.manager.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';
import 'package:project_seven_nike_welcomeback/data/repo/auth_repositroy.dart';
import 'package:project_seven_nike_welcomeback/data/repo/banner_repository.dart';
import 'package:project_seven_nike_welcomeback/data/repo/product_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/root.dart';
import 'theme.dart';

void main() async {
await FavoriteManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    // for debugging
    productRepository.getAll(ProductSort.latest).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });
    // for debugging
    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    // تعریف فونت ثابت
    const defaultTextStyle = TextStyle(
        fontFamily: 'IranYekan', color: LightThemeColor.primaryTextColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // This is the theme of your application.
      theme: ThemeData(
        //اگر بخوایم متنی کم رنگ تر نمایش داده بشه
        hintColor: LightThemeColor.secondaryTextColor,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
          ),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: LightThemeColor.primaryTextColor.withOpacity(0.1)))
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            //سایه appBar حذف میشه
            elevation: 0,
            foregroundColor: LightThemeColor.primaryTextColor),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.apply(color: Colors.white)),
        textTheme: TextTheme(
          titleMedium:
          //LightThemeColor.secondaryTextColor
              defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
          bodyMedium: defaultTextStyle,
          labelLarge: defaultTextStyle,
          bodySmall:
              defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
          titleLarge: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 16),
        ),
        // از لاین زیری استفاده میشه برای تعریف رنگ های مختلف تم
        colorScheme: const ColorScheme.light(
            primary: LightThemeColor.primaryTextColor,
            secondary: LightThemeColor.secondaryColor,
            // هرچیزی که رو سکندری ما قرار داره با لاین زیر بهش رنگ میدیم
            onSecondary: Colors.white,
        surfaceVariant: Color(0xffF5F5F5)),
      ),
      //برای راستچین کردن برنامه از دو لاین زیر استفاده میکنیم
      home: const Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
