import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:intern_task/core/state_management/base_notifier.dart';

import '../../product/models/studio_model.dart';
import '../../utils/popup_helper.dart';

class StudioListViewModel extends BaseNotifier {
  final List<StudioModel> _studioList = [];
  List<StudioModel> get filteredStudioList {
    return _studioList;
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
    } catch (e) {
      PopupHelper.showErrorPopup(
          "Error while fetching studio list", e.toString());
    } finally {
      isLoading = false;
    }
  }
}
