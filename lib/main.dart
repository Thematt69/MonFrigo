import 'dart:async';
import 'dart:developer' as dev;
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mon_frigo/app.dart';
import 'package:mon_frigo/firebase_options.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await initializeDateFormatting('fr_FR');

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (!kIsWeb) {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };

        Isolate.current.addErrorListener(
          RawReceivePort((List<dynamic> errorAndStacktrace) async {
            await FirebaseCrashlytics.instance.recordError(
              errorAndStacktrace.first,
              errorAndStacktrace.last as StackTrace?,
              fatal: true,
            );
          }).sendPort,
        );
      }

      runApp(const MyApp());
    },
    (error, stack) {
      dev.log(
        'ERREUR main => $error',
        error: error,
        stackTrace: stack,
      );
    },
  );
}
