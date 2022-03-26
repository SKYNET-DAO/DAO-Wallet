// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:typed_data';

import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';
import 'package:wallet/token/token.dart';
import 'package:wallet_util/wallet_util.dart';

class Wallet {
  String mnemonic = "";
  List<Token> tokens = [];
  bool multiple = true;
  Wallet.fromMnemonic(this.mnemonic);

  Future<HDWallet> get hdWallet async {
    Uint8List seed = mnemonicToSeed(mnemonic);
    return HDWallet(seed: seed);
  }

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
