import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:budget_mobile/di/injection.dart';
import 'package:budget_mobile/features/home/domain/budget.dart';
import 'package:budget_mobile/features/home/infrastructure/repository/i_budget_repository.dart';

part 'budget_provider.g.dart';

@riverpod
class Budgets extends _$Budgets {
  @override
  BudgetData build() {
    return BudgetData();
  }

  Future<void> fetchBudgets() async {
    final budgets = await locator<IBudgetRepository>().fetchBudgets();
    state = state.copyWith(budgets: budgets);
  }

  Future<void> createBudget({required String name, required double amount}) async {
    final responseBudget = await locator<IBudgetRepository>().createBudget(
      name: name,
      amount: amount,
    );

    if (responseBudget == null) {
      return;
    }

    state = state.copyWith(budgets: [...state.budgets, responseBudget]);
  }
}

class BudgetData {
  final List<Budget> budgets;

  const BudgetData({this.budgets = const []});

  BudgetData copyWith({List<Budget>? budgets}) {
    return BudgetData(budgets: budgets ?? this.budgets);
  }
}
