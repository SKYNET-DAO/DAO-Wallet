import 'package:flutter/material.dart';
import 'qml_card.dart';
import 'package:qmlkit/pub/extensions/extensions.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {Key? key,
      this.titleText,
      this.flagStyle,
      this.valueStyle,
      this.descStyle,
      required this.items,
      this.separatorBuilder,
      this.onItemClick,
      this.itemPadding = const EdgeInsets.all(16),
      this.itemBackgroudColor = Colors.white,
      this.valueAlign = TextAlign.right,
      this.span = 0})
      : super(key: key);
  final Widget? titleText;
  final TextStyle? flagStyle;
  final TextStyle? valueStyle;
  final TextStyle? descStyle;
  final List<InfoCardItem> items;
  final Widget Function(int index)? separatorBuilder;
  final EdgeInsets itemPadding;
  final void Function(InfoCardItem)? onItemClick;
  final Color itemBackgroudColor;
  final TextAlign valueAlign;
  final double span;

  @override
  Widget build(BuildContext context) {
    if (this.items.length > 0) {
      return QMLCard(
        titleBuilder: this.titleText == null ? null : () => this.titleText!,
        separatorBuilder: this.separatorBuilder,
        itemCount: this.items.length,
        itemBuilder: (index) => Container(
          padding: this.itemPadding,
          color: this.itemBackgroudColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              [
                Text(
                  this.items[index].flag,
                  style: this.items[index].flagStyle ?? this.flagStyle,
                ),
                (this.items[index].desc?.isNotEmpty ?? false)
                    .toWidget(() => Text(
                          this.items[index].desc!,
                          style: this.items[index].descStyle ?? this.descStyle,
                        )),
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              Container(
                width: span,
              ),
              (this.items[index].value != null).toWidget(
                () => Expanded(
                  child: Text(this.items[index].value!,
                      textAlign: valueAlign,
                      style: this.items[index].valueStyle ?? this.valueStyle),
                ),
              ),
              this.items[index].right ?? Container(),
            ],
          ),
        ).onClick(() {
          if (this.items[index].onClick != null) {
            this.items[index].onClick?.call();
            return;
          }
          onItemClick?.call(this.items[index]);
        }),
      );
    }
    return Container();
  }
}

class InfoCardItem {
  final String flag;
  final TextStyle? flagStyle;
  final String? value;
  final TextStyle? valueStyle;
  final String? desc;
  final TextStyle? descStyle;
  final Widget? right;
  final void Function()? onClick;

  InfoCardItem({
    required this.flag,
    this.flagStyle,
    this.value,
    this.valueStyle,
    this.desc,
    this.descStyle,
    this.right,
    this.onClick,
  });
}
