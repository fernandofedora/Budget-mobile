import 'package:budget_mobile/features/expense/application/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EditExpenseScreen extends ConsumerStatefulWidget {
  final int id;
  final int budgetId;
  final String description;
  final double amount;

  const EditExpenseScreen({
    super.key,
    required this.id,
    required this.budgetId,
    required this.description,
    required this.amount,
  });

  @override
  ConsumerState<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends ConsumerState<EditExpenseScreen> {
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _amountCtrl;

  @override
  void initState() {
    _descriptionCtrl = TextEditingController(text: widget.description);
    _amountCtrl = TextEditingController(text: widget.amount.toString());
    super.initState();
  }

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Gasto')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _descriptionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: 'Monto', border: OutlineInputBorder()),
              ),
              ElevatedButton(onPressed: _saveExpense, child: const Text('Guardar')),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveExpense() async {
    await ref
        .read(expensesProvider.notifier)
        .editExpense(
          id: widget.id,
          budgetId: widget.budgetId,
          description: _descriptionCtrl.text,
          amount: double.parse(_amountCtrl.text),
        );
    // pop
    context.router.pop();
  }
}
