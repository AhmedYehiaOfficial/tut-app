import 'package:flutter/material.dart';
import 'package:flutter_adv/presentation/resources/routes_manger.dart';
import 'package:flutter_adv/presentation/resources/theme_manger.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

//Splash screen duration
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
// private named constructor
  MyApp._internal();

  int appState = 0;
  static final MyApp _instance =
      MyApp._internal(); //Singleton or single instance

  factory MyApp() => MyApp._instance; //factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute:RouteGenerator.getRoute,
      initialRoute: Routes.onBoardingRoute,
    );
  }
}
