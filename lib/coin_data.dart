import 'package:http/http.dart' as http;
import 'dart:convert';

String currencyName = 'AUD';
String cryptoName = 'BTC';
String url = 'https://rest.coinapi.io/v1/exchangerate/';
String apiKey = '?apikey=91D7611C-F1F5-4874-B7D5-0E775A0513F5';
String apiKey2 = '?apikey=CBDA7723-54F6-498E-BD86-401C87AF7581';
String apiKey3 = '?apikey=E674CD42-E1F1-4D2A-9373-0E1DA6045A41';
String apiKey4 = '?apiKey=9A8D707D-6414-4152-A624-5032B0A28874';

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

class GetAPI {
  GetAPI(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class CoinPrice {
  Future<dynamic> getCryptoPriceInAnyFiat(
      String cryptoName, String fiat) async {
    GetAPI coinData = GetAPI('$url$cryptoName/$fiat$apiKey');
    var jsonCoinPrice = await coinData.getData();
    if (jsonCoinPrice != null) {
      return jsonCoinPrice;
    } else {
      return;
    }
  }
}
