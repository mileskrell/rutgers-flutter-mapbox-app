import 'package:bloc/bloc.dart';

class MapCubit extends Cubit<List<dynamic>> {
  MapCubit() : super(<dynamic>[]);

  void setRoutes(List<dynamic> newRoutes) => emit(newRoutes);
}
