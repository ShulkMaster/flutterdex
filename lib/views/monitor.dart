import 'package:flutter/material.dart';
import '../http/requestor.dart';
import '../templates/Pokemon.dart';
import '../views/PokemonCard.dart';

class Monitor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MonitorState();
  }
}

class _MonitorState extends State<Monitor> {
  var _http = Requestor();
  List<Pokemon> _data = [];
  bool _loadingPokemon = false;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      double max = _controller.position.maxScrollExtent;
      double cScroll = _controller.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (max - cScroll <= delta) {
        loadData();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: _data == null ? 0 : _data.length,
          itemBuilder: (BuildContext ctx, int index) {
            return PokemonCard(_data[index]);
          },
          controller: _controller,
        ))
      ],
    );
  }

  void loadData() async {
    if(_loadingPokemon) return;
    _loadingPokemon = true;
    var res = await _http.getPokemons(_data == null ? 0 : _data.length);
    List<Pokemon> listRes = res['results'].map<Pokemon>((e) {
      return Pokemon(e['name'], e['url']);
    }).toList();
    setState(() {
      _data.addAll(listRes);
    });
    _loadingPokemon = false;

  }
}
