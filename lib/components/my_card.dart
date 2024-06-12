import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyCard extends StatelessWidget {
  final List<Color> colors;
  final double totalBalance;
  const MyCard({super.key, required this.colors, required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${totalBalance.toStringAsFixed(2)}",
                style: GoogleFonts.lato(
                  fontSize: 34,
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.ellipsis_vertical,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
          Text(
            "Your total balance",
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: LinearPercentIndicator(
              addAutomaticKeepAlive: false,
              curve: Curves.bounceInOut,
              padding: EdgeInsets.zero,
              animation: true,
              animationDuration: 1000,
              barRadius: const Radius.circular(15),
              lineHeight: 5,
              percent: 0.5,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              linearGradient: const LinearGradient(
                colors: [
                  Color(0xffff6041),
                  Color(0xffffd941),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "****  ****  ****  ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  Text(
                    "8888",
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ],
              ),
              Image.asset(
                "assets/icons/master_icon.png",
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
