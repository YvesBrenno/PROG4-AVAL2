import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Color(0xFF000080), 
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número de imagens (1-20)',
                ),
                validator: (value) {
                  int? number = int.tryParse(value!);
                  if (number == null || number < 1 || number > 20) {
                    return 'Por favor, insira um número entre 1 e 20';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, int.parse(_controller.text));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}