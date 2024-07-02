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
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;

  void subDetailPress(Subscription sub) {
    Get.to(
      SubDetail(
        sub: sub,
        onSwipe: () async {
          await context.read<SubscriptionDatabase>().addSub(sub);
          Get.snackbar('Message', "Paid Successfully!");
          Navigator.pop(context);
        },
      ),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionDatabase>().readSub();
    _pageController = PageController(
      viewportFraction: 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final subDb = context.read<SubscriptionDatabase>();
    List subList = context.watch<SubscriptionDatabase>().subList;
    List<Subscription> subscriptions = subDb.subscriptions;
    double totalAmount = subDb.totalAmount();
    double highestSub = subDb.highestSub();
    double lowestSub = subDb.lowestSub();
    print(subscriptions[0].startDate);

    List<Widget> subs = [
      for (int i = 0; i < subscriptions.length; i++)
        SubscriptionTile(
          sub: subscriptions[i],
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
                // App bar
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

                // Bill to pay
                const Gap(40),
                SubBill(
                  totalAmount: totalAmount,
                ),

                // Tiny sub tile
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: TinySubTile(
                          title: 'Active subs',
                          subTitle: '${subscriptions.length}',
                          color: Colors.orange,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: TinySubTile(
                          title: 'Highest subs',
                          subTitle: '\$${highestSub.toStringAsFixed(2)}',
                          color: Colors.blue,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: TinySubTile(
                          title: 'Lowest subs',
                          subTitle: '\$${lowestSub.toStringAsFixed(2)}',
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                // List of subscriptions
                subscriptions.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              itemCount: subs.length,
                              itemBuilder: (context, index) {
                                int actualIndex = index % subs.length;
                                return AnimatedBuilder(
                                  animation: _pageController,
                                  builder: (context, child) {
                                    double value = 0.8;
                                    if (_pageController
                                        .position.haveDimensions) {
                                      value = _pageController.page! - index;
                                      value = (1 - (value.abs() * 0.3))
                                          .clamp(0.0, 1.0);
                                    }
                                    return Center(
                                      child: SizedBox(
                                        height:
                                            Curves.easeOut.transform(value) *
                                                220,
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
                        ],
                      )
                    : const SizedBox(),

                // Trending
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
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(-10 / 360),
                              child: TrendingTile(
                                gap: 50,
                                trend: subList[0],
                                onPressed: () {
                                  subDetailPress(subList[0]);
                                },
                              ),
                            ),
                            const Gap(15),
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(-20 / 360),
                              child: TrendingTile(
                                gap: 20,
                                trend: subList[6],
                                onPressed: () {
                                  subDetailPress(subList[6]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: Column(
                          children: [
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(20 / 360),
                              child: TrendingTile(
                                gap: 20,
                                trend: subList[7],
                                onPressed: () {
                                  subDetailPress(subList[7]);
                                },
                              ),
                            ),
                            const Gap(15),
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(10 / 360),
                              child: TrendingTile(
                                gap: 50,
                                trend: subList[3],
                                onPressed: () {
                                  subDetailPress(subList[3]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Other subscriptions
                const Gap(35),
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
                        return index % 2 == 0
                            ? RotationTransition(
                                turns: const AlwaysStoppedAnimation(-3 / 360),
                                child: Subscriptions(
                                  sub: sub,
                                  onPressed: () {
                                    subDetailPress(sub);
                                  },
                                ),
                              )
                            : RotationTransition(
                                turns: const AlwaysStoppedAnimation(3 / 360),
                                child: Subscriptions(
                                  isFlip: true,
                                  sub: sub,
                                  onPressed: () {
                                    subDetailPress(sub);
                                  },
                                ),
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
  bool get wantKeepAlive => true;
}
