import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nanhospital/constantes/urls.dart';
import 'package:nanhospital/models/userModel.dart';

Future inscription(
    String nom, String prenom, String grade, String matricule) async {
  final response = await http.post(
    Uri.parse(Urls.inscription),
    body: {
      'nom': nom,
      'prenom': prenom,
      'grade': grade,
      'matricule': matricule,
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Problème de connexion au serveur.');
  }
}

Future<UserModel> loginUser(String grade, String matricule) async {
  final response = await http.post(
    Uri.parse(Urls.login),
    body: {
      'grade': grade,
      'matricule': matricule,
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    return UserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Problème de connexion au serveur.');
  }
}
