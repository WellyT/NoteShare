import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noteshare/components/notation_tile.dart';
import 'package:noteshare/model/notation.dart';
import 'package:noteshare/providers/notations_provider.dart';
import 'package:noteshare/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NotationList extends StatefulWidget {
  var notations = new List<NotationItem>();
  NotationList() {
    notations = [];
    notations.add(NotationItem(id: '1', anotation: 'teste'));
  }
  @override
  _NotationListState createState() => _NotationListState();
}

class _NotationListState extends State<NotationList> {
  _buildList(NotationsProvider notationsProvider) {
    return ListView.builder(
        itemCount: notationsProvider.notations.length,
        itemBuilder: (context, index) {
          return _buildNotations(
              notationsProvider.notations[index], notationsProvider, index);
        });
  }

  _buildNotations(
      NotationItem model, NotationsProvider notationsProvider, int index) {
    return NotationTile(model, notationsProvider, index);
  }

  NotationsProvider notationx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Anotações'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM, arguments: {
                'notation': null,
                'notationsProvider': notationx
              });
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer<NotationsProvider>(
          builder: (context, notationProvider, widget) {
        notationx = notationProvider;
        return _buildList(notationProvider);
      }),
    );
  }
}
