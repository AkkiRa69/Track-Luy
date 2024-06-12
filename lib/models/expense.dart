import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime date;
  final String des;
  final String emoji;

  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.des,
    required this.emoji,
  });
}
