import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:victor_flutter/controller/location_controller.dart';
import 'package:victor_flutter/helpers/colors.dart';
import 'package:victor_flutter/model/location_info.dart';
import 'package:victor_flutter/view/locations/components/location_detail_page.dart';

class LocationInfoPage extends StatefulWidget {
  final LocationInfo locationInfo;
  final LocationController controller;
  const LocationInfoPage({Key key, this.locationInfo, this.controller})
      : super(key: key);

  @override
  _LocationInfoPageState createState() => _LocationInfoPageState();
}

class _LocationInfoPageState extends State<LocationInfoPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        centerTitle: true,
        title: Text(
          "Informações",
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
                          widget.locationInfo.name
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
                      if (widget.locationInfo.areas.length != 0)
                        Container(
                          height: 280,
                          child: ListView.builder(
                            itemCount: widget.locationInfo.areas.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                                child: InkWell(
                                  onTap: () async {
                                    BuildContext dialogContext;
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) {
                                          dialogContext = context;
                                          return showLoading();
                                        });
                                    await widget.controller
                                        .getLocationDetail(widget
                                            .locationInfo.areas[index].url)
                                        .then(
                                          (value) => {
                                            if (value == true)
                                              {
                                                Navigator.pop(dialogContext),
                                                Get.to(
                                                  () => LocationDetailPage(
                                                    locationDetail: widget
                                                        .controller
                                                        .locationDetail,
                                                  ),
                                                )
                                              }
                                            else
                                              {Navigator.pop(dialogContext)},
                                          },
                                        );
                                  },
                                  child: Text(
                                    "${widget.locationInfo.areas[index].name.replaceAll("-", " ").toUpperCase()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (widget.locationInfo.areas.length == 0)
                        Container(
                          height: 280,
                          child: Center(
                            child: Text(
                              "Nenhuma",
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
                            color: AppColors.cream.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Áreas",
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
