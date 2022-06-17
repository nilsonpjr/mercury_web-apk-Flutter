import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mercury_web/Produto.dart';
import 'api.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Http-Json-ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BuildListView(),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({Key? key}) : super(key: key);

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  var produtos = <Produto>[];
  String itempesquisa = '33395';
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  _getUsers(String itempresquisa) {
    API.getPreco(itempresquisa).then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        produtos = lista.map((model) => Produto.fromJson(model)).toList();
        _btnController2.stop();
      });
    });
  }

  _BuildListViewState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Preços "),
          leadingWidth: 5,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Flexible(
                child: TextField(
                    onChanged: (String text) {
                      itempesquisa = text;
                      FontWeight.bold;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o codido do descrição do item',
                        hintText: 'Digite aqui!',
                        isDense: true)),
                flex: 1),
            const SizedBox(height: 20),
            Flexible(
                child: RoundedLoadingButton(
                  color: Colors.blue,
                  successColor: Colors.blue,
                  onPressed: () {
                    _getUsers(itempesquisa);
                  },
                  valueColor: Colors.black,
                  borderRadius: 10,
                  controller: _btnController2,
                  child: const Text('Pesquisar',
                      style: TextStyle(color: Colors.white)),
                ),
                flex: 1),
            SizedBox(height: 20),
            Flexible(
                child: ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            _btnController2.start();
                            _getUsers("rotor");
                          },
                          child: ListTile(
                            title: Text(
                              '----------------------------------------------\nCodigo =' +
                                  produtos[index].codigo +
                                  '\nDescricao = ' +
                                  produtos[index].descricao,
                              style: const TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                            subtitle: Text(
                              'Valor Custo = ' +
                                  produtos[index].valorCusto +
                                  '\n',
                              style: const TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ));
                    }),
                flex: 8),
          ],
        ));
  }
}
