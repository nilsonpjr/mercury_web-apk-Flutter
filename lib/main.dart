import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mercury_web/Produto.dart';
import 'api.dart';

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

  _getUsers(String itempresquisa) {
    API.getPreco(itempresquisa).then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        produtos = lista.map((model) => Produto.fromJson(model)).toList();
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
            SizedBox(height: 30),
            TextField(
                onChanged: (String text) {
                  itempesquisa = text;
                  FontWeight.bold;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite o codido do descrição do item',
                    hintText: 'Digite aqui!',
                    isDense: true)),
            SizedBox(height: 20),
            ElevatedButton(
                child: const Text('Pesquisar'),
                onPressed: () {
                  _getUsers(itempesquisa);
                }),
            SizedBox(height: 20),
            Container(
                height: 450,
                child: ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          '----------------------------------------------\nCodigo =' +
                              produtos[index].codigo +
                              '\nDescricao = ' +
                              produtos[index].descricao,
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          'Valor Custo = ' + produtos[index].valorCusto + '\n',
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black),
                        ),
                      );
                    }))
          ],
        ));
  }
}
