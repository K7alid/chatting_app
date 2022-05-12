import 'package:chatting_app/shared/bloc_observer.dart';
import 'package:chatting_app/shared/cache_helper.dart';
import 'package:chatting_app/shared/components.dart';
import 'package:chatting_app/shared/constants.dart';
import 'package:chatting_app/shared/themes.dart';
import 'package:chatting_app/social_layout/cubit/cubit.dart';
import 'package:chatting_app/social_layout/cubit/states.dart';
import 'package:chatting_app/social_layout/social_layout.dart';
import 'package:chatting_app/social_login/social_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('This is on background message ${message.data.toString()}');
  showToast(
    text: 'on background message',
    state: ToastStates.SUCCESS,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print('This is on message ${event.data.toString()}');
    showToast(
      text: 'on message',
      state: ToastStates.SUCCESS,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('This is on message opened app ${event.data.toString()}');
    showToast(
      text: 'on message opened app',
      state: ToastStates.SUCCESS,
    );
  });

  FirebaseMessaging.onBackgroundMessage(
      (message) => firebaseMessagingBackgroundHandler(message));

  // call Firebase.initializeApp()
  // bool? isDark = CacheHelper.getBoolean(
  //   key: 'isDark',
  // );
  //token = CacheHelper.getData(key: 'token');
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
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
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
