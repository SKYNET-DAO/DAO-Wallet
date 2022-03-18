import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final void Function(String keyword)? onSearch;
  final Widget Function()? childBuilder;
  final Widget Function(Widget child)? builder;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Color inputBackgroundColor;
  final Color backgroundColor;
  final EdgeInsets padding;
  final Widget? action;
  final bool showSearchBar;
  final String searchHintText;
  final TextStyle style;

  const SearchWidget(
      {Key? key,
      this.onSearch,
      this.childBuilder,
      this.builder,
      this.focusNode,
      this.controller,
      this.inputBackgroundColor = const Color(0xFFF5F7FA),
      this.backgroundColor = Colors.white,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      this.action,
      this.showSearchBar = true,
      this.style = const TextStyle(color: Color(0xFF171F26), fontSize: 13),
      this.searchHintText = "请输入您要找的内容"})
      : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Widget buildSearchWidget() {
    var icon = Padding(
      padding: EdgeInsets.only(left: 12, right: 6),
      child: Icon(
        Icons.search,
        size: 20,
        color: Color(0xFFBABBBF),
      ),
    );
    var searchBar = TextField(
      autocorrect: false,
      focusNode: searchNode,
      controller: searchController,
      decoration: InputDecoration(
          hintText: widget.searchHintText,
          hintStyle: TextStyle(color: Color(0xFFBABBBF), fontSize: 13),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          isDense: true),
      style: widget.style,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) {
        widget.onSearch?.call(searchController.text);
        dismissKeyboard();
      },
    );
    var searchBg = Container(
      decoration: BoxDecoration(
          color: widget.inputBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: <Widget>[
          icon,
          Expanded(
            child: searchBar,
          ),
        ],
      ),
    );
    return Container(
      color: widget.backgroundColor,
      child: Padding(
          padding: widget.padding,
          child: Row(
            children: <Widget>[
              Expanded(
                child: searchBg,
              ),
              widget.action ?? Container(),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.showSearchBar ? buildSearchWidget() : Container();
    return widget.builder?.call(child) ??
        Column(
          children: [
            child,
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => dismissKeyboard(),
                child: widget.childBuilder?.call() ?? Container(),
              ),
            )
          ],
        );
  }

  @override
  void initState() {
    super.initState();
    searchNode = widget.focusNode ?? FocusNode();
    searchController = widget.controller ?? TextEditingController();
  }

  late FocusNode searchNode;
  late TextEditingController searchController;
  void dismissKeyboard() {
    searchNode.unfocus();
  }
}
