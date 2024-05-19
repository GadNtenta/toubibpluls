import 'package:flutter/material.dart';
import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'maps_screen.dart';
import 'message_screen.dart';
import 'profil_screen.dart';

class RdvPage extends StatefulWidget {
  const RdvPage({super.key});

  @override
  State<RdvPage> createState() => _RdvPageState();
}

enum FilterStatus { avenir, achever, annuler }

class _RdvPageState extends State<RdvPage> {
  int _selectedIndex = 3;
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
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MessagePage(),
        ),
      );
    } else if (_selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapsPage(),
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

  FilterStatus status = FilterStatus.avenir;
  Alignment _alignment = Alignment.centerLeft;
  List<Map<String, dynamic>> horaires = [
    {
      'name': 'Dr. Isaac Kumwimba',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Cardiologue',
      'status': FilterStatus.avenir,
    },
    {
      'name': 'Dr. Gad Ntenta',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Generaliste',
      'status': FilterStatus.achever,
    },
    {
      'name': 'Dr. Dan Ntenta',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Ophtalmologue',
      'status': FilterStatus.annuler,
    },
    {
      'name': 'Dr. Aristide Ntenta',
      'Profils': 'assets/Images/profil/medecin/Avatar.png',
      'Specialisation': 'Cardiologue',
      'status': FilterStatus.avenir,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtreRdv = horaires.where((horaire) {
      return horaire['status'] == status;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0), // Couleur de fond blanche
        //iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Rendez-vous",
            style: TextStyle(
              color: Colors.black,
            )),
        actions: const [
          Icon(
            Icons.notifications_none,
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
                for (FilterStatus filtreRdv in FilterStatus.values)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (filtreRdv == FilterStatus.avenir) {
                            status = FilterStatus.avenir;
                            _alignment = Alignment.centerLeft;
                          } else if (filtreRdv == FilterStatus.achever) {
                            status = FilterStatus.achever;
                            _alignment = Alignment.center;
                          } else if (filtreRdv == FilterStatus.annuler) {
                            status = FilterStatus.annuler;
                            _alignment = Alignment.centerRight;
                          }
                        });
                      },
                      child: Center(
                        child: Text(filtreRdv.toString().split('.')[1]),
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
                itemCount: filtreRdv.length,
                itemBuilder: ((context, index) {
                  var horaire = filtreRdv[index];
                  bool isLastElement = index == filtreRdv.length - 1;
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    horaire['name'],
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
                                    horaire['Specialisation'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(horaire['Profils']),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          // Date, heure du rdv
                          const Horairecard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE8F3F1)),
                                  onPressed: () {},
                                  child: const Text(
                                    'Annuler',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0xFF66DED4)),
                                  onPressed: () {},
                                  child: const Text(
                                    'Reprogrammer',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
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

class Horairecard extends StatelessWidget {
  const Horairecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '26/06/2024',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.access_alarm_rounded,
              color: Colors.grey,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '10:30',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.circle,
              color: Colors.green,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Confirmé',
              style: TextStyle(color: Colors.grey),
            ),
          ]),
    );
  }
}
