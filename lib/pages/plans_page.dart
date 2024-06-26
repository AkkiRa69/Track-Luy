import 'package:akkhara_tracker/components/widgets/subscription_tile.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final PageController _pageController = PageController(viewportFraction: 0.7);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //app bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi! Bro👋",
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            "Find your perfect subscription!",
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.kindaBlack,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(30),

                //List of subscription
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subscriptions",
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: 205,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              height: Curves.easeOut.transform(value) * 205,
                              width: Curves.easeOut.transform(value) *
                                  MediaQuery.of(context).size.width *
                                  0.7,
                              child: child,
                            ),
                          );
                        },
                        child: SubscriptionTile(
                          gap: 20,
                          title: "Netflix",
                          price: 5.99,
                          image: 'assets/subscriptions/spotify.png',
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),

                const Gap(20),
                //Trending
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending Now",
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SubscriptionTile(
                              gap: 50,
                              title: "Netflix",
                              price: 6.99,
                              image: 'assets/subscriptions/netflix.png',
                              onPressed: () {},
                            ),
                            const Gap(15),
                            SubscriptionTile(
                              gap: 20,
                              title: "Youtube",
                              price: 9.99,
                              image: 'assets/subscriptions/youtube.png',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: Column(
                          children: [
                            SubscriptionTile(
                              gap: 20,
                              title: "Netflix",
                              price: 5.99,
                              image: 'assets/subscriptions/spotify.png',
                              onPressed: () {},
                            ),
                            const Gap(15),
                            SubscriptionTile(
                              gap: 50,
                              title: "Github",
                              price: 8.99,
                              image: 'assets/subscriptions/github.png',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
