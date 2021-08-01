import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:victor_flutter/controller/home_controller.dart';
import 'package:victor_flutter/helpers/assets.dart';
import 'package:victor_flutter/helpers/colors.dart';
import 'package:victor_flutter/view/home/components/pokemon_detail_page.dart';

import 'components/arrow_clipper.dart';
import 'components/pop_menu_itens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  showLoading() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('Aguarde...'),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: index % 2 == 0
                ? EdgeInsets.only(left: 14.0, right: 10, top: 10)
                : EdgeInsets.only(right: 14.0, left: 10, top: 10),
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                borderRadius: BorderRadius.circular(3),
                width: 200,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
        ),
        itemCount: controller.pokemon.results.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index % 2 == 0
                ? EdgeInsets.only(left: 14.0, right: 10)
                : EdgeInsets.only(right: 14.0, left: 10),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              splashFactory: InkRipple.splashFactory,
              splashColor: AppColors.secondary,
              onTap: () async {
                BuildContext dialogContext;
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      dialogContext = context;
                      return showLoading();
                    });
                await controller
                    .getPokemonDetail(controller.pokemon.results[index].url)
                    .then(
                      (value) => {
                        if (value == true)
                          {
                            Navigator.pop(dialogContext),
                            Get.to(
                              () => PokemonDetailPage(
                                pokemonDetail: controller.pokemonDetail,
                              ),
                            )
                          }
                        else
                          {Navigator.pop(dialogContext)},
                      },
                    );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                color: Colors.white,
                child: Container(
                  child: cardItens(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  cardItens(int index) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          "${controller.pokemon.results[index].name}".capitalize,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      key: _scaffoldKey,
      body: Stack(
        children: [
          NestedScrollView(
            controller: ScrollController(initialScrollOffset: 40.0 - 140.0),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 20,
                  forceElevated: true,
                  backgroundColor: AppColors.primary,
                  expandedHeight: 140.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    var height = constraints.biggest.height;
                    return height > 90
                        ? FlexibleSpaceBar(
                            centerTitle: false,
                            title: Row(
                              children: [
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    text: "POKÉMONS - API",
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "\nby Victor Ferraz",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                PopupMenuButton(
                                  enableFeedback: true,
                                  shape: TooltipShape(),
                                  offset: Offset(-10, 42),
                                  itemBuilder: (BuildContext context) {
                                    return PopMenuItens.choices
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 15, left: 15),
                                          child: Row(
                                            children: [
                                              if (PopMenuItens.FirstItem ==
                                                  choice)
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  color: AppColors.secondary,
                                                  elevation: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(
                                                      Icons.account_circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              if (PopMenuItens.SecondItem ==
                                                  choice)
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  color: AppColors.secondary,
                                                  elevation: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(
                                                      Icons.settings,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              if (PopMenuItens.ThirdItem ==
                                                  choice)
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  color: AppColors.secondary,
                                                  elevation: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(
                                                      Icons.logout,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(width: 10),
                                              Text(
                                                choice,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  child: Container(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: AppColors.red,
                                      child: Image.asset(
                                        Assets.pokeball,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            background: Material(
                              color: AppColors.primary,
                            ),
                          )
                        : FlexibleSpaceBar(
                            centerTitle: false,
                            title: Text(
                              "Pokémons",
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            background: Material(
                              color: AppColors.secondary,
                            ),
                          );
                  }),
                ),
              ];
            },
            body: Obx(
              () {
                var loading = controller.isLoadingRx.value;
                if (loading || controller.pokemon == null) {
                  return _buildSkeleton();
                } else {
                  return _buildGrid();
                }
              },
            ),
          ),
          Obx(() {
            var loading = controller.isLoadingRx.value;
            if (loading) {
              return Positioned(
                bottom: 15,
                left: 5,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_left,
                    size: 40,
                  ),
                ),
              );
            } else {
              return controller.offsetRx.value != 100
                  ? Positioned(
                      bottom: 15,
                      left: 5,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (controller.isLoadingRx.value == false &&
                              controller.offsetRx.value != 100) {
                            controller
                                .getPokemons(controller.offsetRx.value - 200);
                            controller.offset = controller.offsetRx.value - 200;
                          }
                        },
                        child: Icon(
                          Icons.arrow_left,
                          size: 40,
                        ),
                      ),
                    )
                  : Container();
            }
          }),
          Obx(() {
            var loading = controller.isLoadingRx.value;
            if (loading) {
              return Positioned(
                bottom: 15,
                right: 5,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_right,
                    size: 40,
                  ),
                ),
              );
            } else {
              return controller.offsetRx.value < controller.pokemon.count &&
                      !controller.isLoadingRx.value
                  ? Positioned(
                      bottom: 15,
                      right: 5,
                      child: FloatingActionButton(
                        onPressed: () {
                          if (controller.isLoadingRx.value == false &&
                              controller.offsetRx.value <
                                  controller.pokemon.count) {
                            controller.getPokemons(controller.offsetRx.value);
                          }
                        },
                        child: Icon(
                          Icons.arrow_right,
                          size: 40,
                        ),
                      ),
                    )
                  : Container();
            }
          }),
        ],
      ),
    );
  }
}
