import '../http/requestor.dart';

class Pokemon {
  static var pok = Requestor();
  String name;
  String url;
  Map<String, dynamic> data = Map();

  Pokemon(this.name, this.url);

  @override
  String toString() {
    return 'Este es $name con url: $url';
  }
}
