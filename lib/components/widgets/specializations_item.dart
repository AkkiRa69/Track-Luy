import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SpecializationsItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final String des;
  final String buttonText;
  const SpecializationsItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon,
      required this.des,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    const Color white = Colors.white;
    const Color green = Color(0xff2beb8b);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: white,
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: white,
                  fontSize: 25,
                ),
              ),
              Icon(
                icon,
                color: green,
                size: 18,
              )
            ],
          ),
          const Gap(10),
          Text(
            des,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const Gap(30),
          GestureDetector(
            onTap: onTap,
            child: Text(
              buttonText,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: white,
                color: white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
