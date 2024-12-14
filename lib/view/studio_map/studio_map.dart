import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudioMap extends ConsumerStatefulWidget {
  const StudioMap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudioMapState();
}

class _StudioMapState extends ConsumerState<StudioMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Map")),
    );
  }
}
