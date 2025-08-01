import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:budget_mobile/core/constants/url.dart';
import 'package:budget_mobile/features/expense/domain/expense.dart';
import 'package:budget_mobile/features/expense/infrastructure/data_source/i_expense_data_source.dart';

@LazySingleton(as: IExpenseDataSource)
class ExpenseDataSource implements IExpenseDataSource {
  final Dio _client;

  const ExpenseDataSource(this._client);

  @override
  Future<void> createExpense({
    required int budgetId,
    required String description,
    required double amount,
  }) async {
    await _client.post(
      expenseBaseApiUrl,
      data: {
        'presupuestoId': budgetId,
        'descripcion': description,
        'monto': amount,
        'fecha': DateTime.now().toIso8601String(),
      },
    );
  }

  @override
  Future<List<Expense>> fetchExpenses({required int budgetId}) async {
    final response = await _client.get('$expenseBaseApiUrl?presupuestoId=$budgetId');
    if (response.statusCode == 200) {
      final expenseResponse = response.data as List<dynamic>;
      return expenseResponse.map((e) => Expense.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> editExpense({
    required int id,
    required int budgetId,
    required String description,
    required double amount,
  }) async {
    await _client.put(
      '$expenseBaseApiUrl/$id',
      data: {
        'presupuestoId': budgetId,
        'descripcion': description,
        'monto': amount,
        'fecha': DateTime.now().toIso8601String(),
      },
    );
  }
}
