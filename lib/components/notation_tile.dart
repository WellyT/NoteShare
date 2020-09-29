import 'package:flutter/material.dart';
import 'package:noteshare/model/Notation.dart';
import 'package:noteshare/providers/notations.dart';
import 'package:noteshare/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NotationTile extends StatelessWidget {
  final Notation notation;

  const NotationTile(this.notation);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(notation.anotation),
      trailing: Container(
        width: 150,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: notation,
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
                    title: Text('Delete notation'),
                    content: Text('You sure?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<Notations>(context, listen: false)
                              .remove(notation);
                          Navigator.of(context).pop();
                        },
                        child: Text('Yes'),
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
