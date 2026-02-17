import 'package:flutter/foundation.dart';

class TabShellController extends ChangeNotifier {
  final List<Map<String, String>> _tabs = [];
  int _activeTabIndex = 0;

  List<Map<String, String>> get tabs => List.unmodifiable(_tabs);
  int get activeTabIndex => _activeTabIndex;
  bool get isEmpty => _tabs.isEmpty;

  int indexOfRoute(String route) {
    return _tabs.indexWhere((tab) => tab['route'] == route);
  }

  void addOrActivateTab({required String route, required String name}) {
    final existingIndex = indexOfRoute(route);
    if (existingIndex >= 0) {
      _activeTabIndex = existingIndex;
      notifyListeners();
      return;
    }

    _tabs.add({'route': route, 'name': name});
    _activeTabIndex = _tabs.length - 1;
    notifyListeners();
  }

  void activateTab(int index) {
    if (index < 0 || index >= _tabs.length) {
      return;
    }

    _activeTabIndex = index;
    notifyListeners();
  }

  void closeTab(int index) {
    if (index < 0 || index >= _tabs.length) {
      return;
    }

    _tabs.removeAt(index);

    if (_tabs.isEmpty) {
      _activeTabIndex = 0;
      notifyListeners();
      return;
    }

    if (_activeTabIndex >= _tabs.length) {
      _activeTabIndex = _tabs.length - 1;
    }

    notifyListeners();
  }
}
