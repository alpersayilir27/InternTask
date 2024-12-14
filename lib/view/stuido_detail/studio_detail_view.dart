import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/product/models/studio_model.dart';
import 'package:intern_task/view/stuido_detail/studio_detail_viewmodel.dart';

import '../studio_list/studio_list_viewmodel.dart';

class StudioDetailView extends ConsumerStatefulWidget {
  final StudioModel studioHeaderModel;
  const StudioDetailView({super.key, required this.studioHeaderModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StudioDetailViewState();
}

class _StudioDetailViewState extends ConsumerState<StudioDetailView> {
  ChangeNotifierProvider<StudioDetailViewModel> provider =
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
  void dispose() {
    super.dispose();
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

  // Widget _body() {}
  // Widget _imageStack() {}
  // Widget _header() {}
  // Widget _description() {}
}
