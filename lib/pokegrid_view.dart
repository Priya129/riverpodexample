import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'model.dart';

class PokemonGridView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemon = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('PokeApi using Riverpod'),
      ),
      body: asyncPokemon.when(
        data: (pokemons) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(pokemon.imageUrl),
                    SizedBox(height: 10),
                    Text(pokemon.name),
                  ],
                ),
              );
            },
          ),
        ),
        loading: () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          itemCount: 8, // Showing shimmer for 8 items
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 60,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
