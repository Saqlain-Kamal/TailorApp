class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;
  String? phoneNumber;
  String? bio;

  String? location;
  String? userImage;
  String? shopName;
  String? experience;
  String? stichingService;
  String? startingPrice;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phoneNumber,
    this.bio,
    this.shopName,
    this.userImage,
    this.experience,
    this.location,
    this.startingPrice,
    this.stichingService,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      bio: json['bio'],
      phoneNumber: json['phoneNumber'],
      shopName: json['shopName'],
      role: json['role'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userImage: json['userImage'],
      experience: json['experience'],
      location: json['location'],
      stichingService: json['stichingService'],
      startingPrice: json['startingPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'shopName': shopName,
      'userImage': userImage,
      'bio': bio,
      'location': location,
      'experience': experience,
      'stichingService': stichingService,
      'startingPrice': startingPrice,
    };
  }
}
