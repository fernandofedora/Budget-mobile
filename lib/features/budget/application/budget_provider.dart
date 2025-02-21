import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_provider.g.dart';

@riverpod
Future<List<dynamic>> getBudgets(Ref ref) async {
  return Future.value([]);
}