import 'package:flutter/material.dart';
import 'package:qmlkit/button/base_button.dart';
import 'package:qmlkit/calendar/linear_widget.dart';
import '../pub/extensions/extensions.dart';

class Segment extends StatefulWidget {
  Segment({
    Key? key,
    this.height = 50,
    this.index = 0,
    this.onIndexChanged,
    required this.items,
    this.selectedItems,
  }) : super(key: key);
  final double height;
  final int index;
  final void Function(int index)? onIndexChanged;
  final List<SegmentItem> items;
  final List<SegmentItem>? selectedItems;
  @override
  _SegmentState createState() => _SegmentState();
}

class _SegmentState extends State<Segment> {
  Widget buildItem(int index) {
    SegmentItem item = widget.items[index];
    SegmentItem? selectItem;
    if (index < (widget.selectedItems ?? []).length) {
      selectItem = widget.selectedItems?[index];
    }
    selectItem ??= item;
    return BaseButton(
      height: widget.height,
      controller: controllers[index],
      shouldChangeSelect: (selected) => !selected,
      onClick: () {
        for (int i = 0; i < controllers.length; i++) {
          if (i != index) {
            controllers[i].selected = false;
            controllers[i].commit();
          }
        }
        widget.onIndexChanged?.call(index);
      },
      descBuilder: (state) {
        if (state == ButtonState.normal)
          return ButtonDesc(
            child: item.title.toText(
                style: item.style ??
                    TextStyle(
                      color: Color(0xff6D7278),
                      fontSize: 10,
                    )),
            decoration: item.decoration ?? BoxDecoration(color: Colors.transparent),
            left: item.left,
            top: item.top,
            right: item.right,
            bottom: item.bottom,
          );
        if (state == ButtonState.selected)
          return ButtonDesc(
            child: selectItem?.title.toText(
                style: selectItem.style ??
                    TextStyle(
                      color: Color(0xff141F33),
                      fontSize: 10,
                    )),
            decoration:
                selectItem?.decoration ?? BoxDecoration(color: Colors.transparent),
            left: selectItem?.left,
            top: selectItem?.top,
            right: selectItem?.right,
            bottom: selectItem?.bottom,
          );
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = widget.items.length;
    if (itemCount < 1) return Container();
    return LinearWidget(
      itemCount: itemCount,
      itemBuilder: (index) => buildItem(index),
    );
  }

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.items.length, (index) => ButtonController());
    if (widget.index < controllers.length)
      controllers[widget.index].selected = true;
  }

  List<ButtonController> controllers = [];
}

class SegmentItem {
  final String title;
  final TextStyle? style;
  final Decoration? decoration;
  final Widget? left;
  final Widget? top;
  final Widget? right;
  final Widget? bottom;

  SegmentItem({
    required this.title,
    this.style,
    this.decoration,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });
}

extension SegmentExOnStringList on List<String> {
  Segment toSegment({
    int index = 0,
    double height = 50,
    Decoration? normalDecoration,
    Decoration? selectedDecoration,
    TextStyle? normalStyle,
    TextStyle? selectedStyle,
    Color? normalColor,
    Color? selectColor,
    double? iconSize,
    IconData? left,
    IconData? top,
    IconData? right,
    IconData? bottom,
    EdgeInsets iconMargin = EdgeInsets.zero,
    void Function(int index)? onIndexChanged,
  }) =>
      Segment(
        index: index,
        height: height,
        onIndexChanged: onIndexChanged,
        selectedItems: this
            .map(
              (e) => SegmentItem(
                title: e,
                decoration: selectedDecoration,
                style: selectedStyle,
                left: left == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: selectColor ?? selectedStyle?.color,
                      ).applyPadding(iconMargin),
                top: top == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: selectColor ?? selectedStyle?.color,
                      ).applyPadding(iconMargin),
                right: right == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: selectColor ?? selectedStyle?.color,
                      ).applyPadding(iconMargin),
                bottom: bottom == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: selectColor ?? selectedStyle?.color,
                      ).applyPadding(iconMargin),
              ),
            )
            .toList(),
        items: this
            .map(
              (e) => SegmentItem(
                title: e,
                decoration: normalDecoration,
                style: normalStyle,
                left: left == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: normalColor ?? normalStyle?.color,
                      ),
                top: top == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: normalColor ?? normalStyle?.color,
                      ),
                right: right == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: normalColor ?? normalStyle?.color,
                      ),
                bottom: bottom == null
                    ? null
                    : Icon(
                        left,
                        size: iconSize,
                        color: normalColor ?? normalStyle?.color,
                      ),
              ),
            )
            .toList(),
      );
}
