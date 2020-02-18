import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Rate btcRate;
  Rate ethRate;
  Rate ltcRate;

  String btc = 'Select Your Currency.';
  String eth = 'Select Your Currency.';
  String ltc = 'Select Your Currency.';

  void updateLabels() {
    btc = showRate(btcRate);
    eth = showRate(ethRate);
    ltc = showRate(ltcRate);
  }

  List<Widget> getDropDownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  Future updateRates() async {
    btcRate = await CoinData(selectedCoin: selectedCurrency, baseCoin: 'BTC')
        .getResults();
    ethRate = await CoinData(selectedCoin: selectedCurrency, baseCoin: 'ETH')
        .getResults();
    ltcRate = await CoinData(selectedCoin: selectedCurrency, baseCoin: 'LTC')
        .getResults();
  }

  Widget getDropDownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropDownItems(),
      onChanged: (value) async {
        selectedCurrency = value;
        await updateRates();
        setState(() {
          updateLabels();
        });
      },
    );
  }

  Widget getCupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) async {
        selectedCurrency = currenciesList[value];
        await updateRates();
        setState(() {
          updateLabels();
        });
      },
      children: getDropDownItems(),
    );
  }

  Widget getCurrencyCard(String text) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 14.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String showRate(Rate rate) {
    String result = 'Select Your Currency.';
    if (rate != null) {
      result = '1 ${rate.base} = ${rate.value.toString()} ${rate.selected}';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 9.0, 18.0, 0),
              child: getCurrencyCard(btc),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 9.0, 18.0, 0),
              child: getCurrencyCard(eth),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 9.0, 18.0, 0),
              child: getCurrencyCard(ltc),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:
                  Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
            ),
          ]),
    );
  }
}
