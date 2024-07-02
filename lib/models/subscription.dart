import 'package:isar/isar.dart';

part 'subscription.g.dart';

@Collection()
class Subscription {
  Id id = Isar.autoIncrement;
  final String name; // Name of the subscription service (e.g., Netflix, Spotify)
  final String image;
  final double amount; // Monthly cost of the subscription
  final DateTime startDate; // Start date of the subscription

  Subscription({
    required this.name,
    required this.image,
    required this.amount,
    required this.startDate,
  });

  @ignore
  DateTime get dueDate => startDate.add(Duration(days: 30)); // Assuming a 30-day period

  @ignore
  int get remainingDays {
    DateTime now = DateTime.now();
    return dueDate.difference(now).inDays;
  }
}
