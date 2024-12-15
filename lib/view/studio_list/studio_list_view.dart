import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/view/studio_list/studio_list_viewmodel.dart';
import 'package:intern_task/view/stuido_detail/studio_detail_view.dart';

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
    log("initializing studio list view");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(provider).fetchStudioList();
    });
    super.initState();
  }

  @override
  void dispose() {
    log("disposing studio list view");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var filteredStudioList = ref.read(provider).filteredStudioList;
    if (ref.watch(provider).isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
        child: Column(
      children: [
        _searchBar(),
        ListView.separated(
          shrinkWrap: true,
          itemCount: filteredStudioList.length,
          itemBuilder: (context, index) {
            var studioModel = filteredStudioList[index];
            return _studioCard(studioModel);
          },
          separatorBuilder: (context, index) => const Divider(),
        )
      ],
    ));
  }

  Widget _studioCard(StudioModel studioModel) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StudioDetailView(studioModel: studioModel)));
      },
      child: Container(
        // make some fancy decoration
        child: ListTile(
          title: Text(studioModel.name),
          subtitle: Text(studioModel.description),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      onChanged: (value) {
        ref.read(provider).search(value);
      },
      decoration: const InputDecoration(
        hintText: "Search Studio",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
