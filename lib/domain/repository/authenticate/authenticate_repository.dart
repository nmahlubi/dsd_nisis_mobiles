import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../model/intake/auth_token.dart';
import '../../db_model_hive/authenticate/auth_token.model.dart';
import 'roles/nisis_role_repository.dart';

const String _authTokenBox = 'authTokenNisisHiveBox';

class AuthenticateRepository {
  AuthenticateRepository._constructor();

  final _nisisRoleRepository = NisisRoleRepository();

  static final AuthenticateRepository _instance =
      AuthenticateRepository._constructor();

  factory AuthenticateRepository() => _instance;

  late Box<AuthTokenModel> _authTokensBox;

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter<AuthTokenModel>(AuthTokenModelAdapter());
    _authTokensBox = await Hive.openBox<AuthTokenModel>(_authTokenBox);
  }

  Future<void> saveAuthToken(AuthToken authToken, String? password) async {
    await _authTokensBox.put(
        authToken.userId,
        AuthTokenModel(
            userId: authToken.userId,
            username: authToken.username,
            firstname: authToken.firstname,
            password: password,
            supervisor: authToken.supervisor,
            nisisRoleModel: authToken.nisisRoleDto != null
                ? _nisisRoleRepository.nisisRoleToDb(authToken.nisisRoleDto)
                : null));
  }

  Future<void> deleteAuthToken(int id) async {
    await _authTokensBox.delete(id);
  }

  Future<void> deleteAllAuthTokens() async {
    await _authTokensBox.clear();
  }

  Future<List<AuthToken>> getAllAuthTokens() async {
    return _authTokensBox.values.map(_authTokenFromDb).toList();
  }

  // AuthToken? getAuthTokenByUsername(String? username, String? password) {
  //   var authTokenItems = _authTokensBox.values
  //       .where((userToken) =>
  //           userToken.username!.toLowerCase() == username!.toLowerCase() &&
  //           userToken.password == password)
  //       .toList();
  //   if (authTokenItems.isNotEmpty) {
  //     return _authTokenFromDb(authTokenItems.first);
  //   }
  //   return null;
  // }
  AuthToken? getAuthTokenByUsername(String? username, String? password) {
    var authTokenItems = _authTokensBox.values
        .where((userToken) =>
    userToken.username!.toLowerCase() == username!.toLowerCase())
        .toList();

    if (authTokenItems.isNotEmpty) {
      var authTokenItem = authTokenItems.first;
      if (_comparePassword(authTokenItem.password, password)) {
        return _authTokenFromDb(authTokenItem);
      }
    }
    return null;
  }

  String hashPassword(String password) {
    const salt = 'random_salt';
    final bytes = utf8.encode(password + salt);
    final hash = sha256.convert(bytes).toString();
    return hash;
  }

  bool _comparePassword(String? storedPassword, String? inputPassword) {
    // Implement your password comparison logic here.
    // Ensure to use a secure and appropriate method for comparing passwords (e.g., hash comparison).
    // Example:
    // return storedPassword == hash(inputPassword);
    return storedPassword == inputPassword;
  }



  AuthToken? getAuthTokenById(int id) {
    final tokenDb = _authTokensBox.get(id);
    if (tokenDb != null) {
      return _authTokenFromDb(tokenDb);
    }
    return null;
  }

  AuthToken _authTokenFromDb(AuthTokenModel authTokenModel) => AuthToken(
      userId: authTokenModel.userId,
      username: authTokenModel.username,
      firstname: authTokenModel.firstname,
      supervisor: authTokenModel.supervisor,
      token: "9b4ca593-5f28-4802-b2f7-b234220d05a3",
      nisisRoleDto: authTokenModel.nisisRoleModel != null
          ? _nisisRoleRepository
              .nisisRoleDtoFromDb(authTokenModel.nisisRoleModel!)
          : null);
}
