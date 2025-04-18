import 'package:budget_mobile/features/home/domain/budget.dart';

abstract class IBudgetRepository {
  Future<Budget?> createBudget({required String name, required double amount});
  Future<List<Budget>> fetchBudgets();
}
