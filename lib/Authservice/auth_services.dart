import 'dart:convert';
import 'package:absensi_ycalp/API/history_absen.dart';
import 'package:absensi_ycalp/API/profile_user.dart';
import 'package:http/http.dart' as http;
import 'package:absensi_ycalp/API/endpoint.dart';
import 'package:absensi_ycalp/API/absen_checkin.dart';
import 'package:absensi_ycalp/API/absen_checkout.dart';
import 'package:absensi_ycalp/API/register_model.dart';
import 'package:absensi_ycalp/API/login_model.dart';

class AuthService {
  Future<RegisterModel?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"name": name, "email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        return registerModelFromJson(response.body);
      } else {
        print("Register failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  // ⬇️ Pindahkan method login ke dalam class AuthService
  Future<LoginModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.loginEndpoint);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        return loginModelFromJson(response.body);
      } else {
        print("Login failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  // Tambahan Check-in
  Future<AbsenMasukModel?> absenCheckIn({
    required String location,
    required String address,
    required double lat,
    required double lng,
    required String token,
  }) async {
    try {
      final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.AbsenCheckIn);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "check_in_location": location,
          "check_in_address": address,
          "check_in_lat": lat,
          "check_in_lng": lng,
        }),
      );

      if (response.statusCode == 200) {
        return absenMasukModelFromJson(response.body);
      } else {
        print("Check-in failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Check-in error: $e");
      return null;
    }
  }

  // Tambahan Check-out
  Future<AbsenKeluarModel?> absenCheckOut({
    required String location,
    required String address,
    required double lat,
    required double lng,
    required String token,
  }) async {
    try {
      final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.AbsenCheckOut);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "check_out_location": location,
          "check_out_address": address,
          "check_out_lat": lat,
          "check_out_lng": lng,
        }),
      );

      if (response.statusCode == 200) {
        return absenKeluarModelFromJson(response.body);
      } else {
        print("Check-out failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Check-out error: $e");
      return null;
    }
  }

  // Tambahan Profile
  Future<HistoryAbsenModel?> getAbsenHistory(String token) async {
    try {
      final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.AbsenHistory);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return historyAbsenModelFromJson(response.body);
      } else {
        print("Get history failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("History error: $e");
      return null;
    }
  }

  // Tambahan History Absen
  Future<ProfileModel?> getProfile(String token) async {
    try {
      final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.Prodile);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return profileModelFromJson(response.body);
      } else {
        print("Get profile failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Profile error: $e");
      return null;
    }
  }
}
