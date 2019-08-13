import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as req;
import 'package:floaps/templates/Pokemon.dart';

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

  Future<Pokemon> getPokemonData(Pokemon pokemon) async {
    var res = await req.get(Uri.encodeFull(pokemon.url), headers: headers);
    if (res.statusCode != 200) {
      pokemon.setPokemonData(Map<String, dynamic>());
      return pokemon;
    }
    pokemon.setPokemonData(jsonDecode(res.body));
    return pokemon;
  }

  Future <Map<String, dynamic>> getEvoChain(String species) async {
    var res = await req.get(Uri.encodeFull(species), headers: headers);
    if (res.statusCode != 200) {
      return Map<String, dynamic>();
    }
    var chain = await req.get(jsonDecode(res.body)['evolution_chain']['url']);
    return jsonDecode(chain.body);
  }
}
