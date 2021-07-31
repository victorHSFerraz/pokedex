import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:victor_flutter/controller/home_controller.dart';
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

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
        ),
        itemCount: 6,
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
                await controller
                    .getPokemonDetail(controller.pokemon.results[index].url)
                    .then(
                      (value) => {
                        if (value == true)
                          {
                            Get.to(
                              () => PokemonDetailPage(
                                pokemonDetail: controller.pokemonDetail,
                              ),
                            )
                          },
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
      body: NestedScrollView(
        controller: ScrollController(initialScrollOffset: 40.0 - 140.0),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 20,
              forceElevated: true,
              backgroundColor: AppColors.primary,
              expandedHeight: 140.0,
              floating: false,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
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
                                    text: "\nVictor Henrique",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            PopupMenuButton(
                              enableFeedback: true,
                              shape: TooltipShape(),
                              offset: Offset(-5, 31),
                              itemBuilder: (BuildContext context) {
                                return PopMenuItens.choices
                                    .map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 15, left: 15),
                                      child: Row(
                                        children: [
                                          if (PopMenuItens.FirstItem == choice)
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              color: AppColors.secondary,
                                              elevation: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.account_circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          if (PopMenuItens.SecondItem == choice)
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              color: AppColors.secondary,
                                              elevation: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.settings,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          if (PopMenuItens.ThirdItem == choice)
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              color: AppColors.secondary,
                                              elevation: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
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
                                  radius: 19,
                                  backgroundColor: AppColors.red,
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 38,
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
                          "Home",
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
    );
  }
}