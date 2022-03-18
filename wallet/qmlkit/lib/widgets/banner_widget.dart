import 'dart:async';

import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  BannerWidget({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollDirection,
    this.onChanged,
  }) : super(key: key);
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(int index)? onChanged;
  final int itemCount;
  final Axis? scrollDirection;

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.itemCount > 0
        ? PageView.builder(
            scrollDirection: widget.scrollDirection ?? Axis.horizontal,
            controller: controller,
            itemBuilder: (BuildContext context, int index) => Listener(
              child: widget.itemBuilder.call(context, index % widget.itemCount),
              onPointerDown: (_) => listener?.cancel(),
              onPointerMove: (_) => listener?.cancel(),
              onPointerUp: (_) => autoScrollToNext(),
            ),
          )
        : Container();
  }

  @override
  void initState() {
    super.initState();
    int itemCount = widget.itemCount;
    if (itemCount > 0) {
      int index = totalCount ~/ 2;
      index = (index ~/ itemCount) * itemCount;
      controller = PageController(initialPage: index);
      autoScrollToNext();
    }
  }

  late PageController controller;
  int totalCount = 10000;
  StreamSubscription<void>? listener;

  @override
  void dispose() {
    controller.dispose();
    listener?.cancel();
    super.dispose();
  }

  void autoScrollToNext() {
    Future future = Future.delayed(Duration(seconds: 2));
    listener = future.asStream().listen((_) => scrollToNextPage());
  }

  void scrollToNextPage() {
    int index = controller.page?.toInt() ?? 0;
    index += 1;
    if (index >= totalCount) {
      int itemCount = widget.itemCount;
      int idx = index % itemCount;
      index = totalCount ~/ 2;
      index = (index ~/ itemCount) * itemCount + idx;
      controller.jumpToPage(index);
    } else {
      controller.animateToPage(index,
          duration: Duration(milliseconds: 250), curve: Curves.linear);
    }
    widget.onChanged?.call(index % widget.itemCount);
    autoScrollToNext();
  }
}
