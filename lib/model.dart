import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class Pokemon {
  final String name;
  final String imageUrl;

  Pokemon({required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}

final pokemonProvider = FutureProvider<List<Pokemon>>((ref) async {
  final response = await Dio().get('https://pokeapi.co/api/v2/pokemon?limit=20');
  final List results = response.data['results'];
  List<Pokemon> pokemons = [];
  for (var result in results) {
    final detailResponse = await Dio().get(result['url']);
    pokemons.add(Pokemon.fromJson(detailResponse.data));
  }
  return pokemons;
});
