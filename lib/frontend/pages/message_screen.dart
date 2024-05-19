import 'package:flutter/material.dart';

import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'maps_screen.dart';
import 'profil_screen.dart';
import 'rdv_screen.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

enum FiltreTypeMessage { tout, groupe, prive }

class _MessagePageState extends State<MessagePage> {
  int _selectedIndex = 1;
  // Fonction appelée lorsqu'un élément de la barre de navigation est sélectionné
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Ajout de la logique pour la navigation vers RdvPage lorsque l'index est 3 (calendrier)
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Accueil(),
        ),
      );
    } else if (_selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapsPage(),
        ),
      );
    } else if (_selectedIndex == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RdvPage(),
        ),
      );
    } else if (_selectedIndex == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ),
      );
    }
  }

  FiltreTypeMessage status = FiltreTypeMessage.tout;
  Alignment _alignment = Alignment.centerLeft;
  List<Map<String, dynamic>> message = [
    {
      'name': 'Dr. Isaac Kumwimba',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Message': "Je n'ai pas de fièvre, mais...",
      'Heure': '13h00',
      'status': FiltreTypeMessage.tout,
    },
    {
      'name': "Patients Diament",
      'Profils': 'assets/Illustrations/illustration_hopital.png',
      'Message': 'Promotion spécial sur tou...',
      'Heure': '10:30',
      'status': FiltreTypeMessage.groupe,
    },
    {
      'name': 'Dr. Dan Ntenta',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Message': 'Vous avez contracter le sida,...',
      'Heure': '9:00',
      'status': FiltreTypeMessage.prive,
    },
    {
      'name': 'Dr. Aristide Ntenta',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Message': 'Il serait judicieux de pren...',
      'Heure': '10:24',
      'status': FiltreTypeMessage.tout,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtreMessage = message.where((message) {
      return message['status'] == status;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0), // Couleur de fond blanche
        //iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Message",
            style: TextStyle(
              color: Colors.black,
            )),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (FiltreTypeMessage filtreMessage
                    in FiltreTypeMessage.values)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (filtreMessage == FiltreTypeMessage.tout) {
                            status = FiltreTypeMessage.tout;
                            _alignment = Alignment.centerLeft;
                          } else if (filtreMessage ==
                              FiltreTypeMessage.groupe) {
                            status = FiltreTypeMessage.groupe;
                            _alignment = Alignment.center;
                          } else if (filtreMessage == FiltreTypeMessage.prive) {
                            status = FiltreTypeMessage.prive;
                            _alignment = Alignment.centerRight;
                          }
                        });
                      },
                      child: Center(
                        child: Text(filtreMessage.toString().split('.')[1]),
                      ),
                    ),
                  ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F3F1),
                    borderRadius: BorderRadius.circular(11.13),
                    border:
                        Border.all(color: const Color(0xFFE8F3F1), width: 1.0),
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF66DED4),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        status.toString().split('.')[1],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtreMessage.length,
                itemBuilder: ((context, index) {
                  var message = filtreMessage[index];
                  bool isLastElement = index == filtreMessage.length - 1;
                  return Card(
                    color: Colors.white,
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(message['Profils']),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message['name'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        message['Message'],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        message['Heure'],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      // Barre de navigation
      bottomNavigationBar:BottomNavigationBar(
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
    );
  }
}
