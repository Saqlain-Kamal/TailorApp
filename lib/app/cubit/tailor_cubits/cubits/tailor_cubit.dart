import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/tailor_cubits/states/tailor_states.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/tailor_repo.dart';

class TailorController extends ChangeNotifier {
  final db = TailorRepo();
  List<UserModel> tailorList = [];
  bool isloading = false;
  Future<List<UserModel>> getTailors() async {
    try {
      // emit(TailorLoadingState());
      isloading = true;
      notifyListeners();
      tailorList = await db.getTailors();
      log(tailorList.length.toString());
      // emit(TailorLoadedState(tailors: tailorList));

      isloading = false;
      notifyListeners();
      //categories.sort();

      return tailorList;
    } on FirebaseException catch (e) {
      isloading = false;
      notifyListeners();
      // emit(TailorErrorState(message: e.message));
      rethrow;
    }
  }
}
