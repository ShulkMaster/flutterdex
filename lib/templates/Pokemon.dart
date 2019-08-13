class Pokemon {

  String name;
  String url;
  String areaEncounters;
  int id;
  int baseXp;
  int height;
  int weight;
  int order;
  bool isDefault;
  List<dynamic> stats;
  Map<String, dynamic> sprites;
  Map<String, dynamic> data;

  Pokemon(this.name, this.url);

  @override
  String toString() {
    return 'Este es $name con url: $url';
  }

  void setPokemonData(Map<String, dynamic> source){
    data = source;
    stats = data['stats'];
    sprites = data['sprites'];
    id = data['id'];
    height = data['height'];
    weight = data['weight'];
    order = data['order'];
    isDefault = data['is_default'];
    baseXp = data['base_experience'];
    areaEncounters = data['location_area_encounters'];
  }
}
