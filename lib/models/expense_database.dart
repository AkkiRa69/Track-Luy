import 'dart:core';
import 'dart:io';

import 'package:akkhara_tracker/models/category.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:akkhara_tracker/models/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'expense.dart'; // Ensure the correct path to your expense model

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize the Isar database
  static Future<void> initialize() async {
    Directory dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        ExpenseSchema,
        IncomeSchema,
        CategoriSchema,
        SubscriptionSchema
      ], // Ensure ExpenseSchema is correctly defined
      directory: dir.path,
    );
  }

  final List<Expense> _expensesList = [];
  List<Expense> get expenseList => _expensesList;

  final List<String> _categories = [
    '🍕 Food',
    '☕ Drink',
    '💼 Work',
    '🎈 Entertainment',
    '🏡 Apartment',
    '🚌 Travel',
    '💎 Subscriptions',
    '👖 Cloths',
    '📚 Studying',
    '🛵 Motorcycle',
    '💇 Haircut',
    '🎁 Gifts',
    '💊 Health',
  ];

  List<String> get categories => _categories;
  String get initializeCate => _categories.last;

  final List<DateTime> _dates = [
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 4)),
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now().subtract(const Duration(days: 6)),
    DateTime.now().subtract(const Duration(days: 7)),
  ];

  List<DateTime> get dates => _dates;

  Future<void> addCategory(String emoji, String name) async {
    // Create and save the category object
    Categori cate = Categori()
      ..emoji = emoji
      ..name = name;

    await isar.writeTxn(() => isar.categoris.put(cate));

    // Add the new category to the list in the required format
    _categories.add('$emoji $name');
    notifyListeners();
  }

  Future<void> readCate() async {
    List<Categori> cates = await isar.categoris.where().findAll();

    // Clear the list and add predefined categories
    _categories.clear();
    _categories.addAll([
      '🍕 Food',
      '☕ Drink',
      '💼 Work',
      '🎈 Entertainment',
      '🏡 Apartment',
      '🚌 Travel',
      '💎 Subscriptions',
      '👖 Cloths',
      '📚 Studying',
      '🛵 Motorcycle',
      '💇 Haircut',
      '🎁 Gifts',
      '💊 Health',
    ]);

    // Add categories from the database in the required format
    for (var cate in cates) {
      _categories.add('${cate.emoji} ${cate.name}');
    }
    notifyListeners();
  }

  Future<void> addExpense(Expense ex) async {
    await isar.writeTxn(() async {
      await isar.expenses
          .put(ex); // Ensure that 'expenses' collection exists in the schema
    });
    await readExpenses();
  }

  Future<void> readExpenses() async {
    final expenses = await isar.expenses.where().findAll(); // Read all expenses
    _expensesList.clear();
    _expensesList.addAll(expenses);
    notifyListeners();
  }

  Future<void> updateExpense(int id, Expense ex) async {
    // Ensure the ID is set correctly and the expense exists
    final existingExpense = await isar.expenses.get(id);
    if (existingExpense != null) {
      await isar.writeTxn(() async {
        // Update the existing expense with new data
        ex.id = id; // Ensure the ID is set correctly in the Expense object
        await isar.expenses.put(ex);
      });
    }
    await readExpenses(); // Refresh or re-read the expenses after update
  }

  Future<void> updateIncome(int id, Income inc) async {
    // Ensure the ID is set correctly and the expense exists
    final existingIncome = await isar.incomes.get(id);
    if (existingIncome != null) {
      await isar.writeTxn(() async {
        // Update the existing expense with new data
        inc.id = id; // Ensure the ID is set correctly in the Expense object
        await isar.incomes.put(inc);
      });
    }
    await readIncome(); // Refresh or re-read the expenses after update
  }

  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
    await readExpenses();
  }

  Future<void> deleteIncome(int id) async {
    await isar.writeTxn(() async {
      await isar.incomes.delete(id);
    });
    await readIncome();
  }

  Future<void> deleteAll() async {
    await isar.writeTxn(
      () => isar.expenses.clear(),
    );
    await readExpenses();
  }

  double totalExpense(List<Expense> expenseList) {
    double total = 0;
    for (Expense ex in expenseList) {
      total += ex.amount;
    }
    return total;
  }

  final List<Income> _incomeList = [];
  List<Income> get incomeList => _incomeList;

  Future<void> addIncome(Income income) async {
    await isar.writeTxn(() async {
      await isar.incomes.put(
          income); // Ensure that 'expenses' collection exists in the schema
    });
    await readIncome();
  }

  Future<void> readIncome() async {
    final incomes = await isar.incomes.where().findAll(); // Read all incomes
    _incomeList.clear();
    _incomeList.addAll(incomes);

    // Initialize with an income of 100 if the list is empty
    if (_incomeList.isEmpty) {
      final initialIncome = Income(
        name: 'Initial Income',
        amount: 100.0,
        date: DateTime.now(),
        des: 'Initial Income',
        emoji: '💰',
      );
      await addIncome(initialIncome);
    }

    notifyListeners();
  }

  double totalIncome(List<Income> incomeList) {
    double total = 0;
    for (Income income in incomeList) {
      total += income.amount;
    }
    return total;
  }

  List<Transaction> getCombinedList(
      List<Expense> expenses, List<Income> incomes) {
    List<Transaction> combinedList = [];
    combinedList
        .addAll(expenses.map((e) => Transaction(isExpense: true, data: e)));
    combinedList
        .addAll(incomes.map((i) => Transaction(isExpense: false, data: i)));
    return combinedList;
  }

  double calculateTotalExpense(List<Expense> expenses) {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  double calculateTotalIncome(List<Income> incomes) {
    return incomes.fold(0, (sum, item) => sum + item.amount);
  }
}

class Transaction {
  final bool isExpense;
  final dynamic data;

  Transaction({required this.isExpense, required this.data});
}
