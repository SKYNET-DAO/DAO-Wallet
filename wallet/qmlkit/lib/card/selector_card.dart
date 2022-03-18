import 'package:flutter/material.dart';

import 'qml_card.dart';

class SelectorCard extends StatefulWidget {
  const SelectorCard(
      {Key? key,
      this.titleText,
      this.normalWidget,
      this.selectedWidget,
      this.style,
      this.span,
      required this.items,
      this.separatorBuilder,
      this.itemPadding = const EdgeInsets.all(16),
      this.itemBackgroudColor = Colors.white,
      this.index = 0,
      this.onChanged})
      : super(key: key);
  final Widget? titleText;
  final Widget? normalWidget;
  final Widget? selectedWidget;
  final TextStyle? style;
  final double? span;
  final List<SelectorItem> items;
  final Widget Function(int index)? separatorBuilder;
  final EdgeInsets itemPadding;
  final Color itemBackgroudColor;
  final int index;
  final Function(int index)? onChanged;

  @override
  _SelectorCardState createState() => _SelectorCardState();
}

class _SelectorCardState extends State<SelectorCard> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.items.length > 0) {
      return QMLCard(
        titleBuilder:
            this.widget.titleText == null ? null : () => this.widget.titleText!,
        separatorBuilder: this.widget.separatorBuilder,
        itemCount: this.widget.items.length,
        itemBuilder: (idx) => GestureDetector(
          onTap: () {
            index = idx;
            widget.onChanged?.call(index);
            setState(() {});
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: this.widget.itemPadding,
            color: this.widget.itemBackgroudColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                this.widget.items[idx].icon ?? Container(),
                Container(
                  width: this.widget.items[idx].span ?? this.widget.span ?? 0,
                ),
                Expanded(
                  child: Text(
                    this.widget.items[idx].title,
                    style: this.widget.items[idx].style ?? this.widget.style,
                  ),
                ),
                (index == idx ? widget.selectedWidget : widget.normalWidget) ??
                    Container(),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }

  late int index;
  @override
  void initState() {
    index = widget.index;
    super.initState();
  }
}

class SelectorItem {
  final Widget? icon;
  final String title;
  final TextStyle? style;
  final double? span;

  SelectorItem({this.span, this.icon, required this.title, this.style});
}
