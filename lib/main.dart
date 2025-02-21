import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:budget_mobile/budget_app.dart';
import 'package:budget_mobile/di/injection.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await di.configure();

  runApp(const ProviderScope(child: BudgetApp()));
}
