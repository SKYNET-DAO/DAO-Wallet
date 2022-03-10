// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/wallet/wallet.dart';

class DataStorage {
  static const _LATEST_KEY = "DataStorage_LATEST_KEY";
  static Future<String> getLatestKey() async =>
      (await SharedPreferences.getInstance()).getString(_LATEST_KEY) ?? "";
  static Future<bool> setLatestKey(String latestKey) async =>
      (await SharedPreferences.getInstance()).setString(_LATEST_KEY, latestKey);

  static const _WALLET_KEY = "DataStorage_WALLET_KEY";
  static Future<Wallet?> getWallet(String key) async {
    String jsonStr =
        (await SharedPreferences.getInstance()).getString(_WALLET_KEY + key) ??
            "";
    debugPrint("wallet:$jsonStr");
    if (jsonStr.isNotEmpty) {
      try {
        Map info = json.decode(jsonStr) ?? {};
        if (info.isNotEmpty) {
          return Wallet.fromMap(info);
        }
      } catch (e) {}
    }
    return null;
  }

  static Future<bool> setWallet(String key, Wallet wallet) async {
    try {
      String jsonStr = json.encode(wallet.toMap);
      debugPrint("wallet:$jsonStr");
      return (await SharedPreferences.getInstance())
          .setString(_WALLET_KEY + key, jsonStr);
    } catch (e) {}
    return false;
  }

  static Future<Wallet?> getLatestWallet() async {
    String key = await getLatestKey();
    if (key.isNotEmpty) {
      return await getWallet(key);
    }
    return null;
  }
}
