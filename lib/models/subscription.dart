import 'package:isar/isar.dart';

part 'subscription.g.dart';

@Collection()
class Subscription {
  Id id = Isar.autoIncrement;
  final String name; // Name of the subscription service (e.g., Netflix, Spotify)
  final double amount; // Monthly cost of the subscription
  final DateTime startDate; // Start date of the subscription
  final DateTime? endDate; // End date of the subscription (if any)
  final String description; // Description of the subscription
  final String category; // Category of the subscription (e.g., Entertainment, Music)
  final bool autoRenew; // Whether the subscription renews automatically

  Subscription({
    required this.name,
    required this.amount,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.category,
    required this.autoRenew,
  });
}
