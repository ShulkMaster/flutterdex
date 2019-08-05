import 'package:floaps/views/PokemonDetails.dart';
import 'package:flutter/material.dart';
import '../templates/Pokemon.dart';
import '../http/requestor.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon _pokemon;
  static final Requestor req = Requestor();

  PokemonCard(this._pokemon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _showDetails(context, this._pokemon);
      },
      child: Card(
        elevation: 5,
        color: Colors.red[400],
        child: Container(
          height: 100.0,
          width: 50.0,
          child: Row(
            children: <Widget>[
              FutureBuilder<Map<String, dynamic>>(
                future: req.getPokemonData(_pokemon.url),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Loading');
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      _pokemon.data = snapshot.data;
                      return Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    _pokemon
                                        .data['sprites']['front_default']))),
                      );
                  }
                  return Text('Null');
                },
              ),
              Text(
                _pokemon.name,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, Pokemon pokemon) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return PokemonDetails(pokemon);
    }));
  }
}
