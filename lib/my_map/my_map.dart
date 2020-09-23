import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_map_view.dart';
import 'my_map_cubit.dart';

class MyMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyMapCubit(),
      child: MyMapView(),
    );
  }
}
