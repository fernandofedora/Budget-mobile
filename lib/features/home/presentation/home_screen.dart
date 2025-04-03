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
                    return ListTile(
                      title: Text(budget.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Monto: ${budget.amount.toString()}'),
                          Text('Restante: ${budget.remaining.toString()}'),
                        ],
                      ),
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
}
