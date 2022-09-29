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
      title: 'Preço Mercury - Maré Alta',
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
  // ignore: library_private_types_in_public_api
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  var produtos = <Produto>[];
  String itempesquisa = '802893q01';
  final _controller = TextEditingController();
  final _cont_listview = TextEditingController();
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController3 =
      RoundedLoadingButtonController();

  String itemerror = '';

  _getUsers(String itempresquisa) {
    API.getPreco(itempresquisa).then((response) {
      setState(() {
        if (response.statusCode != 200) {
          _btnController2.error();
          _btnController3.reset();
          itemerror = 'Erro Servidor';
        }
        {
          Iterable lista = json.decode(response.body);
          produtos = lista.map((model) => Produto.fromJson(model)).toList();
          itemerror = '';
          _btnController2.stop();
          _btnController3.stop();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Preços"),
          leadingWidth: 10,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Flexible(
                flex: 1,
                child: TextField(
                    onChanged: (String text) {
                      itempesquisa = text;
                      FontWeight.bold;
                    },
                    controller: _controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o codido do descrição do item',
                        hintText: 'Digite aqui!',
                        isDense: true))),
            const SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: RoundedLoadingButton(
                        loaderSize: 0.5,
                        color: Colors.blue,
                        successColor: Colors.blue,
                        onPressed: () {
                          _getUsers(itempesquisa);
                          _btnController3.reset();
                        },
                        valueColor: Color.fromRGBO(0, 0, 0, 1),
                        borderRadius: 10,
                        controller: _btnController2,
                        child: const Text('Pesquisar',
                            style: TextStyle(color: Colors.white)),
                      )),
                  const SizedBox(height: 10),
                  Flexible(
                      flex: 1,
                      child: RoundedLoadingButton(
                        color: Colors.blue,
                        successColor: Colors.blue,
                        onPressed: () {
                          _btnController2.reset();
                          _btnController3.reset();
                          _controller.clear();
                        },
                        valueColor: Colors.black,
                        borderRadius: 10,
                        controller: _btnController3,
                        child: const Text('Voltar',
                            style: TextStyle(color: Colors.white)),
                      )),
                ]),
            const SizedBox(height: 10),
            Flexible(
                flex: 6,
                child: ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            _btnController2.start();
                            _btnController3.reset();

                            _getUsers("rotor");
                          },
                          child: ListTile(
                            title: Visibility(
                              visible: (itemerror != 'Erro Servidor'),
                              replacement: Text(
                                itemerror,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              child: Text(
                                'Codigo =${produtos[index].codigo}\nDescricao = ${produtos[index].descricao}\nValor tabela = ${produtos[index].valorTabela}\nValor Venda = ${produtos[index].valorVenda}\nValor Custo = ${produtos[index].valorCusto}',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            subtitle: Visibility(
                              visible: (produtos[index].qtdaEst != '0'),
                              replacement: Text(
                                'Qtde Estoque = ${produtos[index].qtdaEst}',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 220, 37, 5)),
                              ),
                              child: Text(
                                'Qtda Estoque = ${produtos[index].qtdaEst}\n',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 71, 198, 29)),
                              ),
                            ),
                          ));
                    })),
          ],
        ));
  }
}
