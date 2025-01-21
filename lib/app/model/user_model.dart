class UserModel {
  String? id;
  String? userId;
  String? name;
  String? email;
  String? role;
  String? phoneNumber;
  String? bio;
  String? isOrderSend;
  String? lat;
  String? lon;
  String? userImage;
  String? shopName;
  String? experience;
  String? stichingService;
  String? startingPrice;
  String? place;

  UserModel({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.role,
    this.phoneNumber,
    this.bio,
    this.isOrderSend,
    this.shopName,
    this.userImage,
    this.experience,
    this.lat,
    this.lon,
    this.startingPrice,
    this.stichingService,
    this.place,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      bio: json['bio'],
      isOrderSend: json['isOrderSend'],
      phoneNumber: json['phoneNumber'],
      shopName: json['shopName'],
      role: json['role'],
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      userImage: json['userImage'],
      experience: json['experience'],
      lat: json['lat'],
      lon: json['lon'],
      stichingService: json['stichingService'],
      startingPrice: json['startingPrice'],
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'lon': lon,
      'isOrderSend': isOrderSend,
      'phoneNumber': phoneNumber,
      'shopName': shopName,
      'userImage': userImage,
      'bio': bio,
      'lat': lat,
      'experience': experience,
      'stichingService': stichingService,
      'startingPrice': startingPrice,
      'place': place,
    };
  }
}
