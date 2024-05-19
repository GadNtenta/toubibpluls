import 'package:flutter/material.dart';

import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'message_screen.dart';
import 'profil_screen.dart';
import 'rdv_screen.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  int _selectedIndex = 2;

  // Fonction appelée lorsqu'un élément de la barre de navigation est sélectionné
  void _onItemTapped(int index) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre de navigation
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
      body: const Scaffold(),
    );
  }
}
