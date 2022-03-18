import 'package:flutter/material.dart';
import 'package:qmlkit/calendar/linear_widget.dart';

class DayLinear extends StatelessWidget {
  const DayLinear(
      {Key? key,
      this.startTime,
      this.dayCount = 7,
      required this.dayItemBuilder,
      this.weekStyle = const TextStyle(color: Color(0xff14171A), fontSize: 14),
      this.dayStyle = const TextStyle(color: Color(0xff171F26), fontSize: 14),
      this.showWeek = true,
      this.showDay = true,
      this.span = 8})
      : super(key: key);
  final DateTime? startTime;
  final int dayCount;
  final TextStyle weekStyle;
  final TextStyle dayStyle;
  final bool showWeek;
  final bool showDay;
  final double span;
  final DayLineItem? Function(DateTime dateTime) dayItemBuilder;
  Widget _buildItem(int index) {
    DateTime today = DateTime.now().toLocal();
    DateTime dateTime =
        (startTime ?? today).toLocal().add(Duration(days: index));
    DayLineItem? dayItem = dayItemBuilder.call(dateTime);
    if (dayItem == null) return Container();
    List<Widget> children = [];
    if (showWeek) {
      String week = "";
      switch (dateTime.weekday) {
        case DateTime.sunday:
          week = "日";
          break;
        case DateTime.monday:
          week = "一";
          break;
        case DateTime.tuesday:
          week = "二";
          break;
        case DateTime.wednesday:
          week = "三";
          break;
        case DateTime.thursday:
          week = "四";
          break;
        case DateTime.friday:
          week = "五";
          break;
        case DateTime.saturday:
          week = "六";
          break;
      }
      children.add(dayItem.weekWidget ??
          Text(
            week,
            style: dayItem.weekStyle ?? weekStyle,
          ));
    }
    if (showDay) {
      bool isToday = dateTime.year == today.year &&
          dateTime.month == today.month &&
          dateTime.day == today.day;
      children.add(dayItem.dayWidget ??
          Text(
            "${isToday ? '今天' : dateTime.day}",
            style: dayItem.dayStyle ?? dayStyle,
          ));
    }
    if (children.length == 2) {
      children.insert(
          1,
          Container(
            height: span,
          ));
    }
    children.add(dayItem.footer ?? Container());
    return GestureDetector(
      onTap: () => dayItem.onClick?.call(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: dayItem.width,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LinearWidget(
      itemCount: dayCount,
      itemBuilder: (index) => _buildItem(index),
    );
  }
}

class DayLineItem {
  final TextStyle? weekStyle;
  final TextStyle? dayStyle;
  final double? width;
  final Widget? footer;
  final Widget? dayWidget;
  final Widget? weekWidget;
  final Function()? onClick;
  DayLineItem(
      {this.weekStyle,
      this.dayStyle,
      this.width,
      this.footer,
      this.dayWidget,
      this.weekWidget,
      this.onClick});
}
