import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:budget_mobile/core/constants/url.dart';
import 'package:budget_mobile/features/home/domain/budget.dart';
import 'package:budget_mobile/features/home/infrastructure/data_source/i_budget_data_source.dart';

@LazySingleton(as: IBudgetDataSource)
class BudgetDataSource implements IBudgetDataSource {
  final Dio _client;

  const BudgetDataSource(this._client);

  @override
  Future<Budget?> createBudget({required String name, required double amount}) async {
    final response = await _client.post(budgetBaseApiUrl, data: {'nombre': name, 'monto': amount});
    if (response.statusCode == 201) {
      return Budget.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<List<Budget>> fetchBudgets() async {
    final response = await _client.get(budgetBaseApiUrl);
    if (response.statusCode == 200) {
      final budgetResponse = response.data as List<dynamic>;
      return budgetResponse.map((e) => Budget.fromJson(e)).toList();
    }
    return [];
  }
}
