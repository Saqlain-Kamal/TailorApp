class MeasurmentModel {
  final int collar;
  final int shoulder;
  final int sleeves;
  final int chest;
  final int waist;
  final int length;
  final String uid;
  final String label;
  final String name;

  MeasurmentModel({
    required this.chest,
    required this.collar,
    required this.shoulder,
    required this.sleeves,
    required this.length,
    required this.waist,
    required this.uid,
    required this.label,
    required this.name,
  });

  factory MeasurmentModel.fromJson(Map<String, dynamic> json) {
    return MeasurmentModel(
      chest: json['chest'],
      sleeves: json['sleeves'],
      collar: json['collar'],
      length: json['length'],
      uid: json['uid'],
      waist: json['waist'],
      label: json['label'],
      shoulder: json['shoulder'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chest': chest,
      'sleeves': sleeves,
      'collar': collar,
      'length': length,
      'uid': uid,
      'waist': waist,
      'label': label,
      'shoulder': shoulder,
      'name': name,
    };
  }
}
