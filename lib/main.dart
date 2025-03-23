import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:budget_mobile/budget_app.dart';
import 'package:budget_mobile/di/injection.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_mobile/core/shared/sp_service/sp_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await di.configure();
  await di.locator.isReady<SPService>();

  runApp(const ProviderScope(child: BudgetApp()));
}
