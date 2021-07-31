import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                  color: AppColors.red,
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                height: 500,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Container()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
