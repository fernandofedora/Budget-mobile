class Expense {
  final int id;
  final int budgetId;
  final String description;
  final double amount;
  final String date;

  const Expense({
    required this.id,
    required this.budgetId,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    final amount = json['monto'] as dynamic;
    final date = json['fecha'] as String;

    return Expense(
      id: json['id'],
      budgetId: json['presupuestoId'],
      description: json['descripcion'],
      amount: double.parse(amount.toString()),
      date: date,
    );
  }
}
