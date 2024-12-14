class ReservationModel {
  final String uid;
  final String day;
  final int personCount;

  ReservationModel({
    required this.uid,
    required this.day,
    required this.personCount,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      uid: json['uid'],
      day: json['day'],
      personCount: json['personCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'day': day,
      'personCount': personCount,
    };
  }
}
