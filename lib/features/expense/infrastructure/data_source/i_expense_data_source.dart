import 'package:budget_mobile/features/expense/domain/expense.dart';

abstract class IExpenseDataSource {
  Future<void> createExpense({
    required int budgetId,
    required String description,
    required double amount,
  });
  Future<List<Expense>> fetchExpenses({required int budgetId});
  Future<void> editExpense({
    required int id,
    required int budgetId,
    required String description,
    required double amount,
  });
}
