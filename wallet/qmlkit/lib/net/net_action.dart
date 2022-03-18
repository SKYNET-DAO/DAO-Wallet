import 'package:dio/dio.dart';
import 'package:qmlkit/bean/net_resp.dart';
import 'package:qmlkit/net/net_client.dart';
import 'package:qmlkit/net/net_request.dart';

class NetAction {
  static NetRequest client = NetRequest(NetClient());
  static Future<NetResp<T>> post<T>(
    String url, {
    required dynamic params,
    Map<String, dynamic>? headers,
    NetResp<T> Function(Map dataMap)? convertFunc,
    NetResp<T> Function(Response? res)? respConvertFunc,
  }) =>
      client.post<T>(
        url,
        params: params,
        headers: headers,
        convertFunc: convertFunc,
        respConvertFunc: respConvertFunc,
      );

  static Future<NetResp<T>> put<T>(
    String url, {
    required dynamic params,
    Map<String, dynamic>? headers,
    NetResp<T> Function(Map dataMap)? convertFunc,
    NetResp<T> Function(Response? res)? respConvertFunc,
  }) =>
      client.put<T>(
        url,
        params: params,
        headers: headers,
        convertFunc: convertFunc,
        respConvertFunc: respConvertFunc,
      );

  static Future<NetResp<T>> form<T>(
    String url, {
    required dynamic params,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    NetResp<T> Function(Map dataMap)? convertFunc,
    NetResp<T> Function(Response? res)? respConvertFunc,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      client.form<T>(
        url,
        params: params,
        cancelToken: cancelToken,
        headers: headers,
        convertFunc: convertFunc,
        respConvertFunc: respConvertFunc,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  static Future<NetResp<T>> download<T>(
    String url,
    String savePath, {
    CancelToken? cancelToken,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    NetResp<T> Function(Map dataMap)? convertFunc,
    NetResp<T> Function(Response? res)? respConvertFunc,
    ProgressCallback? onReceiveProgress,
  }) =>
      client.download<T>(
        url,
        savePath,
        params: params,
        cancelToken: cancelToken,
        headers: headers,
        convertFunc: convertFunc,
        respConvertFunc: respConvertFunc,
        onReceiveProgress: onReceiveProgress,
      );

  static Future<NetResp<T>> get<T>(
    String url, {
    required Map<String, dynamic> params,
    Map<String, dynamic>? headers,
    NetResp<T> Function(Map dataMap)? convertFunc,
    NetResp<T> Function(Response? res)? respConvertFunc,
  }) =>
      client.get<T>(
        url,
        params: params,
        headers: headers,
        convertFunc: convertFunc,
        respConvertFunc: respConvertFunc,
      );
  static Future<NetResp<T>> delete<T>(
    String url, {
    required Map<String, dynamic> params,
    Map<String, dynamic>? headers,
    NetResp<T> Function(Map dataMap)? convertFunc,
    NetResp<T> Function(Response? res)? respConvertFunc,
  }) =>
      client.delete<T>(
        url,
        params: params,
        headers: headers,
        convertFunc: convertFunc,
        respConvertFunc: respConvertFunc,
      );
}
