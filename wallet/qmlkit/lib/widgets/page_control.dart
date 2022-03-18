import 'package:flutter/material.dart';
import 'package:qmlkit/qmlkit.dart';

class PageController extends ValueNotifier<int> {
  PageController(int value) : super(value);
}

class PageControl extends StatefulWidget {
  final Color tintColor;
  final Color currentTintColor;
  final double span;
  final double indicatorSize;
  final int currentPage;
  final int numOfPages;
  final PageController? controller;

  const PageControl(
      {Key? key,
      this.tintColor = Colors.grey,
      this.currentTintColor = Colors.white,
      this.span = 8,
      this.indicatorSize = 8,
      this.currentPage = 0,
      required this.numOfPages,
      this.controller})
      : super(key: key);
  @override
  _PageControlState createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  @override
  Widget build(BuildContext context) {
    if (widget.numOfPages > 0) {
      return List.generate(
        widget.numOfPages,
        (index) => [
          (current == index ? widget.currentTintColor : widget.tintColor)
              .toContainer(
                  width: widget.indicatorSize, height: widget.indicatorSize)
              .applyRadius(100),
          (index != widget.numOfPages - 1).toWidget(() => widget.span.inRow),
        ].toRow(mainAxisSize: MainAxisSize.min),
      ).toRow(mainAxisSize: MainAxisSize.min);
    }
    return Container();
  }

  late int current;
  @override
  void initState() {
    current = widget.controller?.value ?? widget.currentPage;
    widget.controller?.addListener(valueChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(valueChanged);
    super.dispose();
  }

  void valueChanged() {
    current = widget.controller!.value;
    setState(() {});
  }
}
