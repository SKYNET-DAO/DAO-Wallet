import 'package:flutter/material.dart';
import 'package:qmlkit/calendar/day_linear.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({
    Key? key,
    this.year,
    this.month,
    this.showWeekTitle = false,
    this.span = 16,
    this.beforeStyle,
    this.currentStyle = const TextStyle(color: Color(0xff14171A), fontSize: 14),
    this.afterStyle,
    this.footerBuilder,
    this.onDayClick,
    this.weekStyle = const TextStyle(color: Color(0xff14171A), fontSize: 14),
  }) : super(key: key);

  final int? year;
  final int? month;

  final TextStyle? beforeStyle;
  final TextStyle currentStyle;
  final TextStyle? afterStyle;
  final TextStyle weekStyle;
  final bool showWeekTitle;
  final double span;

  final Widget Function(DateTime dateTime)? footerBuilder;
  final Function(DateTime dateTime)? onDayClick;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int year = this.year ?? now.year;
    int month = this.month ?? now.month;
    DateTime firstDay = DateTime(year, month, 1);
    DateTime startTime = firstDay;
    if (firstDay.weekday != DateTime.sunday) {
      startTime = firstDay.add(Duration(days: 0 - firstDay.weekday));
    }
    List<Widget> children = [];
    if (showWeekTitle) {
      children.add(DayLinear(
        dayCount: 7,
        startTime: startTime,
        showDay: false,
        showWeek: true,
        dayItemBuilder: (dateTime) => DayLineItem(weekStyle: weekStyle),
      ));
      children.add(Container(height: span));
    }
    for (int i = 0; i < 6; i++) {
      DateTime firstTime = startTime.add(Duration(days: 7 * i));
      if (firstTime.month != month && i != 0) continue;
      children.add(DayLinear(
        dayCount: 7,
        startTime: firstTime,
        showDay: true,
        showWeek: false,
        dayItemBuilder: (dateTime) {
          if (dateTime.month != month) {
            if (dateTime.isAfter(firstDay)) {
              if (afterStyle != null) {
                return DayLineItem(
                    dayStyle: afterStyle,
                    onClick: () => onDayClick?.call(dateTime),
                    footer: footerBuilder?.call(dateTime) ?? Container());
              }
            } else {
              if (beforeStyle != null) {
                return DayLineItem(
                    dayStyle: beforeStyle,
                    onClick: () => onDayClick?.call(dateTime),
                    footer: footerBuilder?.call(dateTime) ?? Container());
              }
            }
            return null;
          }
          return DayLineItem(
              dayStyle: currentStyle,
              onClick: () => onDayClick?.call(dateTime),
              footer: footerBuilder?.call(dateTime) ?? Container());
        },
      ));
      children.add(Container(height: span));
    }
    children.removeLast();
    return Container(
      child: Column(
        children: children,
      ),
    );
  }
}
