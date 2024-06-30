import 'package:akkhara_tracker/components/widgets/expense%20widget/save_button.dart';
import 'package:akkhara_tracker/components/widgets/sub%20widget/sub_bill.dart';
import 'package:akkhara_tracker/components/widgets/sub%20widget/sub_detail.dart';
import 'package:akkhara_tracker/components/widgets/sub%20widget/subscription_tile.dart';
import 'package:akkhara_tracker/components/widgets/sub%20widget/subscriptions.dart';
import 'package:akkhara_tracker/components/widgets/sub%20widget/tiny_sub_tile.dart';
import 'package:akkhara_tracker/components/widgets/sub%20widget/trending_tile.dart';
import 'package:akkhara_tracker/models/subscription.dart';
import 'package:akkhara_tracker/models/subscription_database.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  // final List<Widget> trending = [
  //   for (int i = 0; i < 10; i++)
  //     TrendingTile(
  //       gap: 20,
  //       title: "Netflix",
  //       price: 6.99,
  //       image: 'assets/subscriptions/netflix.png',
  //       onPressed: () {},
  //     ),
  // ];
  // final List<Widget> subscription = [
  //   for (int i = 0; i < 10; i++)
  //     SubscriptionTile(
  //       title: "Netflix",
  //       price: 6.99,
  //       image: 'assets/subscriptions/netflix.png',
  //       onPressed: () {},
  //     ),
  // ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.7,
      // initialPage: subList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List subList = context.watch<SubscriptionDatabase>().subList;
    List<Widget> subs = [
      for (int i = 0; i < subList.length; i++)
        SubscriptionTile(
          sub: subList[i],
          onPressed: () {},
        ),
    ];
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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

                //bill to pay
                const Gap(40),
                const SubBill(),

                //tiny sub tile
                const Gap(10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: TinySubTile(
                          title: 'Active subs',
                          subTitle: '12',
                          color: Colors.orange,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: TinySubTile(
                          title: 'Highest subs',
                          subTitle: '\$19.99',
                          color: Colors.blue,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: TinySubTile(
                          title: 'Lowest subs',
                          subTitle: '\$5.99',
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                //List of subscription
                const Gap(35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Your Subscriptions",
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: subs.length * 2,
                    itemBuilder: (context, index) {
                      int actualIndex = index % subs.length;
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 0.8;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              height: Curves.easeOut.transform(value) * 220,
                              width: Curves.easeOut.transform(value) *
                                  MediaQuery.of(context).size.width *
                                  0.7,
                              child: child,
                            ),
                          );
                        },
                        child: subs[actualIndex],
                      );
                    },
                    onPageChanged: (index) {
                      if (index == subs.length * 2 - 1) {
                        _pageController.jumpToPage(subs.length);
                      }
                    },
                  ),
                ),

                //Trending
                const Gap(35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Trending Now",
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                            TrendingTile(
                              gap: 50,
                              trend: subList[0],
                              onPressed: () {},
                            ),
                            const Gap(15),
                            TrendingTile(
                              gap: 20,
                              trend: subList[6],
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: Column(
                          children: [
                            TrendingTile(
                              gap: 20,
                              trend: subList[7],
                              onPressed: () {},
                            ),
                            const Gap(15),
                            TrendingTile(
                              gap: 50,
                              trend: subList[3],
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //other sub
                const Gap(35),
                //subs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Subscriptions",
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: List.generate(
                      subList.length,
                      (index) {
                        Subscription sub = subList[index];
                        return Subscriptions(
                          sub: sub,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubDetail(sub: sub),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
