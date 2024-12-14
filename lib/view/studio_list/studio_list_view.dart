import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/view/studio_list/studio_list_viewmodel.dart';

import '../../product/models/studio_model.dart';

class StudioListView extends ConsumerStatefulWidget {
  const StudioListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudioListViewState();
}

class _StudioListViewState extends ConsumerState<StudioListView> {
  ChangeNotifierProvider<StudioListViewModel> provider =
      ChangeNotifierProvider<StudioListViewModel>(
          (ref) => StudioListViewModel());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(provider).fetchStudioList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filteredStudioList = ref.read(provider).filteredStudioList;
    return Container(
        child: ListView.separated(
      itemCount: filteredStudioList.length,
      itemBuilder: (context, index) {
        var studioModel = filteredStudioList[index];
        return _studioCard(studioModel);
      },
      separatorBuilder: (context, index) => const Divider(),
    ));
  }

  Widget _studioCard(StudioModel studioModel) {
    return Container(
      // make some fancy decoration
      child: ListTile(
        title: Text(studioModel.name),
        subtitle: Text(studioModel.description),
      ),
    );
  }
}
