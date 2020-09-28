import 'package:flutter/material.dart';
import 'package:noteshare/model/Notation.dart';
import 'package:noteshare/routes/routes.dart';

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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
