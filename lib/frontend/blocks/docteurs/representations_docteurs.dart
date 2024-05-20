import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../composants/image_icone/imageicone.dart';
import '../../pages/details_docteurs_page.dart';

class RepresentationDocteur extends StatelessWidget {
  const RepresentationDocteur({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('docteurs').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Une erreur est survenue'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun docteur trouvé'));
        } else {
          final docteuritems = snapshot.data!.docs.map((doc) {
            return {
              'name': doc['noms'],
              'profiles': doc['profileURL'],
              'specialisation': doc['specialisation'],
              'note': doc['note'],
              'location': doc['location'],
            };
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: docteuritems.map((item) {
                return SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      // Naviguer vers les détails du docteur
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Detailsdocteurs(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 125, // Largeur du conteneur de l'élément du docteur
                      height: 187,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.13),
                        border: Border.all(color: const Color(0xFFE8F3F1), width: 1.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cercle avatar du docteur
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              item['profiles'] ?? '',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item['name'] ?? '', // Nom du docteur
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            item['specialisation'] ?? '',
                            textAlign: TextAlign.left, // Spécialisation du docteur
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Note du docteur
                              Row(
                                children: [
                                  const ImageIcones(
                                    ImageIcone: "assets/Icons/Star.svg",
                                    width: 12.0,
                                    height: 12.0,
                                  ),
                                  Text(
                                    item['note'] ?? '', // Note du docteur
                                    style: const TextStyle(
                                      color: Color(0xFF66DED4),
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              // Emplacement du docteur
                              Row(
                                children: [
                                  const ImageIcones(
                                    ImageIcone: "assets/Icons/location.svg",
                                    width: 12.0,
                                    height: 12.0,
                                  ),
                                  Text(
                                    item['location'] ?? '', // Emplacement du docteur
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}


class ToutlesDocteurs extends StatelessWidget {
  const ToutlesDocteurs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('docteurs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucun docteur trouvé.'));
          }

          final docteuritems = snapshot.data!.docs;

          return Column(
            children: docteuritems.map((doc) {
              final item = doc.data() as Map<String, dynamic>;

              return Center(
                child: SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      // Naviguer vers les détails du docteur
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Detailsdocteurs(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: 334,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.13),
                        border: Border.all(color: const Color(0xFFE8F3F1), width: 1.0),
                      ),
                      child: Row(
                        children: [
                          // Photos de profils du docteurs
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 111,
                                height: 111,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.13),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item['profiles'] ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Informations
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //1ere colonne réservée aux identités du docteurs
                                  children: [
                                    Text(
                                      item['noms'] ?? '', // Affichez le nom du docteur
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      item['specialisation'] ?? '',
                                      textAlign: TextAlign.left, // Affichez la spécialisation
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                //2eme colonne réservée à la note du médecin et à la distance entre le client et le médecin
                                children: [
                                  Row(
                                    children: [
                                      const ImageIcones(
                                        ImageIcone: "assets/Icons/Star.svg",
                                        width: 12.0,
                                        height: 12.0,
                                      ),
                                      Text(
                                        item['note'] ?? '', // Affichez la note du docteur
                                        style: const TextStyle(
                                          color: Color(0xFF66DED4),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const ImageIcones(
                                        ImageIcone: "assets/Icons/location.svg",
                                        width: 12.0,
                                        height: 12.0,
                                      ),
                                      Text(
                                        item['location'] ?? '', // Affichez l'adresse du docteur
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
