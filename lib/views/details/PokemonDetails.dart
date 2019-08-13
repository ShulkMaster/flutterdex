import 'package:flutter/material.dart';
import '../../templates/Pokemon.dart';
import '../../http/requestor.dart';
import 'infoBody.dart';


class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetails(this.pokemon);

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  int _navigationIndex = 0;
  final _http = Requestor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: buildBody(context, _navigationIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (int index) {
          setState(() {
            _navigationIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('Info'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            title: Text('Evolutions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
            ),
            title: Text('Location'),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext ctx, int navigationIndex) {
    switch (navigationIndex) {
      case 0:
        return InfoBody(widget.pokemon);
      case 1:
        return buildEvoScreen(ctx);
      default:
        return Text('Error');
    }
  }


  Widget buildEvoScreen(BuildContext ctx) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _http.getEvoChain(widget.pokemon.data['species']['url']),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget body = Text('Error');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              body = Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              body = stacks(snapshot);
              break;
          }
          return body;
        });
  }

  Widget stacks(AsyncSnapshot snapshot) {
    return Text(snapshot.data.toString());
  }
}


