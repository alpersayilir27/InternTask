import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:intern_task/core/state_management/base_notifier.dart';
import 'package:intern_task/product/models/reservation_model.dart';
import 'package:intern_task/utils/popup_helper.dart';

import '../../product/models/studio_model.dart';

class StudioDetailViewModel extends BaseNotifier {
  String selectedDay = "";

  final StudioModel studioModel;
  StudioDetailViewModel(this.studioModel);

  Future<void> reserve() async {
    try {
      isLoading = true;
      final doc = FirebaseFirestore.instance.collection('reservations').doc();

      ReservationModel reservationModel = ReservationModel(
        studioName: studioModel.name,
        uid: doc.id,
        day: selectedDay,
      );
      await doc.set(reservationModel.toJson());
      PopupHelper.showSuccessPopup("Reservation saved successfully");
    } catch (e) {
      PopupHelper.showErrorPopup(
          "Error while saving reservation", e.toString());
    } finally {
      isLoading = false;
    }
  }
}
