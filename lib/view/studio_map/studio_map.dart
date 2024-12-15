import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intern_task/view/studio_map/studio_map_viewmodel.dart';

class StudioMapView extends ConsumerStatefulWidget {
  const StudioMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudioMapViewState();
}

class _StudioMapViewState extends ConsumerState<StudioMapView> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  late final GoogleMapController _controller;
  late final ChangeNotifierProvider<StudioMapViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => StudioMapViewModel());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(provider).fetchStudioList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(provider).isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return GoogleMap(
      mapType: MapType.hybrid,
      markers: ref.watch(provider).markers.toSet(),
      initialCameraPosition: CameraPosition(
          target: ref.watch(provider).markers.first.position, zoom: 15),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _controller.animateCamera(
          CameraUpdate.newLatLng(ref.watch(provider).markers.first.position),
        );
      },
    );
  }
}
