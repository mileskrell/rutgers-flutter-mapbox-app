import 'package:bloc/bloc.dart';

class MyMapCubit extends Cubit<List<dynamic>> {
  MyMapCubit() : super(<dynamic>[]);

  void setRoutes(List<dynamic> newRoutes) => emit(newRoutes);

  List<dynamic> getRoutes() => state;
}
