import 'package:http/http.dart' as http;
import 'dart:convert';

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
const apiKey = "895E556C-6F63-480B-B163-34CFEBBFEA3E";

class CoinData {
  Future getData({required String selectedCurrency}) async {
    Map<String, String> cryptosMaps = {};
    for (String cryptoCurrency in cryptoList) {
      String requestURL =
          '$coinAPIURL/$cryptoCurrency/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(
        Uri.parse(requestURL),
      );

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData["rate"];
        cryptosMaps.addAll({cryptoCurrency: lastPrice.toStringAsFixed(0)});
        // return lastPrice;
      } else {
        //10. Handle any errors that occur during the request.
        print(response.statusCode);
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    return cryptosMaps;
  }
}
