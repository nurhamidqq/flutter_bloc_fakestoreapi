import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final AddressEntity address;
  final int id;
  final String email;
  final String username;
  final String password;
  final NameEntity name;
  final String phone;
  UserEntity({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props =>
      [address, id, email, username, password, name, phone];
}

class AddressEntity {
  final GeolocationEntity geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;
  AddressEntity({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });
}

class GeolocationEntity {
  final String lat;
  final String long;
  GeolocationEntity({
    required this.lat,
    required this.long,
  });
}

class NameEntity {
  final String firstname;
  final String lastname;
  NameEntity({
    required this.firstname,
    required this.lastname,
  });
}
