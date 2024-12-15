import 'dart:developer';

import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:intern_task/core/state_management/base_notifier.dart';

import '../../product/models/studio_model.dart';
import '../../utils/popup_helper.dart';

class StudioListViewModel extends BaseNotifier {
  final List<StudioModel> _studioList = [];
  List<StudioModel> filteredStudioList = [];

  void search(String value) {
    filteredStudioList = _studioList.where((element) {
      bool nameContains = element.name.toLowerCase().contains(value);
      bool descriptionContains =
          element.description.toLowerCase().contains(value);
      String danceStyles = element.danceStyles.join(" ").toLowerCase();
      bool danceStylesContains = danceStyles.contains(value);
      return nameContains || descriptionContains || danceStylesContains;
    }).toList();
    notifyListeners();
  }

  Future<void> fetchStudioList() async {
    isLoading = true;
    try {
      final response =
          await FirebaseFirestore.instance.collection('studios').get();
      _studioList.clear();
      for (var element in response.docs) {
        _studioList.add(StudioModel.fromJson(element.data(), element.id));
      }
      filteredStudioList.clear();
      filteredStudioList.addAll(_studioList);
      log("filled studio list, count: ${_studioList.length}");
      notifyListeners();
    } catch (e) {
      PopupHelper.showErrorPopup(
          "Error while fetching studio list", e.toString());
    } finally {
      isLoading = false;
    }
  }
}
