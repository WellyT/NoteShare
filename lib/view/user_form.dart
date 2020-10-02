import 'package:flutter/material.dart';
import 'package:noteshare/model/notation.dart';
import 'package:noteshare/providers/notations_provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};
  bool isEdit = false;
  dynamic index;
  NotationsProvider notationsProvider;
  void _loadFormData(NotationItem notation, dynamic index) {
    print(index);
    print('tt');
    if (notation != null) {
      isEdit = true;
      this.index = index;
      _formData['id'] = notation.id;
      _formData['anotation'] = notation.anotation;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final NotationItem notation = arguments['notation'];
    print(arguments['notationsProvider']);
    notationsProvider = arguments['notationsProvider'];
    _loadFormData(notation, arguments['index']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(() {
          return isEdit ? 'Editar Nota' : 'Adicionar Nota';
        }()),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['anotation'],
                decoration: InputDecoration(labelText: 'Adicione uma nota'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'An error has ocourred';
                  }

                  if (value.trim().length < 3) {
                    return 'Nota não pode ser menor que 3';
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
                            if (isEdit) {
                              notationsProvider.edit(
                                  _formData['anotation'], index);
                            } else {
                              notationsProvider.add(
                                  _formData['id'], _formData['anotation']);
                            }
                            notationsProvider.notifyListeners();
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
