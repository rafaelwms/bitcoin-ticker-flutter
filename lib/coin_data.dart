import 'dart:convert';
import 'package:bitcoin_ticker/network_helper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class Rate {
  Rate({this.base, this.selected, this.value});
  String base;
  String selected;
  double value;
}

class CoinData {
  CoinData({this.selectedCoin, this.baseCoin});

  final String selectedCoin;
  final String baseCoin;

  Future<Rate> getResults() async {
    String url = url_link + '$baseCoin/$selectedCoin' + apiKey;
    NetworkHelper helper = NetworkHelper(url: url);
    String jsonData = await helper.getData();
    Rate rate = Rate(
        base: baseCoin,
        selected: selectedCoin,
        value: jsonDecode(jsonData)['rate']);
    return rate;
  }
}
