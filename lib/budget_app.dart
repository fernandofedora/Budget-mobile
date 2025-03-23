import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:budget_mobile/di/injection.dart';
import 'package:budget_mobile/core/routes/router.dart';
import 'package:budget_mobile/generated/l10n.dart' show S;

class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => const _BudgetApp(),
      minTextAdapt: true,
      designSize: const Size(360, 640),
    );
  }
}

class _BudgetApp extends StatelessWidget {
  const _BudgetApp();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final MediaQueryData media = MediaQuery.of(context);
          return MediaQuery(
            data: media.copyWith(
              textScaler: media.textScaler.clamp(
                minScaleFactor: 1.0,
                maxScaleFactor: 1.2,
              ),
            ),
            child: child!,
          );
        },
        onGenerateTitle: (context) => 'Budget App',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('es'),
        routerConfig: locator<AppRouter>().config(),
      ),
    );
  }
}
