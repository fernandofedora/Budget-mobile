import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:budget_mobile/di/injection.dart';
import 'package:budget_mobile/features/expense/domain/expense.dart';
import 'package:budget_mobile/features/expense/infrastructure/repository/i_expense_repository.dart';

part 'expense_provider.g.dart';

@riverpod
class Expenses extends _$Expenses {
  @override
  ExpenseData build() {
    return ExpenseData();
  }

  Future<void> fetchExpenses({required int budgetId}) async {
    final expenses = await locator<IExpenseRepository>().fetchExpenses(budgetId: budgetId);
    state = state.copyWith(expenses: expenses);
  }

  Future<void> createExpense({
    required int budgetId,
    required String description,
    required double amount,
  }) async {
    await locator<IExpenseRepository>().createExpense(
      budgetId: budgetId,
      description: description,
      amount: amount,
    );
  }

  Future<void> editExpense({
    required int id,
    required int budgetId,
    required String description,
    required double amount,
  }) async {
    await locator<IExpenseRepository>().editExpense(
      id: id,
      budgetId: budgetId,
      description: description,
      amount: amount,
    );
  }
}

class ExpenseData {
  final List<Expense> expenses;

  const ExpenseData({this.expenses = const []});

  ExpenseData copyWith({List<Expense>? expenses}) {
    return ExpenseData(expenses: expenses ?? this.expenses);
  }
}
