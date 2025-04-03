import 'package:injectable/injectable.dart';

import 'package:budget_mobile/features/home/domain/budget.dart';
import 'package:budget_mobile/features/home/infrastructure/repository/i_budget_repository.dart';
import 'package:budget_mobile/features/home/infrastructure/data_source/i_budget_data_source.dart';

@LazySingleton(as: IBudgetRepository)
class BudgetRepository implements IBudgetRepository {
  final IBudgetDataSource _dataSource;

  const BudgetRepository(this._dataSource);

  @override
  Future<Budget?> createBudget({required String name, required double amount}) async {
    return await _dataSource.createBudget(name: name, amount: amount);
  }

  @override
  Future<List<Budget>> fetchBudgets() async {
    return await _dataSource.fetchBudgets();
  }
}
