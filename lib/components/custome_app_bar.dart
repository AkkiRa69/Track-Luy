import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/menu.png",
                height: 30,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good morning,",
                  style: GoogleFonts.lato(),
                ),
                Text(
                  "Mr.Akkhara",
                  style: GoogleFonts.concertOne(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/notification.png",
                height: 30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/me.png"),
            ),
          ],
        ),
      ],
    );
  }
}
