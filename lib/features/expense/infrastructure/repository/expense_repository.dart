import 'package:injectable/injectable.dart';

import 'package:budget_mobile/features/expense/domain/expense.dart';
import 'package:budget_mobile/features/expense/infrastructure/repository/i_expense_repository.dart';
import 'package:budget_mobile/features/expense/infrastructure/data_source/i_expense_data_source.dart';

@LazySingleton(as: IExpenseRepository)
class ExpenseRepository implements IExpenseRepository {
  final IExpenseDataSource _dataSource;

  const ExpenseRepository(this._dataSource);

  @override
  Future<void> createExpense({
    required int budgetId,
    required String description,
    required double amount,
  }) async {
    return await _dataSource.createExpense(
      budgetId: budgetId,
      description: description,
      amount: amount,
    );
  }

  @override
  Future<List<Expense>> fetchExpenses({required int budgetId}) async {
    return await _dataSource.fetchExpenses(budgetId: budgetId);
  }

  @override
  Future<void> editExpense({
    required int id,
    required int budgetId,
    required String description,
    required double amount,
  }) async {
    return await _dataSource.editExpense(
      id: id,
      budgetId: budgetId,
      description: description,
      amount: amount,
    );
  }
}
