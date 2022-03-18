import 'package:flutter/material.dart';
import '../pub/extensions/extensions.dart';
import 'ref_status_widget.dart';

class SegmentWidget extends StatefulWidget {
  SegmentWidget({Key? key, this.tab, this.body, this.tabHeight = 50})
      : super(key: key);
  final List<Widget>? tab;
  final List<Widget>? body;
  final double tabHeight;

  @override
  _SegmentWidgetState createState() => _SegmentWidgetState();
}

class _SegmentWidgetState extends State<SegmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
