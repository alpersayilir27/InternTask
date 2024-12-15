import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/view/studio_list/studio_list_view.dart';
import 'package:intern_task/view/studio_map/studio_map.dart';

import '../reservation/reservation_list_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _currentIndex = 0;

  final List<Widget Function()> _children = [
    () => const StudioListView(),
    () => const StudioMapView(),
    () => const ReservationListView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mimiqit App"),
      ),
      body: _children[_currentIndex](),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Reservations",
          ),
        ],
      ),
    );
  }
}
