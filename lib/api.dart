import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://app-mercuryapi.herokuapp.com";

class API {
  static Future getPreco(itempesquisa) async {
    var url = Uri.parse(baseUrl + '/preco/' + itempesquisa);
    return await http.get(url);
  }
}
