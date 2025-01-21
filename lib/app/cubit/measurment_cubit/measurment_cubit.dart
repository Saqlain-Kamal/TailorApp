import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_states.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/repo/measurment_repo.dart';

class MeasurmentCubit extends Cubit<MeasurmentStates> {
  MeasurmentCubit() : super(InitialStates());

  final db = MeasurmentRepo();
  List<MeasurmentModel> measurementsList = [];

  Future<void> addMeasurement({required MeasurmentModel measurement}) async {
    try {
      emit(LoadingStates());
      await db.addMeasurments(measurement: measurement);
      emit(MeasurementUploadedState());
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<List<MeasurmentModel>> getMeasurments({required String uid}) async {
    try {
      measurementsList = await db.getMeasurments(uid: uid);
      log('Measurements are ${measurementsList.length.toString()}');
      // categories = getUniqueCategories(productList);
      //categories.sort();
      // log(categories.toString());
      emit(MeasurementUploadedState());
      return measurementsList;
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
      rethrow;
    }
  }
}
