import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_states.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/repo/measurment_repo.dart';

class MeasurmentController extends ChangeNotifier {
  final db = MeasurmentRepo();
  List<MeasurmentModel> measurementsList = [];
  bool isloading = false;

  Future<void> addMeasurement({required MeasurmentModel measurement}) async {
    try {
      // emit(LoadingStates());
      isloading = true;
      notifyListeners();
      await db.addMeasurments(measurement: measurement);
      await getMeasurments(uid: measurement.uid);
      isloading = false;
      notifyListeners();
      // emit(MeasurementUploadedState());
    } catch (e) {
      isloading = false;
      notifyListeners();
      // emit(
      //   ErrorState(
      //     message: e.toString(),
      //   ),
      // );
      rethrow;
    }
  }

  Future<List<MeasurmentModel>> getMeasurments({required String uid}) async {
    try {
      measurementsList = await db.getMeasurments(uid: uid);
      log('Measurements are ${measurementsList.length.toString()}');
      // categories = getUniqueCategories(productList);
      //categories.sort();
      // log(categories.toString());
      // emit(MeasurementUploadedState());
      notifyListeners();
      return measurementsList;
    } catch (e) {
      // emit(
      //   ErrorState(
      //     message: e.toString(),
      //   ),
      // );
      rethrow;
    }
  }
}
