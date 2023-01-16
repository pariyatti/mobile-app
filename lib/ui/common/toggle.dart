import 'dart:async';

class Toggle {
  StreamController _toggleController = new StreamController.broadcast();
  Stream get onToggle => _toggleController.stream;
  bool isActive = false;

  Toggle({required this.isActive});

  void off() {
    isActive = false;
    _toggleController.add(isActive);
  }

  void on() {
    isActive = true;
    _toggleController.add(isActive);
  }
}