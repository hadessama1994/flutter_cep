import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();
  String _dddR = "";


  _getCep() async{
    String cep = _controllerCep.text;
    String API = 'https://viacep.com.br/ws/${cep}/json/';

    http.Response response;
    response = await http.get(API);
    Map<String, dynamic> cepData = json.decode(response.body);

    String _logradouro = cepData["logradouro"];
    String _bairro = cepData["bairro"];
    String _cidade = cepData["localidade"];
    String _estado = cepData["uf"];
    String _ddd = cepData ["ddd"];



    setState(() {
      if (_logradouro == null){
      _dddR = "Digite um cep válido!!";
      }
      else {
        _dddR = "Rua: ${_logradouro}, Bairro: ${_bairro}, Cidade: ${_cidade}, Estado: ${_estado}, DDD: ${_ddd}";
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfffff8f0),
          child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
              color: Color(0xff9dd9d2),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80),
                ),
              ),
              child:
              Padding(
                padding: EdgeInsets.only(top: 75, bottom: 40),
                child: Column(
                  children: [
                    Image.asset(
                      'images/correios.png',
                    ),
                  ],
                )
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xfffff8f0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Digite um número de CEP:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                        TextField(
                          onSubmitted: (String cep) {_getCep();},
                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                          decoration: InputDecoration(
                          hintText: 'Exemplo: 28941038'
                          ),
                          controller: _controllerCep,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                        ElevatedButton(
                            onPressed: _getCep,
                            child: Text(
                                'Buscar...',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                            primary: Color(0xffff8811)
                            ),
                          ),
                        Padding(padding: EdgeInsets.only(bottom: 25)),

                        Text(_dddR,
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),

                        /*Expanded(
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          ],
                        ))*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
         ],
        ),

      ),
    );
  }
}
