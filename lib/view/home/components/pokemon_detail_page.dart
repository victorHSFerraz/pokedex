import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:victor_flutter/helpers/colors.dart';
import 'package:victor_flutter/model/pokemon_detail.dart';

class PokemonDetailPage extends StatefulWidget {
  final PokemonDetail pokemonDetail;
  const PokemonDetailPage({Key key, this.pokemonDetail}) : super(key: key);

  @override
  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  List images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text(
          widget.pokemonDetail.name.capitalize,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              width: double.infinity,
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (widget.pokemonDetail.sprites.frontDefault != null)
                    Image.network(
                      widget.pokemonDetail.sprites.frontDefault,
                      fit: BoxFit.fill,
                    ),
                  if (widget.pokemonDetail.sprites.backDefault != null)
                    Image.network(
                      widget.pokemonDetail.sprites.backDefault,
                      fit: BoxFit.fill,
                    ),
                  if (widget.pokemonDetail.sprites.frontShiny != null)
                    Image.network(
                      widget.pokemonDetail.sprites.frontShiny,
                      fit: BoxFit.fill,
                    ),
                  if (widget.pokemonDetail.sprites.backShiny != null)
                    Image.network(
                      widget.pokemonDetail.sprites.backShiny,
                      fit: BoxFit.fill,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
