import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MajorItem {
  final String title;
  final String subtitle;

  MajorItem(this.title, this.subtitle);
}

class TimelineItem extends StatefulWidget {
  final String date;
  final List<MajorItem> items;
  final double containerHeight;

  const TimelineItem({
    super.key,
    required this.date,
    required this.items,
    required this.containerHeight,
  });

  @override
  _TimelineItemState createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    const Color green = Color(0xff2beb8b);

    return VisibilityDetector(
      key: Key(widget.date),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          setState(() {
            _isVisible = true;
          });
        } else {
          setState(() {
            _isVisible = false;
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isVisible ? green : Colors.grey.shade600,
                ),
              ),
              Container(
                width: 1,
                height: widget.containerHeight,
                color: Colors.grey.shade600,
              ),
            ],
          ),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.date,
                style: TextStyle(
                  fontSize: 18,
                  color: _isVisible ? green : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              for (var item in widget.items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _buildMajorItem(item.title, item.subtitle),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMajorItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
