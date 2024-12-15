import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:intern_task/core/state_management/base_notifier.dart';
import 'package:intern_task/product/models/reservation_model.dart';
import 'package:intern_task/utils/popup_helper.dart';

class ReservationListViewModel extends BaseNotifier {
  List<ReservationModel> reservationList = [];

  Future<void> fetchReservations() async {
    try {
      isLoading = true;
      var reservationListQuery =
          await FirebaseFirestore.instance.collection("reservations").get();
      reservationList = reservationListQuery.docs
          .map((e) => ReservationModel.fromJson(e.data(), e.id))
          .toList();
    } catch (e) {
      PopupHelper.showErrorPopup(
          "Error while fetching reservations! Try again", e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteReservation(int index) async {
    try {
      isLoading = true;
      await FirebaseFirestore.instance
          .collection("reservations")
          .doc(reservationList[index].uid)
          .delete();
      reservationList.removeAt(index);
      PopupHelper.showSuccessPopup("Reservation deleted successfully");
    } catch (e) {
      PopupHelper.showErrorPopup(
          "Error while deleting reservation! Try again", e.toString());
    } finally {
      isLoading = false;
    }
  }
}
