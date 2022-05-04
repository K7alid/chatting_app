import 'package:bloc/bloc.dart';
import 'package:chatting_app/bloc_observer.dart';
import 'package:chatting_app/cache_helper.dart';
import 'package:chatting_app/social_layout.dart';
import 'package:chatting_app/social_login/social_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // call Firebase.initializeApp()
  // bool? isDark = CacheHelper.getBoolean(
  //   key: 'isDark',
  // );
  await CacheHelper.init();
  CacheHelper.init();
  Widget widget;
  var uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  // DioHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.startWidget}) : super(key: key);

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
