import 'package:flutter/foundation.dart';

class TabBoxProvider extends ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  set changeIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
