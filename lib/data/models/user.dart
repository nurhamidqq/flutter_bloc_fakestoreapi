import 'dart:convert';

import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';

class UserModel {
  final AddressModel address;
  final int id;
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final String phone;
  UserModel({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name.toMap(),
      'phone': phone,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      address: AddressModel.fromMap(map['address']),
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      name: NameModel.fromMap(map['name']),
      phone: map['phone'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      address: AddressEntity(
        geolocation: GeolocationEntity(
          lat: address.geolocation.lat,
          long: address.geolocation.long,
        ),
        city: address.city,
        street: address.street,
        number: address.number,
        zipcode: address.zipcode,
      ),
      id: id,
      email: email,
      username: username,
      password: password,
      name: NameEntity(
        firstname: name.firstname,
        lastname: name.lastname,
      ),
      phone: phone,
    );
  }
}

class NameModel {
  final String firstname;
  final String lastname;
  NameModel({
    required this.firstname,
    required this.lastname,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  factory NameModel.fromMap(Map<String, dynamic> map) {
    return NameModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NameModel.fromJson(String source) =>
      NameModel.fromMap(json.decode(source));
}

class AddressModel {
  final GeolocationModel geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;
  AddressModel({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  Map<String, dynamic> toJson() {
    return {
      'geolocation': geolocation.toJson(),
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      geolocation: GeolocationModel.fromJson(map['geolocation']),
      city: map['city'],
      street: map['street'],
      number: map['number'],
      zipcode: map['zipcode'],
    );
  }
}

class GeolocationModel {
  final String lat;
  final String long;
  GeolocationModel({
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  factory GeolocationModel.fromJson(Map<String, dynamic> map) {
    return GeolocationModel(
      lat: map['lat'] ?? '',
      long: map['long'] ?? '',
    );
  }
}
