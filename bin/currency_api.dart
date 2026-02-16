import 'package:currency_api/Controllers/api.dart' as api;

String formatNumber(String value) {
  final number = int.parse(value);
  return number.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => ',',
  );
}

Future<void> main (List<String> arguments) async {
  // print('Currency API Project: ${api.getResponse()}!');

  await api.getResponse();

  for (var item in api.currency) {

    print("نام: ${item.name}");
    print("${item.name_en} :نام لاتین");
    print("قیمت: ${formatNumber(item.price as String)} ${item.unit}");
    print("مقدار تغییر: ${formatNumber(item.change_value as String)} | درصد تغییر: %${item.change_percent}");
    print("آخرین بروزرسانی قیمت: ${item.date} ${item.time}");
    print("-------------------");
    
  }

}