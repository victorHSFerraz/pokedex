import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:victor_flutter/helpers/assets.dart';
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

  Color getTypeColor(String type) {
    if (type == "grass") {
      return Colors.green;
    } else if (type == "normal") {
      return Colors.grey;
    } else if (type == "fire") {
      return AppColors.red;
    } else if (type == "water") {
      return Colors.blueAccent;
    } else if (type == "electric") {
      return AppColors.yellow;
    } else if (type == "bug") {
      return Colors.lightGreen;
    } else if (type == "poison") {
      return Colors.deepPurpleAccent;
    } else if (type == "fighting") {
      return Colors.brown[400];
    } else if (type == "ghost") {
      return Colors.deepPurple[400];
    } else if (type == "rock") {
      return Colors.brown[100];
    } else {
      return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        centerTitle: true,
        title: Text(
          "Pokédex",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: getTypeColor(widget.pokemonDetail.types[0].type.name),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Container(
                      child: Text(
                        widget.pokemonDetail.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                    if (widget.pokemonDetail.sprites.other.officialArtwork
                            .frontDefault !=
                        null)
                      CachedNetworkImage(
                        imageUrl: widget.pokemonDetail.sprites.other
                            .officialArtwork.frontDefault,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          width: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Tooltip(
                              message: 'Erro ao carregar imagem',
                              child: Image.asset(
                                Assets.error,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (widget.pokemonDetail.sprites.frontDefault != null)
                      CachedNetworkImage(
                        imageUrl: widget.pokemonDetail.sprites.frontDefault,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          width: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Tooltip(
                              message: 'Erro ao carregar imagem',
                              child: Image.asset(
                                Assets.error,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (widget.pokemonDetail.sprites.backDefault != null)
                      CachedNetworkImage(
                        imageUrl: widget.pokemonDetail.sprites.backDefault,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          width: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Tooltip(
                              message: 'Erro ao carregar imagem',
                              child: Image.asset(
                                Assets.error,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (widget.pokemonDetail.sprites.frontShiny != null)
                      CachedNetworkImage(
                        imageUrl: widget.pokemonDetail.sprites.frontShiny,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          width: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Tooltip(
                              message: 'Erro ao carregar imagem',
                              child: Image.asset(
                                Assets.error,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (widget.pokemonDetail.sprites.backShiny != null)
                      CachedNetworkImage(
                        imageUrl: widget.pokemonDetail.sprites.backShiny,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          width: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Tooltip(
                              message: 'Erro ao carregar imagem',
                              child: Image.asset(
                                Assets.error,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                      height: 280,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (widget.pokemonDetail.types.length == 1)
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: getTypeColor(widget
                                        .pokemonDetail.types[0].type.name),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "${widget.pokemonDetail.types[0].type.name.capitalize}",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              if (widget.pokemonDetail.types.length > 1)
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: getTypeColor(widget
                                        .pokemonDetail.types[0].type.name),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "${widget.pokemonDetail.types[0].type.name.capitalize}",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              if (widget.pokemonDetail.types.length > 1)
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: getTypeColor(widget
                                        .pokemonDetail.types[1].type.name),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "${widget.pokemonDetail.types[1].type.name.capitalize}",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                          color: getTypeColor(
                              widget.pokemonDetail.types[0].type.name),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Estatísticas base",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 280,
                      child: Scrollbar(
                        thickness: 10,
                        child: ListView.builder(
                          itemCount: widget.pokemonDetail.gameIndices.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                              child: Text(
                                "Pokémon: ${widget.pokemonDetail.gameIndices[index].version.name.capitalize}",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                          color: getTypeColor(
                              widget.pokemonDetail.types[0].type.name),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Aparições nos Games",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
