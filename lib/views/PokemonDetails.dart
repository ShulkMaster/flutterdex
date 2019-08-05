import 'package:flutter/material.dart';
import '../templates/Pokemon.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetails(this.pokemon);

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  int _current = 0;
  int _navigationIndex = 0;
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
      body: buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (int index){
          setState(() {
            _navigationIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description
            ),
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

  Widget buildBody(BuildContext ctx) {
    List<Widget> images = [];
    List<Widget> dots = [];
    Map<dynamic, dynamic> sprites = widget.pokemon.data['sprites'];
    sprites.forEach((key, value) {
      if (value != null) {
        images.add(Card(
          child: Image.network(value),
        ));
      }
    });
    for (int i = 0; i < images.length; i++) {
      dots.add(Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == i
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.4)),
      ));
    }
    return ListView(
      children: <Widget>[
        CarouselSlider(
          enableInfiniteScroll: true,
          reverse: false,
          height: MediaQuery.of(ctx).size.height * 0.3,
          viewportFraction: 0.3,
          items: images,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
          enlargeCenterPage: true,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: dots),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
              title: Text('Name'),
              subtitle: Text(
                widget.pokemon.name,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
