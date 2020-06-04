import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/json_rpc.dart';

class WalletInfo with ChangeNotifier {
  Web3Client _ethClient;
  Wallet _wallet;
  String _seedPhrase;
  EthereumAddress _publicAddress;
  JsonRPC _jRPC;
  String _apiUrl;

  WalletInfo(String apiUrl) {
    this._ethClient = Web3Client(apiUrl, http.Client());
    this._jRPC = JsonRPC(apiUrl, http.Client());
    this._apiUrl = apiUrl;
  }

  Map<String, dynamic> toJSON() {
    return {
      'wallet': _wallet.toJson(),
      'seedPhrase': _seedPhrase,
      'publicAddress': _publicAddress.hex,
      'apiUrl': _apiUrl,
    };
  }

  Future<EthereumAddress> importWallet({String wal}) async {
    if (json == null) {
      //wallet not saved
      return null;
    }
    SharedPreferences.getInstance().then((sp) {
      if(sp.getString('wallet') == null) print("WALLET IS NULL");
      Map<String, dynamic> decoded = json.decode(sp.getString('wallet'));
      print(decoded);
      _wallet = Wallet.fromJson(decoded['wallet'], decoded['seedPhrase']);
      _seedPhrase = decoded['seedPhrase'];
      _wallet.privateKey.extractAddress().then(
          (res) {
            _publicAddress = res;
            _apiUrl = decoded['apiUrl'];
            _ethClient = Web3Client(_apiUrl, http.Client());
            _jRPC = JsonRPC(_apiUrl, http.Client());
            print(_wallet);
            print(_wallet.privateKey);
            print(_seedPhrase);
            print(_publicAddress);
            print(_apiUrl);
            return _publicAddress;
          }
      );
    }).then((res) {return res;});
  }

  Future<void> createWallet(String seedPhrase) async {
    EthPrivateKey privateKey =
        EthPrivateKey.fromHex(bip39.mnemonicToSeedHex(seedPhrase));
    _wallet = Wallet.createNew(privateKey, seedPhrase, Random.secure());

    _publicAddress = await _wallet.privateKey.extractAddress();
    _seedPhrase = seedPhrase;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('wallet', json.encode(toJSON()));
  }

  EthPrivateKey get privateKey
  {
    return _wallet.privateKey;
  }
  Future<String> get balance async {
    return _jRPC
        .call('eth_getBalance', [_publicAddress.hex, 'latest']).then((response){
      return response.result.toString();
    });

  }

  EthereumAddress get publicAddress  {
    print("PRINT ADDRESS $_publicAddress");
    return _publicAddress;
  }

}
