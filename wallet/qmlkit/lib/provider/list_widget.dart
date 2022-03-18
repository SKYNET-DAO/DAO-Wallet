import 'package:flutter/material.dart';
import 'package:qmlkit/bean/net_resp.dart';
import 'package:qmlkit/provider/page_widget.dart';
import 'package:qmlkit/widgets/ref_status_widget.dart';

class ListWidget<T> extends StatefulWidget {
  const ListWidget({
    Key? key,
    required this.loadFunc,
    required this.itemBuilder,
    this.separatorBuilder,
    this.autoLoad = true,
    this.didGetProvider,
    this.contentPadding,
  }) : super(key: key);
  final Future<NetResp<List<T>>> Function(int page, int pageSize) loadFunc;
  final Widget Function(BuildContext context, int index, T itemData)
      itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final bool autoLoad;
  final Function(PageProvider<T> provider)? didGetProvider;
  final EdgeInsetsGeometry? contentPadding;

  @override
  _ListWidgetState<T> createState() => _ListWidgetState<T>();
}

class _ListWidgetState<T> extends State<ListWidget<T>>
    with AutomaticKeepAliveClientMixin<ListWidget<T>> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageRefWidget<T>(
      widget.loadFunc,
      autoLoad: widget.autoLoad,
      didGetProvider: widget.didGetProvider,
      builder: (_, provider) => ListView.separated(
          padding: widget.contentPadding,
          itemBuilder: (ctx, index) =>
              widget.itemBuilder.call(ctx, index, provider.data[index]),
          separatorBuilder: (ctx, idx) =>
              widget.separatorBuilder?.call(ctx, idx) ?? Container(),
          itemCount: provider.data.length),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ListRefWidget<T> extends StatefulWidget {
  ListRefWidget({
    Key? key,
    required this.loadFunc,
    required this.itemBuilder,
    required this.refStatus,
    this.separatorBuilder,
    this.autoLoad = true,
    this.didGetProvider,
  }) : super(key: key);
  final ValueNotifier<RefStatus> refStatus;
  final Future<NetResp<List<T>>> Function(int page, int pageSize) loadFunc;
  final Widget Function(BuildContext context, int index, T itemData)
      itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final bool autoLoad;
  final Function(PageProvider<T> provider)? didGetProvider;

  @override
  _ListRefWidgetState createState() => _ListRefWidgetState<T>();
}

class _ListRefWidgetState<T> extends State<ListRefWidget<T>>
    with AutomaticKeepAliveClientMixin<ListRefWidget<T>> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListWidget<T>(
      loadFunc: widget.loadFunc,
      itemBuilder: widget.itemBuilder,
      separatorBuilder: widget.separatorBuilder,
      autoLoad: widget.autoLoad,
      didGetProvider: (p) => provider = p,
    ).applyRefStatus(widget.refStatus, () async => provider?.reloadData());
  }

  PageProvider<T>? provider;

  @override
  bool get wantKeepAlive => true;
}
