import 'dart:convert';




void prettyPrintJson(String input) {
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(input);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => print(element));
}

void prettyPrintMap(Map<dynamic, dynamic>? inputMap) {
  var encodedJson = jsonEncode(inputMap);
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(encodedJson);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => print(element));
}

saveData(String token) {
  List<String> split = token.split('.');
  String norString = base64Url.normalize(split[1]);
  String payload = utf8.decode(base64Url.decode(norString));
  Map<String, dynamic> decode = json.decode(payload);
  // PreferenceManager.setData(PreferenceManager.bearerToken, token);
}
