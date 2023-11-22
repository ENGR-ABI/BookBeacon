import 'dart:convert';
import 'package:bookbeacon/app/services/app_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../config/values.dart';
import '../models/user_model.dart';

class CacheStore extends GetxController {
  static CacheStore get inst => Get.find();

  /// Private [User] variable holding FB authenticated user's details
  User? currentQaaria;

  /// Private [bool] variable for checking wheather a user is logged in or not
  final _isLogged = false.obs;

  /// Private [String] variable holding logged in user's unique ID for various use
  final _token = ''.obs;

  /// Private [Map] variable holding information of logged in user
  final _userProfile = UserModel().obs;

  /// [getter] returning values of the private [isLogged]
  bool get isLogged => _isLogged.value;

  /// [getter] returning values of the private [ token]
  String get token => _token.value;

  /// [getter] returning values of the private [userProfile]
  UserModel get userProfile => _userProfile.value;
  set userProfile(UserModel user) => _userProfile(user);


  @override
  void onInit() {
    super.onInit();
    var tokenStored = AppStorage.inst.fetch(USER_TOKEN_KEY);
    tokenStored != null
        ? _token.value = tokenStored.toString()
        : _token.value = '';

    /// abalaidriss@gmail.com
    /// AppStorage.inst.remove(USER_TOKEN_KEY);
    var userData = AppStorage.inst.fetch(USER_TOKEN_KEY);
    if (userData != null) {
      _isLogged.value = true;
      final userDataDecoded =
          jsonDecode(userData.toString()) as Map<String, dynamic>;
      _userProfile(UserModel.fromMap(userDataDecoded));
    }
  }

  setToken(String token) async {
    await AppStorage.inst.store({USER_TOKEN_KEY: token});
    _token.value = token;
  }

  Future saveProfile(UserModel profileData) async {
    final newProfileData = profileData.toJson();
    await AppStorage.inst
        .store({USER_TOKEN_KEY: jsonEncode(newProfileData)});
    _isLogged.value = true;
    _userProfile(profileData);
  }

}
