import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rutgers_flutter_mapbox_app/my_map/my_map_cubit.dart';

import '../keys.dart';

class MyMapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMapViewState();
}

typedef SymbolCallback = void Function(Symbol);

class MyMapViewState extends State<MyMapView> {
  MapboxMapController controller;
  bool hasSetRoutes = false;
  SymbolCallback onSymbolTapped = null;

  @override
  void initState() {
    super.initState();
    onSymbolTapped = (Symbol argument) async {
      final latLng = await controller.getSymbolLatLng(argument);
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(latLng.toString())),
      );
    };
  }

  @override
  void dispose() {
    // TODO: Unregister onSymbolTapped callback
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: ACCESS_TOKEN,
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: LatLng(38.92, -75.56),
            northeast: LatLng(41.36, -73.79),
          ),
        ),
        initialCameraPosition: CameraPosition(
          target: LatLng(40.5218723486, -74.4624206535),
          zoom: 11,
        ),
        minMaxZoomPreference: MinMaxZoomPreference(1, 20),
        myLocationEnabled: true,
        myLocationRenderMode: MyLocationRenderMode.NORMAL,
        myLocationTrackingMode: MyLocationTrackingMode.Tracking,
        rotateGesturesEnabled: false,
        // trackCameraPosition is needed for [MyMapState#controller#requestMyLocationLatLng] to return current data
        trackCameraPosition: true,
        onMapCreated: (MapboxMapController controller) {
          this.controller = controller;
          controller.onSymbolTapped.add(onSymbolTapped);
          if (!hasSetRoutes) {
            () async {
              final routesFromJson = (await rootBundle
                  .loadStructuredData<dynamic>("assets/transloc.json",
                      (value) async {
                return json.decode(value);
              })) as List;

              context.bloc<MyMapCubit>().setRoutes(routesFromJson);
              setState(() => hasSetRoutes = true);
            }();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: () async {
          if (controller == null) return;
          // final myLatLng = await controller.requestMyLocationLatLng();
          //
          // final newZoomLevel = min(
          //   max(14, controller.cameraPosition.zoom + 1),
          //   18,
          // ).toDouble();
          // controller.animateCamera(CameraUpdate.newLatLngZoom(
          //   myLatLng,
          //   newZoomLevel,
          // ));

          final routes = context.bloc<MyMapCubit>().getRoutes();

          routes.forEach((dynamic route) {
            (route["stops"] as List).forEach((dynamic stop) {
              controller.addSymbol(
                SymbolOptions(
                  iconSize: 2,
                  // "custom-icon.png" in Mapbox example app
                  iconImage: "assets/stop_icon.png",
                  geometry: LatLng(
                    stop["location"]["lat"] as double,
                    stop["location"]["lng"] as double,
                  ),
                ),
              );
            });
            (route["vehicles"] as List).forEach((dynamic vehicle) {
              controller.addSymbol(
                SymbolOptions(
                  iconSize: 1,
                  // iconColor: "#${route["color"]}",
                  iconRotate: (vehicle["heading"] as int).toDouble(),
                  // Modified version of https://materialdesignicons.com/icon/arrow-up
                  iconImage: "assets/vehicle_icon.png",
                  geometry: LatLng(
                    vehicle["location"]["lat"] as double,
                    vehicle["location"]["lng"] as double,
                  ),
                ),
              );
            });
          });
        },
      ),
    );
  }
}
