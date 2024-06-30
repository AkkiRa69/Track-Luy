import 'package:akkhara_tracker/models/subscription.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SubDetail extends StatelessWidget {
  final Subscription sub;

  const SubDetail({Key? key, required this.sub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.backGround,
      body: Column(
        children: [
          Image.asset(
            sub.image,
            height: 100,
          ),
        ],
      ),
    );
  }
}
