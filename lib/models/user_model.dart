// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String userUid;
  String userName;
  String userEmail;
  String userImage;
  UserModel({
    required this.userUid,
    required this.userName,
    required this.userEmail,
    required this.userImage,
  });
}

class UserModelFirestore {
  String address;
  String phone;
  String age;
  UserModelFirestore({
    required this.address,
    required this.phone,
    required this.age,
  });
}
