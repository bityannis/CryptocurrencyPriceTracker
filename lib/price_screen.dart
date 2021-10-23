import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io'
    show
        Platform; // Take only the Platform class from SDK to check which platform the device is running on.

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String bitcoinPrice = '0.0';
  String etherPrice = '0.0';
  String litcoinPrice = '0.0';

  androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: currencyName,
      items: dropdownItems,
      onChanged: (newValue) {
        setState(() {
          currencyName = newValue;
        });
      },
    );
  }

  void getCryptoPriceInAnyFiat() async {
    CoinPrice bitcoinInFiat = CoinPrice();
    var jsonFile =
        await bitcoinInFiat.getCryptoPriceInAnyFiat(cryptoName, currencyName);
    print(jsonFile);
    var price = jsonFile['rate'].toStringAsFixed(0).toString();
    print(price);

    var jsonFileEth =
        await bitcoinInFiat.getCryptoPriceInAnyFiat('ETH', currencyName);
    print(jsonFileEth);
    var priceEth = jsonFileEth['rate'].toStringAsFixed(0).toString();
    print(priceEth);

    var jsonFileLtc =
        await bitcoinInFiat.getCryptoPriceInAnyFiat('LTC', currencyName);
    print(jsonFileLtc);
    var priceLtc = jsonFileLtc['rate'].toStringAsFixed(0).toString();
    print(priceLtc);

    setState(() {
      if (jsonFile != null) {
        bitcoinPrice = price;
      } else {
        bitcoinPrice = '?';
      }
    });

    setState(() {
      if (jsonFileEth != null) {
        etherPrice = priceEth;
      } else {
        etherPrice = '?';
      }
    });

    setState(() {
      if (jsonFileLtc != null) {
        litcoinPrice = priceLtc;
      } else {
        litcoinPrice = '?';
      }
    });
  }

  CupertinoPicker iOSPicker() {
    List<Text> currencies = [];

    for (String currency in currenciesList) {
      currencies.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        print(index);
        print(currenciesList[index]);
        setState(() {
          currencyName = currenciesList[index];
        });
        getCryptoPriceInAnyFiat();
      },
      children: currencies,
    );
  }

  @override
  //Lance la requete API des le debut pour recuper le prix
  void initState() {
    super.initState();
    // getBitcoinPrice();
    getCryptoPriceInAnyFiat();
    print(currencyName);
    print('$url$currencyName$apiKey4');
  }

  Widget build(BuildContext context) {
    print(bitcoinPrice);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Price Tracker 💸'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.orange,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinPrice $currencyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.teal,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $etherPrice $currencyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.grey,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $litcoinPrice $currencyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blueGrey[400],
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
