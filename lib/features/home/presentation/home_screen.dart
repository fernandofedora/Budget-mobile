import 'package:budget_mobile/core/routes/router.gr.dart';
import 'package:budget_mobile/features/expense/application/expense_provider.dart';
import 'package:budget_mobile/features/home/domain/budget.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:budget_mobile/features/home/application/budget_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _amountCtrl;
  bool _loading = false;

  @override
  void initState() {
    _nameCtrl = TextEditingController();
    _amountCtrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(budgetsProvider.notifier).fetchBudgets();
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final budgetsData = ref.watch(budgetsProvider);
    final expensesData = ref.watch(expensesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Budget APP', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: false,
              title: Text('Agregar presupuesto'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextField(
                        controller: _amountCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Monto',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: _loading ? () {} : _addBudget,
                        child: Text(_loading ? '...' : 'Agregar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            budgetsData.budgets.isEmpty
                ? const Text('No hay presupuestos creados')
                : ListView.builder(
                    itemCount: budgetsData.budgets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final budget = budgetsData.budgets[index];
                      return ExpansionTile(
                        title: Text(budget.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Monto: ${budget.amount.toString()}'),
                            Text('Restante: ${budget.remaining.toString()}'),
                            ElevatedButton(
                              onPressed: () => _openDialog(budget),
                              child: const Text('Agregar Gastos'),
                            ),
                          ],
                        ),
                        onExpansionChanged: (value) async {
                          if (value) {
                            await ref
                                .read(expensesProvider.notifier)
                                .fetchExpenses(budgetId: budget.id);
                          }
                        },

                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              return ListView.builder(
                                itemCount: expensesData.expenses.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final expense = expensesData.expenses[index];
                                  return ListTile(
                                    title: Text(expense.description),
                                    subtitle: Column(
                                      children: [
                                        Text('Monto: ${expense.amount.toString()}'),
                                        Text('Fecha: ${expense.date}'),
                                      ],
                                    ),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        context.router.push(
                                          EditExpenseRoute(
                                            id: expense.id,
                                            budgetId: budget.id,
                                            description: expense.description,
                                            amount: expense.amount,
                                          ),
                                        );
                                      },
                                      child: const Text('Editar'),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _addBudget() async {
    if (_nameCtrl.text.isEmpty || _amountCtrl.text.isEmpty) {
      return;
    }
    setState(() => _loading = true);
    try {
      await ref
          .read(budgetsProvider.notifier)
          .createBudget(name: _nameCtrl.text, amount: double.parse(_amountCtrl.text));
    } catch (e) {
      debugPrint(e.toString());
    }
    _nameCtrl.clear();
    _amountCtrl.clear();
    setState(() => _loading = false);
  }

  void _openDialog(Budget budget) {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Gastos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Monto', border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(expensesProvider.notifier)
                      .createExpense(
                        description: descriptionController.text,
                        amount: double.parse(amountController.text),
                        budgetId: budget.id,
                      );
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
