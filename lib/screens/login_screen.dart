import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanhospital/screens/home.dart';
import 'package:nanhospital/services/userServices.dart';
import 'package:nanhospital/widgets/loading.dart';
import 'package:nanhospital/widgets/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  Future<bool> checkInternet() async {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  TextEditingController grade = TextEditingController();
  TextEditingController matricule = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/logo.png"),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 30,
                      bottom: 10,
                    ),
                    child: TextFormField(
                      controller: grade,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.contains(" ") ||
                            !value.contains("@")) {
                          return "grade non valide";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.grade,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: 'grade',
                        label: Text('grade'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: matricule,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.contains(" ") ||
                            value.length < 6) {
                          return "Mot de passe non valide";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: 'Mot de passe',
                        label: Text('Mot de passe'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        child: const Text("Connexion"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AlertLoading(
                                    context: context,
                                    message: 'Connexion en cour')
                                .show();

                            loginUser(grade.text, matricule.text)
                                .then((responseLogin) async {
                              Navigator.pop(context);
                              if (responseLogin.code == 0) {
                                toastMessage(
                                    responseLogin.message, Colors.green);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setStringList("userInfo", <String>[
                                  responseLogin.nom,
                                  responseLogin.prenom,
                                  responseLogin.grade,
                                  responseLogin.matricule
                                ]);
                              } else {
                                toastMessage(responseLogin.message, Colors.red);
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
