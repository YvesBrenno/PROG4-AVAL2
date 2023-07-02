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
                controller: _controller, // Controlador do campo de texto
                keyboardType: TextInputType.number, // Tipo de teclado numérico
                decoration: InputDecoration(
                  labelText: 'Número de imagens (1-20)', 
                  labelStyle: TextStyle(color: Colors.white), 
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white), 
                validator: (value) {
                  int? number = int.tryParse(value!); // Tenta converter o valor para um número inteiro
                  if (number == null || number < 1 || number > 20) {
                    // Valida se o número está dentro do intervalo válido
                    return 'Por favor, insira um número entre 1 e 20';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Salvar'), 
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF000080), 
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      int.parse(_controller.text),
                    ); // Fecha a tela e retorna o valor do campo de texto convertido para inteiro
                  }
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black, 
    );
  }
}