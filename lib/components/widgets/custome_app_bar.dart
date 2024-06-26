import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeAppBar extends StatelessWidget {
  final void Function()? onPressed;
  const CustomeAppBar({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.kindaBlack,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: Image.asset(
                  "assets/icons/menu.png",
                  height: 28,
                  color: Colors.white,
                ),
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
                  style: GoogleFonts.lato(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Mr.Akkhara",
                  style: GoogleFonts.concertOne(
                    fontSize: 18,
                    color: Colors.white,
                  ),
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
                color: Colors.white,
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
