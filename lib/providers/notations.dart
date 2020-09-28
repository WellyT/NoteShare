import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noteshare/dummydata/dummydata.dart';
import 'package:noteshare/model/Notation.dart';

class Notations with ChangeNotifier {
  final Map<String, Notation> _items = {...DUMMYDATA};

  List<Notation> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Notation byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Notation notation) {
    if (notation == null) {
      return;
    }

    if (notation.id != null &&
        notation.id.trim().isNotEmpty &&
        _items.containsKey(notation.id)) {
      _items.update(
        notation.id,
        (_) => Notation(
          id: notation.id,
          anotation: notation.anotation,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => Notation(
          id: id,
          anotation: notation.anotation,
        ),
      );
    }
    notifyListeners();
  }

  void remove(Notation notation) {
    if (notation != null && notation.id != null) {
      _items.remove(notation.id);
      notifyListeners();
    }
  }
}
