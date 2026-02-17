import 'dart:async';
import 'package:currency_api/Controllers/api.dart' as api;
import 'dart:io';
import 'package:cli_table/cli_table.dart';

String formatNumber(String value) {
  final number = int.parse(value);
  return number.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => ',',
  );
}

void clearConsole() {
  if (Platform.isWindows) {
    Process.runSync('cls', [], runInShell: true);
  } else {
    Process.runSync('clear', [], runInShell: true);
  }
}

Future<void> main (List<String> arguments) async {
  // print('Currency API Project: ${api.getResponse()}!');

  // Color Varibales
  String red(String text) => '\x1B[31m$text\x1B[0m';
  String green(String text) => '\x1B[32m$text\x1B[0m';
  String yellow(String text) => '\x1B[33m$text\x1B[0m';


  final table_en = Table(  
    header: ['Name', 'English Name', 'Price', 'Change Value', 'Change Percent', 'Last Update'],
    columnWidths: [15,20,15,15,18,20],
  );

  final table_fa = Table(
    header: ['آخرین بروزرسانی', 'درصد تغییر', 'مقدار تغییر', 'قیمت ارز', 'نام لاتین', 'نام ارز'],
    columnWidths: [20,18,15,15,20,15],
  );

  print("fetching data from API...");

  String result = await api.getResponse();

  if (result != "Success") {
    print(red("Error: $result"));
    print("Press enter to exit...");
    await stdin.first;
    return;
  }

  print(green("Done!"));
  sleep(Duration(seconds: 1));
  clearConsole();

  for (var item in api.currency) {

    // print("نام: ${item.name}");
    // print("${item.name_en} :نام لاتین");
    // print("قیمت: ${formatNumber(item.price as String)} ${item.unit}");
    // print("مقدار تغییر: ${formatNumber(item.change_value as String)} | درصد تغییر: %${item.change_percent}");
    // print("آخرین بروزرسانی قیمت: ${item.date} ${item.time}");
    // print("-------------------");

    // Colorize change currency price

    double changePercent = double.parse(item.change_percent as String);
    int changeValue = int.parse(item.change_value as String);

    String coloredPercent =
      changePercent >= 0
        ? '\x1B[32m${item.change_percent}%\x1B[0m'
        : '\x1B[31m${item.change_percent}%\x1B[0m';

    String coloredValue(String text) =>
      changeValue >= 0
        ? '\x1B[32m$text\x1B[0m'
        : '\x1B[31m$text\x1B[0m';

    // English alignment version
    table_en
      .add([
        item.name,
        item.name_en,
        "${formatNumber(item.price as String)} ${item.unit}",
        coloredValue(formatNumber(item.change_value as String)),
        coloredPercent,
        "${item.date} - ${item.time}",
      ]);

    // Persian alignment version
    table_fa
      .add([
        "${item.date} - ${item.time}",
        coloredPercent,
        coloredValue(formatNumber(item.change_value as String)),
        "${formatNumber(item.price as String)} ${item.unit}",
        item.name_en,
        item.name,
      ]);

  }

  print("English alignment version - LTR:");
  print(table_en.toString());
  print("Persian alignment version - RTL:");
  print(table_fa.toString());

  print("Press enter to exit...");
  await stdin.first;

} /***************** CLI Version *****************/