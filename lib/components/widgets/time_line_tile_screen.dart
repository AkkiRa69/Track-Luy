import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TimelineItem(
            date: '2020 - Present',
            title: 'Framer Designer & Developer',
            company: 'Brunodee Agency',
            backgroundColor: Colors.grey[900]!,
          ),
          TimelineItem(
            date: '',
            title: 'Front-End WordPress Developer',
            company: 'Envato Market',
            backgroundColor: Colors.grey[900]!,
          ),
          TimelineItem(
            date: '2013 - 2019',
            title: 'Webflow Developer & Co-Founder',
            company: 'Designflow Studio',
            backgroundColor: Colors.grey[850]!,
          ),
          TimelineItem(
            date: '',
            title: 'Web Designer',
            company: 'Freelance',
            backgroundColor: Colors.grey[850]!,
          ),
          TimelineItem(
            date: '',
            title: 'Leader Team of Marketing',
            company: 'AHA Marketing Agency',
            backgroundColor: Colors.grey[850]!,
          ),
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String date;
  final String title;
  final String company;
  final Color backgroundColor;

  const TimelineItem({
    super.key,
    required this.date,
    required this.title,
    required this.company,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: date.isNotEmpty,
      beforeLineStyle: const LineStyle(color: Colors.grey, thickness: 2),
      afterLineStyle: const LineStyle(color: Colors.grey, thickness: 2),
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: date.isNotEmpty ? Colors.white : Colors.transparent,
      ),
      startChild: date.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          : null,
      endChild: Container(
        padding: const EdgeInsets.all(16.0),
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              company,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
