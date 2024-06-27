import 'dart:convert';
import 'dart:developer';

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? region;
  String? zone;
  String? occupationType;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.region,
    this.zone,
    this.occupationType,
  });

  _userInfo() {
    log(" $firstName $lastName $email $password $phoneNumber $region $zone $occupationType");
  }

  isValid() {
    if (firstName == null ||
        lastName == null ||
        email == null ||
        password == null ||
        phoneNumber == null ||
        region == null ||
        zone == null ||
        occupationType == null) {
      log("some required fields are missing");
      return false;
    }
    bool validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email!);

    if (!validEmail) {
      log("email is not valid");
      return false;
    }

    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'region': region,
      'zone': zone,
      'occupation': occupationType,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      region: json['region'],
      zone: json['zone'],
      occupationType: json['occupation'],
    );
  }

  static final dummyUser = User(
      firstName: "John",
      lastName: "Doe",
      email: "john.doe@example.com",
      password: "password123",
      phoneNumber: "1234567890",
      region: "Dire Dawa",
      zone: "Dire Dawa",
      occupationType: "Researcher");
}
