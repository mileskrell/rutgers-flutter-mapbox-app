import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../keys.dart';

class MyMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  MapboxMapController controller;

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
        trackCameraPosition: true,
        onMapCreated: (MapboxMapController controller) {
          this.controller = controller;
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
