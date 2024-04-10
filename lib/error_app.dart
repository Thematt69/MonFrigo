import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mon_frigo/extension/build_context.dart';
import 'package:mon_frigo/themes/color_schemes.dart';

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Builder(
        builder: (context) => const ErrorPage(),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Une erreur est survenue !',
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Veuillez réessayer plus tard',
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
