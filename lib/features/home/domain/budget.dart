class Budget {
  final int id;
  final String name;
  final double amount;
  final double remaining;

  const Budget({
    required this.id,
    required this.name,
    required this.amount,
    required this.remaining,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    final amount = json['monto'] as int;
    final remaining = json['restante'] as int;

    return Budget(
      id: json['id'],
      name: json['nombre'],
      amount: double.parse(amount.toString()),
      remaining: double.parse(remaining.toString()),
    );
  }
}
