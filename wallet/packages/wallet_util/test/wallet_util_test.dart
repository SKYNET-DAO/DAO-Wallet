import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:wallet_util/wallet_util.dart';
import 'package:bip39/bip39.dart';

void main() {
  String mnemonic = generateMnemonic();
  Uint8List seed = mnemonicToSeed(
      "process forget believe wealth tennis ski radio coral swim home clay topple");
  HDWallet wallet = HDWallet(seed: seed);
  print("mnemonic:$mnemonic");
  print("ETH:${wallet.p2shAddr}");
  print("ETH:${wallet.legacyAddr}");
  print("ETH:${wallet.base32Addr}");
  //0x0D1cb3853A2e654B159E615Db8E9E01E32901b19
  //0x45aF1F12CD91b0648D27467d0CE599e72292edB4
}
