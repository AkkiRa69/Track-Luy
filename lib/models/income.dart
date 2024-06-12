import 'package:isar/isar.dart';

part 'income.g.dart';

@Collection()
class Income {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime date;
  final String des;
  final String emoji;

  Income({
    required this.name,
    required this.amount,
    required this.date,
    required this.des,
    required this.emoji,
  });
}
