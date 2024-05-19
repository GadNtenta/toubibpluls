import 'package:flutter/material.dart';

import '../blocks/docteurs/representations_docteurs.dart';
import '../composants/boutons/boutons_home.dart';
import '../composants/image_icone/imageicone.dart';
import 'docteur_screen.dart';
import 'maps_screen.dart';
import 'message_screen.dart';
import 'profil_screen.dart';
import 'rdv_screen.dart';

// Écran principal de l'application
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0; // Index de l'élément sélectionné dans la barre de navigation

  // Fonction appelée lorsqu'un élément de la barre de navigation est sélectionné
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 4) {
      _navigateToPage(const ProfilePage());
    } else if (_selectedIndex == 1) {
      _navigateToPage(const MessagePage());
    } else if (_selectedIndex == 2) {
      _navigateToPage(const MapsPage());
    } else if (_selectedIndex == 3) {
      _navigateToPage(const RdvPage());
    }
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,

        // Barre d'application inchangée
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Texte à gauche
                      Text(
                        "Ma santé à portée de main.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),

                      // Icône de notification à droite
                      ImageIcones(
                          height: 27.0,
                          width: 27.0,
                          ImageIcone: 'assets/Icons/Notification.svg',),
                      /*Image(
                          height: 27.0,
                          width: 27.0,
                          image: AssetImage(
                              'assets/Icons/Notification.svg')),
                     */
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Barre de recherche
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      children: [
                        ImageIcones(
                          height: 13.0,
                          width: 13.0,
                          ImageIcone:'assets/Icons/Search.svg'),
                        /*Icon(
                          Icons.search,
                          color: Color(0xFFADADAD),
                        ),*/
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Trouver une pharmacie, un hôpital, un médecin ...',
                            style: TextStyle(
                              color: Color(0xFFADADAD),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Icônes Docteur, Pharmacie, Hôpital, Ambulance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Docteur
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Docteurs(),
                                ),
                              );
                            },
                            child: const Column(
                              children: [
                                ImageIcones(
                                  ImageIcone: "assets/Icons/Doctor.svg",
                                  width: 27.0,
                                  height: 27.0,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Docteurs',
                                  style: TextStyle(
                                    color: Color(0xFFADADAD),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Pharmacie
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapsPage(),
                                ),
                              );
                            },
                            child: const Column(
                              children: [
                                ImageIcones(
                                  ImageIcone:
                                      "assets/Icons/Pharmacy.svg",
                                  width: 27.0,
                                  height: 27.0,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Pharmacies',
                                  style: TextStyle(
                                    color: Color(0xFFADADAD),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Hôpital
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapsPage(),
                                ),
                              );
                            },
                            child: const Column(
                              children: [
                                ImageIcones(
                                  ImageIcone:
                                      "assets/Icons/Hospital.svg",
                                  width: 27.0,
                                  height: 27.0,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Hôpitaux',
                                  style: TextStyle(
                                    color: Color(0xFFADADAD),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Ambulance
                      const Column(
                        children: [
                          ImageIcones(
                            ImageIcone: "assets/Icons/Ambulance.svg",
                            width: 27.0,
                            height: 27.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Ambulances',
                            style: TextStyle(
                              color: Color(0xFFADADAD),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Corps de l'écran d'accueil
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F3F1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Titre
                              Text(
                                'Une protection rapide ',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'de la santé de votre',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'famille.',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 5),

                              // Bouton "En savoir plus"
                              BuildButton2(
                                textButton: 'En savoir plus',
                                iconImage: null,
                              ),
                            ],
                          ),
                        ),

                        // Illustration de docteur
                        Image.asset(
                          'assets/Illustrations/docteur-illustration-du-haut-avec-sphere.png',
                          height: 135,
                          width: 121,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Section Docteurs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Docteurs",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Docteurs(),
                            ),
                          );
                        },
                        child: const Text(
                          "Voir plus",
                          style: TextStyle(
                            color: Color(0xFF66DED4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Profils de quelques docteurs
                  RepresentationDocteur(),

                  const SizedBox(height: 25),

                  // Section Hôpitaux
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hôpitaux",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Voir plus",
                        style: TextStyle(
                          color: Color(0xFF66DED4),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  RepresentationDocteur(),
                  const SizedBox(height: 25),

                  // Section Pharmacies
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pharmacies",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Voir plus",
                        style: TextStyle(
                          color: Color(0xFF66DED4),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  RepresentationDocteur(),
                ],
              ),
            ),
          ),
        ),

        // Barre de navigation en bas de l'écran
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
          const Color(0xFF66DED4), // Couleur de l'élément sélectionné
          unselectedItemColor:
          Colors.grey.shade700, // Couleur des éléments non sélectionnés
          type: BottomNavigationBarType
              .fixed, // Type de la barre de navigation (fixe)
          showSelectedLabels:
          false, // Ne pas afficher les labels des éléments sélectionnés
          showUnselectedLabels:
          false, // Ne pas afficher les labels des éléments non sélectionnés
          currentIndex:
          _selectedIndex, // Index de l'élément actuellement sélectionné
          onTap:
          _onItemTapped, // Fonction appelée lorsque l'utilisateur sélectionne un élément
          items: [
            BottomNavigationBarItem(
              icon: ImageIcone1(
                imageIcone: 'assets/Icons/Home.svg',
                width: 19.0,
                height: 19.0,
                isSelected: _selectedIndex == 0,
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: ImageIcone1(
                imageIcone: 'assets/Icons/Message.svg',
                width: 19.0,
                height: 19.0,
                isSelected: _selectedIndex == 1,
              ),
              label: 'Message',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.map_sharp),
              label: 'Maps',
            ),
            BottomNavigationBarItem(
              icon: ImageIcone1(
                imageIcone: 'assets/Icons/Calendar.svg',
                width: 19.0,
                height: 19.0,
                isSelected: _selectedIndex == 3,
              ),
              label: 'Rendez-vous',
            ),
            BottomNavigationBarItem(
              icon: ImageIcone1(
                imageIcone: 'assets/Icons/Profile.svg',
                width: 19.0,
                height: 19.0,
                isSelected: _selectedIndex == 4,
              ),
              label: 'Compte',
            ),
          ],
        ),
      ),
    );
  }
}




