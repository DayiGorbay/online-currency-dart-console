import 'package:currency_api/Models/currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dotenv/dotenv.dart';
import 'dart:io';

List<Currency> currency = [];

final env = DotEnv();

Future<String> getResponse() async {

  try {

    env.load();

    var url = Uri.parse('${env['API_URL']}?key=${env['API_KEY']}');

    final response = await http.get(url);

    if (response.statusCode == 200) {

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      List currencyList = jsonResponse["currency"];

      if (currencyList.isNotEmpty) {

        currency.clear();

        for (var item in currencyList) {

          currency.add(
            Currency(
              date: item['date'].toString(),
              time: item['time'].toString(),
              name_en: item['name_en'].toString(),
              name: item['name'].toString(),
              price: item['price'].toString(),
              change_value: item['change_value'].toString(),
              change_percent: item['change_percent'].toString(),
              unit: item['unit'].toString(),
            ),
          );

        }
      }

      return "Success";

    } else {

      return "HTTP ${response.statusCode}";

    }

  } on SocketException {

    return "No Internet Connection";

  } catch (e) {

    return "Unexpected Error";

  }
  
}