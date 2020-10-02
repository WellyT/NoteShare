import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:noteshare/model/notation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotationsProvider extends ChangeNotifier {
  List<NotationItem> notations = [];
  void add(String id, String anotation) {
    notations.add(NotationItem(id: id, anotation: anotation));
    save();
  }

  void edit(String anotation, int index) {
    notations[index].anotation = anotation;
    save();
  }

  void remove(int index) {
    notations.removeAt(index);
    save();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(notations));
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    print(data.length);
    print('testes');
    print(data.runtimeType);
    if (data != null && data != '[]') {
      print('teste');
      Iterable decoded = jsonDecode(data);
      print(decoded);
      List<NotationItem> result =
          decoded.map((x) => NotationItem.fromJson(x)).toList();

      notations = result;
    }
  }

  NotationsProvider() {
    load();
  }
}
