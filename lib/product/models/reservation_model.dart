class ReservationModel {
  final String uid;
  final String day;
  final String studioName;

  ReservationModel({
    required this.uid,
    required this.day,
    required this.studioName,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json, String uid) {
    return ReservationModel(
      uid: uid,
      day: json['day'],
      studioName: json['studioName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'day': day,
      'studioName': studioName,
    };
  }
}
