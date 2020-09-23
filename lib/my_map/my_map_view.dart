import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rutgers_flutter_mapbox_app/my_map/map_cubit.dart';

import '../keys.dart';

class MyMapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMapViewState();
}

class MyMapViewState extends State<MyMapView> {
  MapboxMapController controller;
  bool hasSetRoutes = false;

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
          if (!hasSetRoutes) {
            () async {
              hasSetRoutes = true;
              final routesFromJson = (await rootBundle
                  .loadStructuredData<dynamic>("assets/transloc.json",
                      (value) async {
                return json.decode(value);
                // final i = jsonDecode(value) as Iterable<dynamic>;
                // final result = i
                //     .map((dynamic orig) =>
                //         Route.fromJson(orig as Map<String, dynamic>))
                //     .toList();
                // print("");
                // return result;
              })) as List;
              context.bloc<MapCubit>().setRoutes(routesFromJson);
            }();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (controller == null) return;
          final myLatLng = await controller.requestMyLocationLatLng();

          final newZoomLevel = min(
            max(14, controller.cameraPosition.zoom + 1),
            18,
          ).toDouble();
          controller.animateCamera(CameraUpdate.newLatLngZoom(
            myLatLng,
            newZoomLevel,
          ));
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
