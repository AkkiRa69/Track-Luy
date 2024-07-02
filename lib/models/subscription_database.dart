import 'package:akkhara_tracker/models/subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'expense_database.dart'; // Import your ExpenseDatabase class

class SubscriptionDatabase extends ChangeNotifier {
  // List of predefined subscriptions
  final List<Subscription> _subList = [
    Subscription(
      name: 'Netflix',
      image: 'assets/subscriptions/netflix.png',
      amount: 14.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'Spotify',
      image: 'assets/subscriptions/spotify.png',
      amount: 12.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'Github',
      image: 'assets/subscriptions/github.png',
      amount: 8.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'Youtube',
      image: 'assets/subscriptions/youtube.png',
      amount: 7.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'App Store',
      image: 'assets/subscriptions/appstore.png',
      amount: 10.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'Play Store',
      image: 'assets/subscriptions/playstore.png',
      amount: 7.65,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'Dribble',
      image: 'assets/subscriptions/dribble.png',
      amount: 6.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'ChatGPT',
      image: 'assets/subscriptions/chatgpt.png',
      amount: 15.99,
      startDate: DateTime.now(),
    ),
    Subscription(
      name: 'Shopify',
      image: 'assets/subscriptions/shopify.png',
      amount: 11.99,
      startDate: DateTime.now(),
    ),
  ];
  List<Subscription> get subList => _subList;

  final List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;

  // Add subscription
  Future<void> addSub(Subscription sub) async {
    try {
      final existingSub = await ExpenseDatabase.isar.subscriptions
          .filter()
          .nameEqualTo(sub.name)
          .findFirst();

      if (existingSub == null) {
        await ExpenseDatabase.isar.writeTxn(() async {
          await ExpenseDatabase.isar.subscriptions.put(sub);
        });
        await readSub();
        Get.snackbar('Message', "Paid Successfully!");
      } else {
        Get.snackbar('Error', "${sub.name} Is Already Exists.");
      }
    } catch (e) {
      print("Error adding subscription: $e");
    }
  }

  double totalAmount() {
    double total = 0;
    for (Subscription sub in _subscriptions) {
      total += sub.amount;
    }
    return total;
  }

  double highestSub() {
    if (_subscriptions.isEmpty) {
      return 0; // or handle as needed for empty lists
    }

    double amount = _subscriptions[0].amount;
    for (Subscription sub in _subscriptions) {
      if (sub.amount > amount) {
        amount = sub.amount;
      }
    }
    return amount;
  }

  double lowestSub() {
    if (_subscriptions.isEmpty) {
      return 0; // or handle as needed for empty lists
    }

    double amount = _subscriptions[0].amount;
    for (Subscription sub in _subscriptions) {
      if (sub.amount < amount) {
        amount = sub.amount;
      }
    }
    return amount;
  }

  // Read subscriptions
  Future<void> readSub() async {
    try {
      final subs = await ExpenseDatabase.isar.subscriptions.where().findAll();
      _subscriptions.clear();
      _subscriptions.addAll(subs);
      notifyListeners();
    } catch (e) {
      print("Error reading subscriptions: $e");
    }
  }

  // Delete subscription
  Future<void> deleteSub(int id) async {
    try {
      await ExpenseDatabase.isar.writeTxn(() async {
        await ExpenseDatabase.isar.subscriptions.delete(id);
      });
      await readSub();
    } catch (e) {
      print("Error deleting subscription: $e");
    }
  }

  // Update subscription
  Future<void> updateSub(Subscription sub) async {
    try {
      await ExpenseDatabase.isar.writeTxn(() async {
        await ExpenseDatabase.isar.subscriptions.put(sub);
      });
      await readSub();
    } catch (e) {
      print("Error updating subscription: $e");
    }
  }
}
