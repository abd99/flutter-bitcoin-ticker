import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '88CF952F-04C8-4548-883A-54655AFBD896';

class CoinData {
  String rate = '';

  Future getCoinData(String currency) async {
    Map priceMap = Map();
    for (var crypto in cryptoList) {
      String finalUrl = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';
      print(finalUrl);
      var response = await http.get(finalUrl);
      if (response.statusCode == 200) {
        var decodedData = convert.jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        priceMap[crypto] = lastPrice;
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return priceMap;
  }
}
