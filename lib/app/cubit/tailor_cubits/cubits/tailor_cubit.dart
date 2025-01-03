import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/tailor_cubits/states/tailor_states.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/tailor_repo.dart';

class TailorCubit extends Cubit<TailorStates> {
  TailorCubit() : super(TailorInitialState());
  final db = TailorRepo();
  List<UserModel> tailorList = [];
  Future<List<UserModel>> getTailors() async {
    try {
      emit(TailorLoadingState());
      tailorList = await db.getTailors();
      log(tailorList.length.toString());
      emit(TailorLoadedState(tailors: tailorList));

      //categories.sort();

      return tailorList;
    } on FirebaseException catch (e) {
      emit(TailorErrorState(message: e.message));
      rethrow;
    }
  }
}
