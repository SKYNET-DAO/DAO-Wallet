import 'package:flutter/material.dart';

class QMLCard extends StatelessWidget {
  const QMLCard(
      {Key? key,
      this.titleBuilder,
      required this.itemBuilder,
      this.separatorBuilder,
      required this.itemCount})
      : super(key: key);

  final Widget Function()? titleBuilder;
  final Widget Function(int index) itemBuilder;
  final Widget Function(int index)? separatorBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (this.titleBuilder != null) {
      children.add(this.titleBuilder!.call());
    }
    if (itemCount > 0) {
      for (int i = 0; i < itemCount; i++) {
        children.add(this.itemBuilder.call(i));
        if (i < itemCount - 1 && this.separatorBuilder != null) {
          children.add(Row(
            children: [
              Expanded(
                child: this.separatorBuilder?.call(i) ?? Container(),
              )
            ],
          ));
        }
      }
    }
    return Column(
      children: children,
    );
  }
}
