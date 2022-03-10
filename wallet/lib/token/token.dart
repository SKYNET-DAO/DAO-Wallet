// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:wallet/r.dart';
import 'package:wallet/token/chain.dart';

class Token {
  final ChainType chain;
  final String symbol;
  final String name;
  final String path;
  String addr = "";
  final int decimals;
  final String contract;

  Token({
    this.chain = ChainType.undefine,
    this.name = "",
    this.symbol = "",
    this.path = "",
    this.decimals = 18,
    this.contract = "",
  });
  Map<String, String> get toMap => {
        "chain": chain.name,
        "symbol": symbol,
        "name": name,
        "path": path,
        "addr": addr,
        "decimals": "$decimals",
        "contract": contract,
      };
  static Token formMap(Map info) {
    ChainType chain = ChainType.values.byName("${info['chain']}");
    String symbol = info['symbol'] ?? "";
    String name = info['name'] ?? "";
    String path = info['path'] ?? "";
    String addr = info['addr'] ?? "";
    int decimals = int.tryParse('${info["decimals"]}') ?? 0;
    String contract = info["contract"] ?? "";
    return Token(
      chain: chain,
      symbol: symbol,
      name: name,
      path: path,
      decimals: decimals,
      contract: contract,
    )..addr = addr;
  }
}

extension TokenIconEx on Token {
  Widget buildIconWidget([double size = 16]) {
    String name = "";
    switch (symbol.toUpperCase()) {
      case "USDT":
        name = R.usdt;
        break;
      case "CMC":
        name = R.cmc;
        break;
      case "DOGE":
        name = R.doge;
        break;
      case "ETH":
        name = R.eth;
        break;
      case "BTC":
        name = R.btc;
        break;
    }
    return name.isNotEmpty
        ? Image.asset(
            name,
            width: size,
            height: size,
          )
        : SizedBox.shrink();
  }
}
