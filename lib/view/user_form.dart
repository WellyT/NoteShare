import 'package:flutter/material.dart';
import 'package:noteshare/model/Notation.dart';
import 'package:noteshare/providers/notations.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(Notation notation) {
    if (notation != null) {
      _formData['id'] = notation.id;
      _formData['anotation'] = notation.anotation;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Notation notation = ModalRoute.of(context).settings.arguments;

    _loadFormData(notation);
  }

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
                initialValue: _formData['anotation'],
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
              Container(
                color: Colors.green[400],
                height: 50,
                width: 100,
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.save),
                        color: Colors.green[50],
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
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
