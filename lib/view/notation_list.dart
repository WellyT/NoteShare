import 'package:flutter/material.dart';
import 'package:noteshare/components/notation_tile.dart';
import 'package:noteshare/providers/notations.dart';
import 'package:noteshare/routes/routes.dart';
import 'package:provider/provider.dart';

class NotationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Notations dummyNotation = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Anotações'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyNotation.count,
        itemBuilder: (ctx, i) => NotationTile(dummyNotation.byIndex(i)),
      ),
    );
  }
}
