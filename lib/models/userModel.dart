import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.code,
    required this.id,
    required this.nom,
    required this.prenom,
    required this.grade,
    required this.matricule,
    required this.status,
    required this.message,
  });

  int code;
  String id;
  String nom;
  String prenom;
  String grade;
  String matricule;
  String status;
  String message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    code: json["code"],
    id: json["id"].toString(),
    nom: json["nom"].toString(),
    prenom: json["prenom"].toString(),
    grade: json["telephone"].toString(),
    matricule: json["matricule"].toString(),
    status: json["status"].toString(),
    message: json["message"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "id": id,
    "nom": nom,
    "prenom": prenom,
    "grade": grade,
    "matricule": matricule,
    "status": status,
    "message": message,
  };
}
