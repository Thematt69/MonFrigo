import 'dart:developer' as dev;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/bloc_provider.dart';
import 'blocs/firebase_auth_bloc.dart';
import 'blocs/firebase_storage_bloc.dart';
import 'extension/remote_notification.dart';
import 'firebase_options.dart';
import 'routes/router.dart';
import 'themes/color_schemes.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  dev.log('Got a message whilst in the background!', name: 'FirebaseMessaging');
  dev.log('Message data: ${message.data}', name: 'FirebaseMessaging');

  if (message.notification != null) {
    dev.log(
      'Message also contained a notification: ${message.notification?.displayString()}',
      name: 'FirebaseMessaging',
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (!kIsWeb) {
      _initMessaging();
    }
    super.initState();
  }

  Future<void> _initMessaging() async {
    await FirebaseMessaging.instance
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((settings) {
      dev.log(
        'User granted permission => ${settings.authorizationStatus}',
        name: 'FirebaseMessaging',
      );
    });

    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'default_notification_channel_id',
            'Toutes les notifications',
            ledColor: Color(0xFFF96152),
            importance: Importance.max,
          ),
        );

    await FirebaseMessaging.instance.getToken().then((fcmToken) {
      dev.log('FCM Token => $fcmToken', name: 'FirebaseMessaging');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      dev.log(
        'Got a message whilst in the foreground!',
        name: 'FirebaseMessaging',
      );
      dev.log('Message data: ${message.data}', name: 'FirebaseMessaging');

      if (message.notification != null) {
        dev.log(
          'Message also contained a notification: ${message.notification?.displayString()}',
          name: 'FirebaseMessaging',
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.getInitialMessage().then((initialMessage) {
      if (initialMessage != null) _handleMessage(initialMessage);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // TODO: Redirect to notification page
    // Navigator.pushNamed(
    //   context,
    //   '/chat',
    //   arguments: ChatArguments(message),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: GlobalKey(),
      blocs: <BlocBase>[
        FirebaseAuthBloc(),
        FirebaseStorageBloc(),
      ],
      child: MaterialApp.router(
        restorationScopeId: 'com.thematt69.mon_frigo',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English, United States
          Locale('fr', 'FR'), // French, France
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter.routerDelegate,
      ),
    );
  }
}
