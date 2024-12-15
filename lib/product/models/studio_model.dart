import '../enums/dance_style_enum.dart';

class StudioModel {
  final String uid;
  final String name;
  final String address;
  final double lat;
  final double long;
  final String description;
  final List<DanceStyleEnum> danceStyles;
  final List<String> reservationDays;
  final String image = "https://picsum.photos/200";

  StudioModel({
    required this.uid,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.description,
    required this.danceStyles,
    required this.reservationDays,
  });

  factory StudioModel.fromJson(Map<String, dynamic> json, String uid) {
    return StudioModel(
      uid: uid,
      name: json['name'],
      address: json['address'],
      lat: json['lat'],
      long: json['long'],
      danceStyles: (json['danceStyles'] as List<dynamic>)
          .map((e) =>
              DanceStyleEnum.values.firstWhere((element) => element.name == e))
          .toList(),
      reservationDays: (json['reservationDays'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'address': address,
      'lat': lat,
      'long': long,
      'danceStyles': danceStyles.map((e) => e.name).toList(),
      'reservationDays': reservationDays,
      'description': description,
    };
  }
}
