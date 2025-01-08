import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_app/app/model/measurment_model.dart';

class MeasurmentRepo {
  Future<void> addMeasurments({required MeasurmentModel measurement}) async {
    try {
      print('1');
      final newDoc = FirebaseFirestore.instance
          .collection('measurments')
          .doc(measurement.uid)
          .collection('measurement')
          .doc();
      // address.docId = newDoc.id;
      newDoc.set(measurement.toJson());
      print('2');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MeasurmentModel>> getMeasurments({required String uid}) async {
    try {
      final addressRef = FirebaseFirestore.instance
          .collection('measurments')
          .doc(uid)
          .collection('measurement');
      final querySnapshot = await addressRef.get();

      final measurments = querySnapshot.docs
          .map((doc) => MeasurmentModel.fromJson(doc.data()))
          .toList();
      log(measurments.length.toString());

      return measurments;
    } on FirebaseException catch (e) {
      // Handle Firebase errors appropriately (e.g., logging, user notifications)
      rethrow;
    }
  }
}
