import 'package:myapp/core/utils/helpers/helpers.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final int token;
  final String? profileSticker;
  final double wasteCollected;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.wasteCollected,
    required this.token,
    this.profileSticker,
  });
  String get fullName =>' $firstName  $lastName';

  String get formattedPhoneNo => THelper.formatPhoneNumber(phoneNumber);
  
  static List<String> nameParts(fullName)=>fullName.split(" ");

  static String generatedUsername(fullName){
    List<String> nameParts=fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length>1?nameParts[1].toLowerCase():"";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }
   static UserModel empty()=> UserModel(uid:'',firstName:'',lastName:'',userName:'',email:'',phoneNumber:'',profileSticker:'',token: 0, wasteCollected: 0.0);
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "profileSticker": profileSticker ?? "", 
      "token": token,
      "uid": uid,
      "userName": userName,
      "wasteCollected": wasteCollected,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      userName: map["userName"] ?? "",
      email: map["email"] ?? "",
      phoneNumber: map["phoneNumber"] ?? "",
      profileSticker: map["profileSticker"] ?? "",
      token: map["token"] ?? 0, // Default to 0 if null
      wasteCollected: (map["wasteCollected"]?.toDouble()) ?? 0.0, // Convert safely
    );
  }
}
