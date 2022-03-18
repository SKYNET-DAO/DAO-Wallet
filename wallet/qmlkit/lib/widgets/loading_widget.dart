import 'package:flutter/material.dart';
import '../pub/extensions/extensions.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget(
      {Key? key, required this.child, this.indicator, required this.loadFunc})
      : super(key: key);
  final Widget child;
  final Widget? indicator;
  final Future<void> Function() loadFunc;
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return [
      widget.child.toAlign(),
      loading.toWidget(
        () => (widget.indicator ??
                CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ).applyBackground(height: 20, width: 20))
            .applyBackground(
                color: Color(0x44000000), alignment: Alignment.center)
            .toPositionedFill(),
      ),
    ].toStack(fit: StackFit.loose).onClick(() {
      if (!loading) {
        loading = true;
        refWidget();
        widget.loadFunc.call().whenComplete(() {
          loading = false;
          refWidget();
        });
      }
    }).applyUnconstrainedBox();
  }

  bool loading = false;
  void refWidget() => setState(() {});
}
