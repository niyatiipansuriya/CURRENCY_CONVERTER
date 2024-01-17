import 'package:http/http.dart' as http;
import 'package:currency/models/rates_model.dart';
import 'package:currency/models/all_currencies.dart';

Future<RatesModel> fetchrates() async {
  try {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=c9acd7645e874d7bb1a682606270bf3f'));

    if (response.statusCode == 200) {
      final result = ratesModelFromJson(response.body);
      return result;
    } else {
      // Handle non-200 status code (e.g., show an error message)
      throw Exception('Failed to load rates');
    }
  } catch (e) {
    // Handle other errors (e.g., network issues)
    throw Exception('Failed to load rates');
  }
}

Future<Map> fetchcurrencies() async {
  try {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/currencies.json?app_id=c9acd7645e874d7bb1a682606270bf3f'));

    if (response.statusCode == 200) {
      final allCurrencies = allCurrenciesFromJson(response.body);
      return allCurrencies;
    } else {
      // Handle non-200 status code (e.g., show an error message)
      throw Exception('Failed to load currencies');
    }
  } catch (e) {
    // Handle other errors (e.g., network issues)
    throw Exception('Failed to load currencies');
  }
}

String convertusd(Map exchangeRates, String usd, String currency) {
  print('Inside convertusd function');
  print('usd: $usd, currency: $currency');

  // Convert usd to a double
  double parsedUsd = double.tryParse(usd) ?? 0.0;

  double output = (exchangeRates[currency] * parsedUsd);

  print('output: $output');

  return output.toStringAsFixed(2);
}

