import 'package:akkhara_tracker/components/widgets/advantage_item.dart';
import 'package:akkhara_tracker/components/widgets/my_elevated_button.dart';
import 'package:akkhara_tracker/components/widgets/rotate_button/circular_text.dart';
import 'package:akkhara_tracker/components/widgets/specializations_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/widgets/time_line_item.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'sanmonyakkhara007@gmail.com',
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not send email to sanmonyakkhara007@gmail.com');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color white = Colors.white;
    const Color green = Color(0xff2beb8b);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///////////////////////////
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Akkhara",
                              style: GoogleFonts.aBeeZee(
                                color: white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(5),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: white,
                                ),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'A',
                                style: GoogleFonts.aBeeZee(
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Software",
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Developer",
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset(
                        'assets/images/me.png',
                        height: 250,
                      ),
                    ),
                  ),
                  Text(
                    'San Moneyakkhara',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                  Text(
                    'Based in Phnum Penh, CAM',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      '© 2024 Akkhara, All Rights Reserved',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(15),
                        style: IconButton.styleFrom(
                          side: BorderSide(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onPressed: () => _launchUrl(
                            'https://web.facebook.com/ah.xiang.33865'),
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                      const Gap(10),
                      IconButton(
                        padding: const EdgeInsets.all(15),
                        style: IconButton.styleFrom(
                          side: BorderSide(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onPressed: () => _launchUrl('https://t.me/monyakkhara'),
                        icon: Icon(
                          FontAwesomeIcons.telegram,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                      const Gap(10),
                      IconButton(
                        padding: const EdgeInsets.all(15),
                        style: IconButton.styleFrom(
                          side: BorderSide(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onPressed: () =>
                            _launchUrl('https://github.com/AkkiRa69'),
                        icon: Icon(
                          FontAwesomeIcons.github,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Gap(10),
                      IconButton(
                        padding: const EdgeInsets.all(15),
                        style: IconButton.styleFrom(
                          side: BorderSide(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onPressed: () => _sendEmail(),
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrl('https://t.me/monyakkhara');
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 35),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.telegram,
                          ),
                          Gap(10),
                          Text(
                            'CONTACT ME!',
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///////////////////////
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyElevatedButton(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: white,
                            size: 22,
                          ),
                          Gap(10),
                          Text(
                            'INTRODUCE',
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const Gap(40),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Say Hi from ',
                          style: TextStyle(
                            fontSize: 58,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Akkhara',
                          style: TextStyle(
                            fontSize: 58,
                            color: green, // Change this to your desired color
                          ),
                        ),
                        TextSpan(
                          text: ', Software Developer',
                          style: TextStyle(
                            fontSize: 58,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Text(
                      'I design and code beautifully simple things and i love what i do. Just simple like that!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 45,
                    ),
                    height: 180,
                    child: const CircularTextWidget(),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1+",
                              style: TextStyle(
                                fontSize: 58,
                                color: green,
                              ),
                            ),
                            Gap(20),
                            Text(
                              "YEARS OF EXPERINCE",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(30),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "10+",
                              style: TextStyle(
                                fontSize: 58,
                                color: green,
                              ),
                            ),
                            Gap(20),
                            Text(
                              "PROJECTS COMPLETED ON GITHUB",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyElevatedButton(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_4_outlined,
                              color: white,
                              size: 22,
                            ),
                            Gap(10),
                            Text(
                              'ABOUT',
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'The best',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' error ',
                          style: TextStyle(
                            fontSize: 50,
                            color: green, // Change this to your desired color
                          ),
                        ),
                        TextSpan(
                          text: 'message is the one that',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' never ',
                          style: TextStyle(
                            fontSize: 50,
                            color: green,
                          ),
                        ),
                        TextSpan(
                          text: 'shows up.',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' Thomas Fuchs',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'The software development journey begins with learning programming fundamentals and building simple projects. As developers gain experience, they tackle more complex problems, collaborate with others, and adopt best practices. Continuous learning and adaptation to new technologies are crucial, as is developing both technical and soft skills. Along the way, developers contribute to projects, solve intricate challenges, and grow professionally, finding satisfaction in turning ideas into impactful software solutions.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 35),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyElevatedButton(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.note_alt_outlined,
                              color: white,
                              size: 22,
                            ),
                            Gap(10),
                            Text(
                              'RESUME',
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Education & ',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Experience',
                          style: TextStyle(
                            fontSize: 50,
                            color: green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),

            ///////////////////////////
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TimelineItem(
                    date: '2022 - Present',
                    items: [
                      MajorItem(
                          'Computer Science', 'Royal University Of Phnom Penh'),
                      MajorItem('Internship', 'ANT Technology Training Center'),
                      MajorItem('Software Developer', 'Jes Tah Dak'),
                    ],
                    containerHeight: 370,
                  ),
                  TimelineItem(
                    date: 'March 2023 - December 2023',
                    items: [
                      MajorItem(
                          'Short Course', 'ANT Technology Training Center'),
                    ],
                    containerHeight: 100,
                  ),
                ],
              ),
            ),
            ///////////////////////
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 35),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyElevatedButton(
                        focus: true,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.library_books_outlined,
                              color: white,
                              size: 22,
                            ),
                            Gap(10),
                            Text(
                              'SERVICE',
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          print("hello");
                        },
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'My ',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Specializations',
                          style: TextStyle(
                            fontSize: 40,
                            color: green, // Change this to your desired color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                  SpecializationsItem(
                    onTap: () {
                      _launchUrl(
                          'https://github.com/AkkiRa69?tab=repositories');
                    },
                    title: 'Mobile App',
                    icon: FontAwesomeIcons.code,
                    buttonText: '10 PROJECTS',
                    des:
                        'I’ve developed a Mobile app with a stunning UI design and top-notch user experience, all powered by a live database, just for you!',
                  ),
                  const Gap(25),
                  SpecializationsItem(
                    onTap: () {
                      _launchUrl('http://training.antkh.com/students/?s=4937');
                    },
                    title: 'ANT Assignment',
                    icon: FontAwesomeIcons.codeBranch,
                    buttonText: '2 PROJECTS',
                    des:
                        'I excelled in studying C/C++ programming, C++/OOP, and C# at ANT Technology Training Center, finishing with outstanding results.',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 35),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyElevatedButton(
                        focus: true,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.code,
                              color: white,
                              size: 20,
                            ),
                            Gap(15),
                            Text(
                              'MY SKILLS',
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          print("hello");
                        },
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'My ',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Advantages',
                          style: TextStyle(
                            fontSize: 40,
                            color: green, // Change this to your desired color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AdvantageItem(
                            widget: Image.asset(
                              'assets/icons/flutter_logo.png',
                              height: 100,
                            ),
                            percent: "40%",
                            title: "Flutter"),
                      ),
                      const Gap(25),
                      Expanded(
                        child: AdvantageItem(
                            widget: Image.asset(
                              'assets/icons/Laravel_logo.png',
                              height: 100,
                            ),
                            percent: "0%",
                            title: "Laravel/PHP"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Gap(50),
          ],
        ),
      ),
    );
  }

  Widget _buildMajorItem(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        const Gap(5),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
