import 'package:feeling_meter/presentation/home_page.dart';
import 'package:feeling_meter/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'SF Pro Rounded'),
      //defaultTransition: Transition.l,
      getPages: [
        GetPage(name: "/splash_screen", page: () => const SplashScreen()),
        GetPage(name: "/home_page", page: () => HomePage()),
      ],
      initialRoute: "/splash_screen",
    );
  }
}
