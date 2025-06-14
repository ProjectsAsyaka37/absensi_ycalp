// To parse this JSON data, do
//
//     final absenMasukModel = absenMasukModelFromJson(jsonString);

import 'dart:convert';

AbsenMasukModel absenMasukModelFromJson(String str) =>
    AbsenMasukModel.fromJson(json.decode(str));

String absenMasukModelToJson(AbsenMasukModel data) =>
    json.encode(data.toJson());

class AbsenMasukModel {
  final String? message;
  final Data? data;

  AbsenMasukModel({this.message, this.data});

  factory AbsenMasukModel.fromJson(Map<String, dynamic> json) =>
      AbsenMasukModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  final int? userId;
  final DateTime? checkIn;
  final String? checkInLocation;
  final String? checkInAddress;
  final String? status;
  final dynamic alasanIzin;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final double? checkInLat;
  final double? checkInLng;
  final double? checkOutLat;
  final double? checkOutLng;

  Data({
    this.userId,
    this.checkIn,
    this.checkInLocation,
    this.checkInAddress,
    this.status,
    this.alasanIzin,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.checkInLat,
    this.checkInLng,
    this.checkOutLat,
    this.checkOutLng,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
    checkInLocation: json["check_in_location"],
    checkInAddress: json["check_in_address"],
    status: json["status"],
    alasanIzin: json["alasan_izin"],
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    checkInLat: json["check_in_lat"]?.toDouble(),
    checkInLng: json["check_in_lng"]?.toDouble(),
    checkOutLat: json["check_out_lat"]?.toDouble(),
    checkOutLng: json["check_out_lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "check_in": checkIn?.toIso8601String(),
    "check_in_location": checkInLocation,
    "check_in_address": checkInAddress,
    "status": status,
    "alasan_izin": alasanIzin,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "check_in_lat": checkInLat,
    "check_in_lng": checkInLng,
    "check_out_lat": checkOutLat,
    "check_out_lng": checkOutLng,
  };
}
