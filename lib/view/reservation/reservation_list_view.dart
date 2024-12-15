import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/view/reservation/reservation_list_viewmodel.dart';

class ReservationListView extends ConsumerStatefulWidget {
  const ReservationListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationListViewState();
}

class _ReservationListViewState extends ConsumerState<ReservationListView> {
  ChangeNotifierProvider<ReservationListViewModel> provider =
      ChangeNotifierProvider<ReservationListViewModel>(
          (ref) => ReservationListViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(provider).fetchReservations();
    });
    super.initState();
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
    return ListView.builder(
      itemCount: ref.watch(provider).reservationList.length,
      itemBuilder: (context, index) {
        final reservation = ref.watch(provider).reservationList[index];
        return ListTile(
          title: Text("Reservation for ${reservation.studioName}"),
          subtitle: Text("Day: ${reservation.day}"),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(provider).deleteReservation(index);
            },
          ),
        );
      },
    );
  }
}
