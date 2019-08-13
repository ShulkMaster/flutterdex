import 'package:floaps/views/details/PokemonDetails.dart';
import 'package:flutter/material.dart';
import 'package:floaps/templates/Pokemon.dart';
import 'package:floaps/http/requestor.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon _pokemon;
  static final Requestor req = Requestor();

  PokemonCard(this._pokemon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDetails(context, this._pokemon);
      },
      child: Card(
        elevation: 5,
        color: Colors.blueGrey,
        child: pokeImg(),
      ),
    );
  }

  void _showDetails(BuildContext context, Pokemon pokemon) {
    if (pokemon.data == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return PokemonDetails(pokemon);
    }));
  }

  Widget pokeImg() {
    return FutureBuilder<Pokemon>(
      future: req.getPokemonData(_pokemon),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Loading...');
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container(
              height: 100.0,
              width: 100.0,
              child: Center(child: CircularProgressIndicator()),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return ListTile(
              title: Text(
                _pokemon.name,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "ID: ${_pokemon.id}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              leading: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_pokemon.sprites['front_default']),
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  print('hola');
                },
                icon: Icon(
                  Icons.star_border,
                  size: 50,
                  color: Colors.yellow,
                ),
              ),
              contentPadding: EdgeInsets.all(20.0),
            );
          default:
            return Text('Error');
        }
      },
    );
  }
}
