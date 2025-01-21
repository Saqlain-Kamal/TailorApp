import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/location_cubit/location_states.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(InitialStates());
}
