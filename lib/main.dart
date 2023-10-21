import 'dart:convert';

import 'package:dioclud/back4app/cep_back4app_repository.dart';
import 'package:dioclud/model/cep_back4app_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerInput = TextEditingController(text: '');
    String textController;

    // Back4app var
    CepBack4appRepository cepRepository = CepBack4appRepository();
    CepsBack4appModel cepGet;
    List cepJson;
    var cepList = [];
    var count;

    void back4app() async {
      cepGet = await cepRepository.getCep();
      cepJson = cepGet.toJson().values.toList();
      cepList = cepJson[0];
    }

    back4app();

    // ViaCep
    var data;

    void httpViacep(String cepAPI) async {
      var response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cepAPI/json/'));
      data = jsonDecode(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Click Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                await cepRepository.putCep(cepList as CepBack4appModel);
              },
              child: const Text("Atualizar"),
            ),
            TextButton(
              onPressed: () async {
                await cepRepository.deleteCep("sREGBScOGh");
                print("Deletado");
              },
              child: const Text("Delete"),
            ),
            const Text(
              'Consulta CEP:',
            ),
            TextField(
              controller: controllerInput,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Color(0xff868686)), //<-- SEE HERE
                ),
                labelText: 'Password',
              ),
              onChanged: (String value) async {},
            ),
            ListView.builder(
              itemCount: cepList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(cepList[index]['cep']),
                    ),
                    const Divider(
                      height: 2.0,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          textController = controllerInput.text;

          // Back4app
          back4app();

          // Viacep
          httpViacep(textController);

          for (var i = 0; i <= cepList.length; i++) {
            var cepInBD = cepList[i]["cep"];

            if (textController.length == 8 && data != null) {
              // Cep digitado tem 8 números e é válido
              if (cepInBD != textController) {
                // Cep digitado não está no BD
                print('CEP registrado no BD.');
                return await cepRepository
                    .postCep(CepBack4appModel.criar(textController));
              } else {
                return print('Este cep já foi registrado');
              }
            } else {
              return print("CEP inválido!");
            }
          }
        },
        tooltip: 'Increment',
        backgroundColor: Colors.tealAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
