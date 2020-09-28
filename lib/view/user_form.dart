import 'package:flutter/material.dart';
import 'package:noteshare/model/Notation.dart';
import 'package:noteshare/providers/notations.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert any notation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Insert your notation'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'An error has ocourred';
                  }

                  if (value.trim().length < 3) {
                    return 'Notation canot be less than 3';
                  }
                  return null;
                },
                onSaved: (value) => _formData['anotation'] = value,
              ),
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final isValid = _form.currentState.validate();

                    if (isValid) {
                      _form.currentState.save();
                      Provider.of<Notations>(context, listen: false).put(
                        Notation(
                          id: _formData['id'],
                          anotation: _formData['anotation'],
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
