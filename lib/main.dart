import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/subscription_database.dart';
import 'package:akkhara_tracker/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExpenseDatabase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseDatabase(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubscriptionDatabase(),
        ),
      ],
      child: const MaterialApp(
        home: MainPage(),
      ),
    );
  }
}
