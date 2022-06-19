import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://app-mercuryapi.herokuapp.com";

class API {
  static Future getPreco(itempesquisa) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = Uri.parse(baseUrl + '/preco/' + itempesquisa);
    return await http.get(url);
  }
}
