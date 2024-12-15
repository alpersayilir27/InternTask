import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intern_task/core/state_management/base_notifier.dart';
import 'package:intern_task/product/constants/app_constants.dart';
import 'package:intern_task/view/stuido_detail/studio_detail_view.dart';

import '../../product/models/studio_model.dart';
import '../../utils/popup_helper.dart';

class StudioMapViewModel extends BaseNotifier {
  List<StudioModel> studioList = [];
  List<Marker> markers = [];
  // info windows

  Future<void> fetchStudioList() async {
    isLoading = true;
    try {
      final response =
          await FirebaseFirestore.instance.collection('studios').get();
      studioList.clear();
      for (var element in response.docs) {
        var studio = StudioModel.fromJson(element.data(), element.id);
        studioList.add(studio);
        markers.add(Marker(
          markerId: MarkerId(studio.uid),
          position: LatLng(studio.lat, studio.long),
          infoWindow: InfoWindow(
            title: studio.name,
            snippet: studio.description,
            onTap: () {
              Navigator.push(
                  AppConstants.context,
                  MaterialPageRoute(
                    builder: (context) => StudioDetailView(studioModel: studio),
                  ));
            },
          ),
          onTap: () => Navigator.push(
            AppConstants.context,
            MaterialPageRoute(
              builder: (context) => StudioDetailView(studioModel: studio),
            ),
          ),
        ));
      }

      notifyListeners();
    } catch (e) {
      PopupHelper.showErrorPopup(
          "Error while fetching studio list", e.toString());
    } finally {
      isLoading = false;
    }
  }
}
