import 'dart:developer';

void log2(String msg) {
  // lazy local debugging:
  print(msg);
  // the actual log message:
  log(msg, level: 1, name: "app");
}
