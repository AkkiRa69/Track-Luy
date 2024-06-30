import 'dart:io';

import 'package:akkhara_tracker/models/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class SubscriptionDatabase extends ChangeNotifier {
  static late Isar isar;

  //INITIALIZE
  static Future<void> initialize() async {
    Directory dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [SubscriptionSchema],
      directory: dir.path,
    );
  }

  //LIST OF SUB
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

  List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;

  //ADD SUB
  Future<void> addSub(Subscription sub) async {
    await isar.writeTxn(
      () => isar.subscriptions.put(sub),
    );
    await readSub();
  }

  //READ SUB
  Future<void> readSub() async {
    final subs = await isar.subscriptions.where().findAll();
    _subscriptions.clear();
    _subscriptions.addAll(subs);
    notifyListeners();
  }

  //DELETE SUB
  Future<void> deleteSub(int id) async {
    await isar.writeTxn(
      () => isar.subscriptions.delete(id),
    );
    await readSub();
  }

  //UPDATE SUB
}
