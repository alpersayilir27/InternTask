import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/product/models/studio_model.dart';
import 'package:intern_task/view/stuido_detail/studio_detail_viewmodel.dart';

class StudioDetailView extends ConsumerStatefulWidget {
  final StudioModel studioModel;
  const StudioDetailView({super.key, required this.studioModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StudioDetailViewState();
}

class _StudioDetailViewState extends ConsumerState<StudioDetailView> {
  late final ChangeNotifierProvider<StudioDetailViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider<StudioDetailViewModel>(
        (ref) => StudioDetailViewModel(widget.studioModel));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(provider).isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Reserve'),
        onPressed: () {
          ref.read(provider).reserve();
        },
        icon: const Icon(Icons.book),
      ),
      appBar: AppBar(
        title: Text(widget.studioModel.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _image(),
          _description(),
          _details(),
        ],
      ),
    );
  }

  Widget _image() {
    // create a image stack. There should be a bullet list that indicates the current image index, also put arrows to navigate between images
    return Image.network(widget.studioModel.image);
  }

  Widget _description() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("Description",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(widget.studioModel.description),
        ],
      ),
    );
  }

  Widget _details() {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Dance Styles',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
              children: widget.studioModel.danceStyles
                  .map((e) => Container(
                        margin: const EdgeInsets.all(4),
                        child: Chip(label: Text(e.label)),
                      ))
                  .toList()),
          const SizedBox(height: 10),
          const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(widget.studioModel.address),
          const SizedBox(height: 10),
          const Text('Reservation Days',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
              children: widget.studioModel.reservationDays
                  .map((day) => InkWell(
                        onTap: () {
                          setState(() {
                            ref.read(provider).selectedDay = day;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Chip(
                              color: ref.read(provider).selectedDay == day
                                  ? WidgetStateProperty.all(Colors.yellow)
                                  : WidgetStateProperty.all(Colors.white),
                              label: Text(day)),
                        ),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
