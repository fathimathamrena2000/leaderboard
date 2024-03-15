import 'package:flutter/foundation.dart';
import 'package:leaderboard_app/model/usermodel.dart';
import 'package:http/http.dart' as http;

import '../database/db_functions.dart';

class UserDetails with ChangeNotifier {
  UserModel? _userData;
  UserModel? get userData => _userData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasError = false;
  bool get hasError => _hasError;

  Future<void> fetchdata() async {
    String baseUrl =
        "https://run.mocky.io/v3/078310bd-5004-4d1e-af40-65917daa6eeb";

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      var response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        _userData = userModelFromJson(response.body);
        await DatabaseHelper.insertLeaders(_userData!.leaders);
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      _hasError = true;
      if (kDebugMode) {
        print('Error: $error');
      }
    } finally {
      _isLoading = false;

      Future.microtask(() {
        notifyListeners();
      });
    }
  }
}
