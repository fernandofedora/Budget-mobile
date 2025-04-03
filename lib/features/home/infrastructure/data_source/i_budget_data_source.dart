import 'package:budget_mobile/features/home/domain/budget.dart';

abstract class IBudgetDataSource {
  Future<Budget?> createBudget({required String name, required double amount});
  Future<List<Budget>> fetchBudgets();
}
