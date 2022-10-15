import 'package:flutter/material.dart';
import 'package:nanhospital/screens/login_screen.dart';
import 'package:nanhospital/screens/medecins.dart';
import 'package:nanhospital/screens/patients.dart';
import 'package:nanhospital/widgets/item_departement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? nom, prenom, email, status;
  userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nom = pref.getStringList("userInfo")!.elementAt(0);
      prenom = pref.getStringList("userInfo")!.elementAt(1);
      email = pref.getStringList("userInfo")!.elementAt(2);
      status = pref.getStringList("userInfo")!.elementAt(3);
    });
  }

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  @override
  Widget build(BuildContext context) {
    return (nom == "0")
        ? const Login()
        : Scaffold(
            appBar: AppBar(
              title: const Text("NAN HOSPITAL"),
              centerTitle: true,
              leading: Image.asset("images/logo.png"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Déconnexion',
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                          'Voulez-vous vous déconnectez ??',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Non'),
                            child: const Text('Non'),
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.clear();
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: const Text('Oui'),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Bienvenue $nom $prenom",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(15),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Medecins()));
                        },
                        child: const ItemDepartement(
                          image:
                              "https://t4.ftcdn.net/jpg/01/34/29/31/360_F_134293169_ymHT6Lufl0i94WzyE0NNMyDkiMCH9HWx.jpg",
                          titre: "Medecins",
                        ),
                      ),
                      const ItemDepartement(
                        image:
                            "https://png.pngtree.com/png-vector/20191215/ourmid/pngtree-cute-cartoon-character-nurse-png-image_2089969.jpg",
                        titre: "Infirmiers",
                      ),
                      const ItemDepartement(
                        image:
                            "https://thumbs.dreamstime.com/b/sage-femme-avec-un-b%C3%A9b%C3%A9-79564062.jpg",
                        titre: "Sages femmes",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Patients()));
                        },
                        child: const ItemDepartement(
                          image:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7RbKkaf4Q6ivakt8TLavdWjxfUSvp3zztMyChnQdZ4FvQMeZvWmybNTS4Vi7dj28eH-g&usqp=CAU",
                          titre: "Patients",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
