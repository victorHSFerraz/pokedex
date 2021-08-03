import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:victor_flutter/controller/location_controller.dart';
import 'package:victor_flutter/helpers/colors.dart';
import 'package:victor_flutter/view/locations/components/location_info_page.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final LocationController controller = Get.put(LocationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        itemCount: controller.location.results.length,
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
                    .getLocationInfo(controller.location.results[index].url)
                    .then(
                      (value) => {
                        if (value == true)
                          {
                            Navigator.pop(dialogContext),
                            Get.to(
                              () => LocationInfoPage(
                                locationInfo: controller.locationInfo,
                                controller: controller,
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
          "${controller.location.results[index].name}"
              .replaceAll("-", " ")
              .capitalize,
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
      key: _scaffoldKey,
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.secondary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Localizações",
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
      ),
      body: Stack(children: [
        Obx(
          () {
            var loading = controller.isLoadingRx.value;
            if (loading || controller.location.results == null) {
              return _buildSkeleton();
            } else {
              return _buildGrid();
            }
          },
        ),
        Obx(() {
          var loading = controller.isLoadingRx.value;
          if (loading || controller.location.results == null) {
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
                              .getLocations(controller.offsetRx.value - 200);
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
          if (loading || controller.location.results == null) {
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
            return controller.offsetRx.value < controller.location.count &&
                    !controller.isLoadingRx.value
                ? Positioned(
                    bottom: 15,
                    right: 5,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (controller.isLoadingRx.value == false &&
                            controller.offsetRx.value <
                                controller.location.count) {
                          controller.getLocations(controller.offsetRx.value);
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
      ]),
    );
  }
}
