import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as req;

class Requestor {
  final String url = 'https://pokeapi.co/api/v2/pokemon/';
  final int count = 20;
  final headers = {"Accept": "application/json"};

  Future<Map<String, dynamic>> getPokemons(int offset) async {
    var endpoint = '$url?offset=$offset&limit=$count';
    print(endpoint);
    var res = await req.get(Uri.encodeFull(endpoint), headers: headers);
    if (res.statusCode != 200) {
      return Map<String, dynamic>();
    }
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getPokemonData(String pokemonUrl) async {
    var res = await req.get(Uri.encodeFull(pokemonUrl), headers: headers);
    if (res.statusCode != 200) {
      return Map<String, dynamic>();
    }
    return jsonDecode(res.body);
  }
}
