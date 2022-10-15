import 'package:flutter/material.dart';
import 'package:nanhospital/widgets/loading.dart';

class Medecins extends StatefulWidget {
  const Medecins({Key? key}) : super(key: key);

  @override
  State<Medecins> createState() => _MedecinsState();
}

class _MedecinsState extends State<Medecins> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController matricule = TextEditingController();
  TextEditingController grade = TextEditingController();

  final List<String> items =
      List<String>.generate(10000, (i) => 'Eric Gondo $i');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medecins"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  width: 20,
                ),
                Text(items[index]),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Center(child: Text('Ajouter medcin')),
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                    const SizedBox(
                      height: 15,
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
                              controller: nom,
                              validator: (value) {
                                if (value!.isEmpty || value.contains(" ")) {
                                  return "Nom invalide";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                hintText: 'Nom',
                                label: Text('Nom'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: prenom,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Prénom invalide";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                hintText: 'Prénom',
                                label: Text('Prenom'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: matricule,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Matricule invalide";
                                }
                                return null;
                              },
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
                                hintText: 'Matricule',
                                label: Text('Matricule'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: grade,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Grade invalide";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.note,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                hintText: 'Grade',
                                label: Text('Grade'),
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
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))),
                                child: const Text("Ajouter"),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AlertLoading(
                                            context: context,
                                            message: 'Connexion en cour')
                                        .show();
                                    /**Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Home()));**/

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
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'annuler'),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
