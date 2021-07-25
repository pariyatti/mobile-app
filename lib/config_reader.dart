import 'dart:convert';

class ConfigReader {
  late Map<String, dynamic> _config;

  ConfigReader.fromConfigString(String configString) {
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  //TODO: This is a sample, remove once an actual property is included
  String getSecretKey() {
    return _config['secret-key'] as String;
  }
}
