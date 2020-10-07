import 'package:flutter/material.dart';
import 'package:noteshare/model/notation.dart';
import 'package:noteshare/providers/notations_provider.dart';
import 'package:noteshare/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NotationTile extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final NotationItem notation;
  final int index;
  final NotationsProvider notationsProvider;
  NotationTile(this.notation, this.notationsProvider, this.index);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(notation.anotation),
      trailing: Container(
        key: _scaffoldKey,
        width: 150,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: {
                    'notation': notation,
                    'notationsProvider': notationsProvider,
                    'index': index
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(notation.anotation);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Deletar anotação'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      FlatButton(
                        onPressed: () {
                          notationsProvider.remove(index);
                          notationsProvider.notifyListeners();
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
