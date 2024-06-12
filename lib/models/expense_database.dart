import 'dart:io';

import 'package:akkhara_tracker/models/income.dart';
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
        IncomeSchema
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

  List get categories => _categories;

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
    ex.id = id; // Ensure the ID is set correctly
    await isar.writeTxn(() async {
      await isar.expenses.put(ex);
    });
    await readExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
    await readExpenses();
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
    final incomes = await isar.incomes.where().findAll(); // Read all expenses
    _incomeList.clear();
    _incomeList.addAll(incomes);
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
