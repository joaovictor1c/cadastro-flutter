import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/models/user.dart';
import 'package:web/provider/user.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
      _formData['address'] = user.address;
      _formData['state'] = user.state;
      _formData['city'] = user.city;
      _formData['zipCode'] = user.zipCode;
      _formData['number'] = user.number;
      _formData['complement'] = user.complement;
    }
  }

  Map<String, dynamic> states;
  List<String> listState = new List<String>();

  Map<String, dynamic> cities;
  List<String> listCities = new List<String>();

  int indexState;

  String dropdownValueState;
  String dropdownValueCity;

  @override
  void initState() {
    this.loadAssetState();
    this.loadAssetCity();
  }

  loadAssetState() async {
    String jsonCurrency =
        await rootBundle.loadString('assets/estados-cidades.json');
    setState(() {
      states = jsonDecode(jsonCurrency);
      for (var i = 0; i < states['estados'].length; i++) {
        listState.add((states['estados'][i]['nome']));
      }
      indexState = listState.indexOf(_formData['state']);
    });
  }

  loadAssetCity() async {
    String jsonCurrency =
        await rootBundle.loadString('assets/estados-cidades.json');
    setState(() {
      cities = jsonDecode(jsonCurrency);
      listCities.clear();

      if (indexState >= 0) {
        for (var i = 0;
            i < states['estados'][indexState]['cidades'].length;
            i++) {
          listCities.add(cities['estados'][indexState]['cidades'][i]);
          _formData['city'] = cities['estados'][indexState]['cidades'][0];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context, listen: false);
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cadastro'),
        actions: [
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Center(
            child: Container(
              width: 700,
              height: 900,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData['name'],
                      decoration: const InputDecoration(
                        hintText: 'Digite seu nome',
                      ),
                      // decoration: InputDecoration(labelText: 'name'),
                      onSaved: (value) => _formData['name'] = value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nome inválido';
                        }
                        if (value.trim().length < 3) {
                          return 'Nome muito curto';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['email'],
                      decoration: InputDecoration(
                        hintText: 'Digite seu email',
                      ),
                      validator: (value) {
                        final valid = EmailValidator.validate(value);
                        if (valid == false) {
                          return 'O email nao é valido';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['email'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration: InputDecoration(
                        hintText: 'Digite a URL do seu avatar',
                      ),
                      onSaved: (value) => _formData['avatarUrl'] = value,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: _formData['state'],
                        hint: Text('Estado'),
                        elevation: 16,
                        isExpanded: true,
                        // style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            indexState = listState.indexOf(newValue);

                            loadAssetCity();
                            dropdownValueState = newValue;
                            _formData['state'] = newValue;
                          });
                        },
                        items: listState.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: _formData['city'],
                        isExpanded: true,
                        elevation: 16,
                        hint: Text('Cidade'),
                        // style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValueCity = newValue;
                            _formData['city'] = newValue;
                          });
                        },
                        items: listCities.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    TextFormField(
                      initialValue: _formData['address'],
                      decoration: InputDecoration(
                        hintText: 'Digite seu Endereço',
                      ),
                      onSaved: (value) => _formData['address'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['zipCode'],
                      decoration: InputDecoration(
                        hintText: 'Digite seu cep',
                      ),
                      onSaved: (value) => _formData['zipCode'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['number'],
                      decoration: InputDecoration(
                        hintText: 'Digite o número do seu endereço',
                      ),
                      onSaved: (value) => _formData['number'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['complement'],
                      decoration: InputDecoration(
                        hintText: 'Digite o complemento',
                      ),
                      onSaved: (value) => _formData['complement'] = value,
                    ),
                    Container(
                      width: 400,
                      height: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Salvar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                height: 10,
                                fontSize: 25),
                          ),
                          IconButton(
                            color: Colors.green[500],
                            iconSize: 40,
                            icon: Icon(Icons.save),
                            onPressed: () {
                              final isValid = _form.currentState.validate();
                              if (isValid) {
                                _form.currentState.save();
                                users.put(
                                  User(
                                    id: _formData['id'],
                                    name: _formData['name'],
                                    email: _formData['email'],
                                    avatarUrl: _formData['avatarUrl'],
                                    lastName: _formData['lastName'],
                                    address: _formData['address'],
                                    zipCode: _formData['zipCode'],
                                    state: _formData['state'],
                                    city: _formData['city'],
                                    number: _formData['number'],
                                    complement: _formData['complement'],
                                  ),
                                );
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
