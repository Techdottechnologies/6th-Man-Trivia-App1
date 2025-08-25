class UserModel {
  String id = '';
  String name = '';
  String email = '';
  String profileImg = '';
  String initialPassword = '';
  List<dynamic> pictures = [];

  // New fields
  String gender = '';
  String age = '';
  String height = '';
  String residingCity = '';
  String bornCity = '';
  String languages = '';
  bool allowMessages = true;

  UserModel();

  UserModel.toModel(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    profileImg = json['profileImg'] ?? '';
    pictures = json['pictures'] ?? [];

    gender = json['gender'] ?? '';
    age = json['age'] ?? '';
    height = json['height'] ?? '';
    residingCity = json['residingCity'] ?? '';
    bornCity = json['bornCity'] ?? '';
    languages = json['languages'] ?? '';
    allowMessages = json['allowMessages'] ?? true;
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImg': profileImg,
      'pictures': pictures,
      'gender': gender,
      'age': age,
      'height': height,
      'residingCity': residingCity,
      'bornCity': bornCity,
      'languages': languages,
      'allowMessages': allowMessages,
    };
  }
}