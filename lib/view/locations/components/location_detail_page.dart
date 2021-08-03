import 'package:flutter/material.dart';
import 'package:victor_flutter/helpers/colors.dart';
import 'package:victor_flutter/model/location_detail.dart';

class LocationDetailPage extends StatefulWidget {
  final LocationDetail locationDetail;
  const LocationDetailPage({Key key, this.locationDetail}) : super(key: key);

  @override
  _LocationDetailPageState createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        centerTitle: true,
        title: Text(
          "Detalhes",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
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
                          widget.locationDetail.name
                              .replaceAll("-", " ")
                              .toUpperCase(),
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
                    child: Stack(
                      children: [
                        if (widget.locationDetail.pokemonEncounters.length != 0)
                          Container(
                            height: 280,
                            child: ListView.builder(
                              itemCount: widget
                                  .locationDetail.pokemonEncounters.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                  child: Text(
                                    "${widget.locationDetail.pokemonEncounters[index].pokemon.name.replaceAll("-", " ").toUpperCase()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        if (widget.locationDetail.pokemonEncounters.length == 0)
                          Container(
                            height: 280,
                            child: Center(
                              child: Text(
                                "Nenhum",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 180,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.red.withOpacity(0.6),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Pokémons encontrados",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
