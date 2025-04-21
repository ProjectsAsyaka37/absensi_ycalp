import 'package:flutter/material.dart';
import 'package:absensi_ycalp/API/history_absen.dart';
import 'package:absensi_ycalp/API/login_model.dart';
import 'package:absensi_ycalp/API/profile_user.dart';
import 'package:absensi_ycalp/API/register_model.dart';
import 'package:absensi_ycalp/API/absen_checkin.dart';
import 'package:absensi_ycalp/API/absen_checkout.dart';
import 'package:absensi_ycalp/Authservice/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  RegisterModel? _registerModel;
  LoginModel? _loginModel;
  AbsenMasukModel? _absenMasukModel;
  AbsenKeluarModel? _absenKeluarModel;
  ProfileModel? _profileModel;
  HistoryAbsenModel? _historyAbsenModel;

  bool _isLoading = false;

  RegisterModel? get registerModel => _registerModel;
  LoginModel? get loginModel => _loginModel;
  AbsenMasukModel? get absenMasukModel => _absenMasukModel;
  AbsenKeluarModel? get absenKeluarModel => _absenKeluarModel;
  ProfileModel? get profileModel => _profileModel;
  HistoryAbsenModel? get historyAbsenModel => _historyAbsenModel;
  bool get isLoading => _isLoading;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    _registerModel = await _authService.register(
      name: name,
      email: email,
      password: password,
    );
    _isLoading = false;
    notifyListeners();
    return _registerModel != null;
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    _loginModel = await _authService.login(email: email, password: password);
    _isLoading = false;
    notifyListeners();
    return _loginModel != null;
  }

  Future<bool> absenCheckIn({
    required String location,
    required String address,
    required double lat,
    required double lng,
    required String token,
  }) async {
    _isLoading = true;
    notifyListeners();
    _absenMasukModel = await _authService.absenCheckIn(
      location: location,
      address: address,
      lat: lat,
      lng: lng,
      token: token,
    );
    _isLoading = false;
    notifyListeners();
    return _absenMasukModel != null;
  }

  Future<bool> absenCheckOut({
    required String location,
    required String address,
    required double lat,
    required double lng,
    required String token,
  }) async {
    _isLoading = true;
    notifyListeners();
    _absenKeluarModel = await _authService.absenCheckOut(
      location: location,
      address: address,
      lat: lat,
      lng: lng,
      token: token,
    );
    _isLoading = false;
    notifyListeners();
    return _absenKeluarModel != null;
  }

  Future<bool> fetchProfile(String token) async {
    _isLoading = true;
    notifyListeners();

    _profileModel = await _authService.getProfile(token);

    _isLoading = false;
    notifyListeners();
    return _profileModel != null;
  }

  Future<bool> fetchAbsenHistory(String token) async {
    _isLoading = true;
    notifyListeners();

    _historyAbsenModel = await _authService.getAbsenHistory(token);

    _isLoading = false;
    notifyListeners();
    return _historyAbsenModel != null;
  }
}
