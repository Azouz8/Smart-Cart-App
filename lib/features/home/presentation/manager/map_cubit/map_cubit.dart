import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
}
