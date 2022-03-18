import 'package:flutter/material.dart';

import '../pub/extensions/extensions.dart';

class LinearWidget extends StatelessWidget {
  const LinearWidget(
      {Key? key,
      this.itemCount = 7,
      required this.itemBuilder,
      this.separatorBuilder})
      : super(key: key);
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final Widget Function(int index)? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    if(itemCount == 0)return Container();
    int count = itemCount * 2 - 1;
    return List.generate(
            count,
            (index) => index % 2 == 0
                ? Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: itemBuilder.call(index ~/ 2),
                    ),
                  )
                : (separatorBuilder?.call(index ~/ 2) ?? Container()))
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}
