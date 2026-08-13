import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider =
StateNotifierProvider<UserNotifier, UserData>(
      (ref) {
    return UserNotifier();
  },
);

class UserData {
  final String name;
  final String email;

  const UserData({
    this.name = 'Droply User',
    this.email = 'user@droply.com',
  });
}

class UserNotifier extends StateNotifier<UserData> {
  UserNotifier() : super(const UserData()) {
    loadUser();
  }

  // ==========================================================
  // LOAD SAVED USER
  // ==========================================================

  Future<void> loadUser() async {
    final prefs =
    await SharedPreferences.getInstance();

    final name =
    prefs.getString('user_name');

    final email =
    prefs.getString('user_email');

    if (name != null || email != null) {
      state = UserData(
        name: name ?? 'Droply User',
        email: email ?? 'user@droply.com',
      );
    }
  }

  // ==========================================================
  // SAVE USER
  // ==========================================================

  Future<void> saveUser({
    required String name,
    required String email,
  }) async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      'user_name',
      name,
    );

    await prefs.setString(
      'user_email',
      email,
    );

    state = UserData(
      name: name,
      email: email,
    );
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove('user_name');
    await prefs.remove('user_email');

    state = const UserData();
  }
}