import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../composants/image_icone/imageicone.dart';
import '../../pages/details_docteurs_page.dart';

class RepresentationDocteur extends StatelessWidget {
  RepresentationDocteur({super.key});

  // Liste des données des docteurs
  final List<Map<String, String>> docteuritems = [
    {
      'name': 'Dr. Junior ',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
    // Ajoutez d'autres éléments de la liste au besoin
    {
      'name': 'Dr. Isaac ',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Cardiologue',
      'note': '5.0',
      'location': '800m away',
    },
    {
      'name': 'Dr. Maria ',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
    {
      'name': 'Dr. Krys ',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  border:
                      Border.all(color: const Color(0xFFE8F3F1), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Cercle avatar du docteur
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        item['Profils'] ?? '',
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
                      item['Specialisation'] ?? '',
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
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageIcones(
                              ImageIcone:
                              "assets/Icons/Star.svg",
                              width: 27.0,
                              height: 27.0,
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
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageIcones(
                              ImageIcone:
                              "assets/Icons/Location.svg",
                              width: 27.0,
                              height: 27.0,
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
}

class ToutlesDocteurs extends StatelessWidget {
  ToutlesDocteurs({super.key});

  // Liste des données des docteurs
  final List<Map<String, String>> docteuritems = [
    {
      'name': 'Dr. Junior ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
    // Ajoutez d'autres éléments de la liste au besoin
    {
      'name': 'Dr. Isaac ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '5.0',
      'location': '800m away',
    },
    {
      'name': 'Dr. Maria ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
    {
      'name': 'Dr. Krys ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
    {
      'name': 'Dr. Isaac ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '5.0',
      'location': '800m away',
    },
    {
      'name': 'Dr. Maria ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
    {
      'name': 'Dr. Krys ',
      'Profils': 'assets/Images/profil/medecin/medecin.png',
      'Specialisation': 'Cardiologue',
      'note': '4.5',
      'location': '800m away',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: docteuritems.map((item) {
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
                    border:
                        Border.all(color: const Color(0xFFE8F3F1), width: 1.0),
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
                                image: AssetImage(
                                  item['Profils'] ?? '',
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
                                  item['name'] ??
                                      '', // Affichez le nom du docteur
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  item['Specialisation'] ?? '',
                                  textAlign: TextAlign
                                      .left, // Affichez le nom du docteur
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
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ImageIcones(
                                    ImageIcone:
                                    "assets/Icons/Star.svg",
                                    width: 27.0,
                                    height: 27.0,
                                  ),
                                  Text(
                                    item['note'] ??
                                        '', // Affichez la note du docteur
                                    style: const TextStyle(
                                      color: Color(0xFF66DED4),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ImageIcones(
                                    ImageIcone:
                                    "assets/Icons/Location.svg",
                                    width: 27.0,
                                    height: 27.0,
                                  ),
                                  Text(
                                    item['location'] ??
                                        '', // Affichez l'adresse du docteur
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
      ),
    );
  }
}
