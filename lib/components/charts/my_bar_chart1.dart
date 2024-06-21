import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyBarChart1 extends StatefulWidget {
  MyBarChart1({super.key});

  final Color barBackgroundColor =
      AppColors.contentColorWhite.darken().withOpacity(0.3);
  final Color barColor = AppColors.contentColorWhite;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<MyBarChart1> {
  bool showWeekData = true;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List expenses = context.read<ExpenseDatabase>().expenseList;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xff131313),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInBack,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: index == 0
                          ? AppColors.kindaBlack
                          : Colors.transparent),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      setState(() {
                        index = 0;
                        showWeekData = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Week',
                        style: GoogleFonts.spaceGrotesk(
                          color: index == 0 ? Colors.white : AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 10),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: index == 1
                          ? AppColors.kindaBlack
                          : Colors.transparent),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      setState(() {
                        index = 1;
                        showWeekData = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Month',
                        style: GoogleFonts.spaceGrotesk(
                          color: index == 1 ? Colors.white : AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: BarChart(
                showWeekData
                    ? generateBarChartData(expenses, true)
                    : generateBarChartData(expenses, false),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y, bool isWeek) {
    double limit = isWeek ? 500.0 : 1500.0;
    double cappedY = y > limit ? limit : y;
    Color barColor = y > limit ? Colors.red : widget.barColor;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: cappedY,
          color: barColor,
          borderRadius: BorderRadius.circular(10),
          width: 18,
          borderSide: BorderSide(color: barColor, width: 2.0),
          rodStackItems: [
            BarChartRodStackItem(0, cappedY, barColor),
          ],
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: y,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta, bool isWeek) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    List<String> months = [
      'J',
      'F',
      'M',
      'A',
      'M',
      'J',
      'J',
      'A',
      'S',
      'O',
      'N',
      'D'
    ];

    Widget text = Text(
      isWeek ? days[value.toInt()] : months[value.toInt()],
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text = Text(
      value.toInt().toString(),
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  BarChartData generateBarChartData(List expenses, bool isWeek) {
    Map<int, double> expenseSums = {};

    if (isWeek) {
      // Initialize a map with default values of 0.0 for each day of the week
      expenseSums = {
        0: 0.0,
        1: 0.0,
        2: 0.0,
        3: 0.0,
        4: 0.0,
        5: 0.0,
        6: 0.0,
      };

      // Calculate the total expenses for each day of the week
      for (var expense in expenses) {
        DateTime date = expense.date;
        double amount = expense.amount;
        int dayOfWeek =
            date.weekday - 1; // DateTime.weekday is 1 (Monday) to 7 (Sunday)
        expenseSums[dayOfWeek] = expenseSums[dayOfWeek]! + amount;
      }
    } else {
      // Initialize a map with default values of 0.0 for each month of the year
      expenseSums = {
        0: 0.0,
        1: 0.0,
        2: 0.0,
        3: 0.0,
        4: 0.0,
        5: 0.0,
        6: 0.0,
        7: 0.0,
        8: 0.0,
        9: 0.0,
        10: 0.0,
        11: 0.0,
      };

      // Calculate the total expenses for each month
      for (var expense in expenses) {
        DateTime date = expense.date;
        double amount = expense.amount;
        int month =
            date.month - 1; // DateTime.month is 1 (January) to 12 (December)
        expenseSums[month] = expenseSums[month]! + amount;
      }
    }

    // Determine the maximum value for the y-axis based on the selected view
    double maxY = isWeek ? 500.0 : 1500.0;

    return BarChartData(
      maxY: maxY,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              "-\$${rod.backDrawRodData.toY.toString()}",
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            );
          },
        ),
        enabled: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) =>
                getBottomTitles(value, meta, isWeek),
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getLeftTitles,
            reservedSize: 40,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(
        isWeek ? 7 : 12,
        (i) => makeGroupData(
          i,
          expenseSums[i] ?? 0.0,
          isWeek,
        ),
      ),
      gridData: const FlGridData(show: false),
    );
  }
}
