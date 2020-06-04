import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class EthClient with ChangeNotifier

{
  String _apiUrl;// = "http://127.0.0.1:8545";
  var _httpClient;// = http.Client();
  var _ethClient;

  EthClient(String url, http.Client httpClient) {
    this._apiUrl = url;
    this._httpClient = httpClient;
    _ethClient = Web3Client(url, httpClient);
  }

  Web3Client get ethClient
  {
    return _ethClient;
  }

}