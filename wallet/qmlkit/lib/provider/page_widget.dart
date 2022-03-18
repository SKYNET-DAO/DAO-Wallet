import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:qmlkit/bean/net_resp.dart';
import 'package:provider/provider.dart';

class PageProvider<T> extends RespProvider {
  PageProvider(
    this.loadFunc, {
    this.dataChanged,
    this.isEndCheckFunc,
    this.startPage = 1,
    this.pageSize = 10,
    this.checkNoData = true,
  }) : super();
  final Future<NetResp<List<T>>> Function(int page, int pageSize) loadFunc;
  final int startPage;
  final int pageSize;
  final bool checkNoData;
  Function(NetResp<List<T>> resp)? dataChanged;
  bool Function(NetResp<List<T>> resp)? isEndCheckFunc;

  NetResp<List<T>>? resp;
  bool isEnd = true;
  List<T> data = [];
  int? _page;
  int? get page => _page;
  Future<void> reloadData() async {
    _page = startPage;
    await _loadData();
  }

  Future<void> loadMore() async {
    if (_page == null) {
      await reloadData();
      return;
    }
    _page = _page! + 1;
    await _loadData();
  }

  Future<NetResp<List<T>>> _loadData() async {
    Future<NetResp<List<T>>> future =
        loadFunc.call(_page ?? startPage, pageSize);
    NetResp<List<T>> res = await future;
    _loadDataFinished(res);
    return res;
  }

  void _loadDataFinished(NetResp<List<T>> res) {
    resp = res;
    code = res.code;
    msg = res.msg;
    if (res.isOK) {
      if (_page == 1) {
        data.clear();
      }
      if (res.data == null) {
        status = RespStatus.error;
      } else {
        data.addAll(res.data ?? []);
        if (checkNoData && data.length == 0) {
          isEnd = true;
          status = RespStatus.empty;
        } else {
          isEnd =
              isEndCheckFunc?.call(res) ?? ((res.data?.length ?? 0) < pageSize);
          status = RespStatus.ok;
        }
      }
    } else {
      status = RespStatus.error
        ..code = code
        ..msg = msg;
    }
    dataChanged?.call(res);
  }

  void removeItemAtIndex(int index) {
    if (index < data.length) {
      data.removeAt(index);
      if (data.length == 0) {
        if (isEnd) {
          status = RespStatus.empty;
        } else {
          status = RespStatus.loading;
          reloadData();
        }
      } else {
        commit();
      }
    }
  }
}

class PageWidget<T> extends StatelessWidget {
  const PageWidget(
    this.loadFunc, {
    Key? key,
    required this.builder,
    this.sliver = false,
    this.autoLoad = true,
    this.didGetProvider,
    this.statusWidgetBuilder,
    this.onStatusWidgetClick,
    this.dataChanged,
    this.checkNoData = true,
  }) : super(key: key);
  final Future<NetResp<List<T>>> Function(int page, int pageSize) loadFunc;
  final Widget Function(BuildContext context, PageProvider<T> provinder)
      builder;
  final bool sliver;
  final bool autoLoad;
  final Function(PageProvider<T> provider)? didGetProvider;
  final Widget? Function(PageProvider<T>)? statusWidgetBuilder;
  final Function(PageProvider<T>)? onStatusWidgetClick;
  final Function(NetResp<List<T>> resp)? dataChanged;
  final bool checkNoData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageProvider<T>>(
      create: (_) {
        var p = PageProvider<T>(loadFunc,
            dataChanged: dataChanged, checkNoData: checkNoData);
        didGetProvider?.call(p);
        if (autoLoad) {
          p.status = RespStatus.loading;
          p.reloadData();
        }
        return p;
      },
      child: Consumer<PageProvider<T>>(
        builder: (ctx, provider, __) => RespWidget(
          provider.status,
          sliver: sliver,
          statusWidgetBuilder: statusWidgetBuilder != null
              ? (_) => statusWidgetBuilder!.call(provider)
              : null,
          builder: (_) => builder.call(ctx, provider),
          onTap: () {
            if (onStatusWidgetClick != null) {
              onStatusWidgetClick?.call(provider);
            } else {
              provider.status = RespStatus.loading;
              provider.reloadData();
            }
          },
        ),
      ),
    );
  }
}

class PageRefWidget<T> extends StatelessWidget {
  const PageRefWidget(
    this.loadFunc, {
    Key? key,
    required this.builder,
    this.sliver = false,
    this.autoLoad = true,
    this.didGetProvider,
    this.statusWidgetBuilder,
    this.onStatusWidgetClick,
    this.dataChanged,
    this.checkNoData = true,
  }) : super(key: key);
  final Future<NetResp<List<T>>> Function(int page, int pageSize) loadFunc;
  final Widget Function(BuildContext context, PageProvider<T> provinder)
      builder;
  final bool sliver;
  final bool autoLoad;
  final Function(PageProvider<T> provider)? didGetProvider;
  final Widget? Function(PageProvider<T>)? statusWidgetBuilder;
  final Function(PageProvider<T>)? onStatusWidgetClick;
  final Function(NetResp<List<T>> resp)? dataChanged;
  final bool checkNoData;

  @override
  Widget build(BuildContext context) {
    return PageWidget<T>(
      loadFunc,
      sliver: sliver,
      autoLoad: autoLoad,
      didGetProvider: didGetProvider,
      statusWidgetBuilder: statusWidgetBuilder,
      onStatusWidgetClick: onStatusWidgetClick,
      dataChanged: dataChanged,
      checkNoData: checkNoData,
      builder: (ctx, provider) => EasyRefresh(
        child: builder.call(ctx, provider),
        header: MaterialHeader(),
        footer: ClassicalFooter(showInfo: false),
        onRefresh: () async => await provider.reloadData(),
        onLoad: provider.isEnd ? null : () async => await provider.loadMore(),
      ),
    );
  }
}
