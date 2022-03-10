import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallet/token/token.dart';

class Wallet {
  String mnemonic = "";
  List<Token> tokens = [];
  bool multiple = true;
  Wallet.fromMnemonic(this.mnemonic);

  Map<String, String> get toMap => {
        "mnemonic": mnemonic,
        "tokens": json.encode(tokens.map((e) => e.toMap).toList()),
        "multiple": multiple ? "1" : "0",
      };
  Wallet.fromMap(Map info) {
    mnemonic = info["mnemonic"] ?? "";
    String tokensJson = info["tokens"] ?? "";
    debugPrint("tokenJson:$tokensJson");
    try {
      List tokensList = json.decode(tokensJson);
      tokens = tokensList.map((e) => Token.formMap(e)).toList();
    } catch (e) {
      debugPrint("error:$e");
      debugPrintStack();
      tokens = [];
    }
    multiple = (int.tryParse('${info["multiple"]}') ?? 1) == 1;
  }
}
