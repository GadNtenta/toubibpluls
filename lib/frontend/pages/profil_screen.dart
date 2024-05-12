import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../blocks/profil_menu/profil_menu.dart';
import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'maps_screen.dart';
import 'message_screen.dart';
import 'rdv_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      _navigateToPage(const Accueil());
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
    return Scaffold(
      backgroundColor: const Color(0xFF66DED4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 20),
                  _buildCardiacInfo(),
                  const SizedBox(height: 30),
                  _buildProfileMenu(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        SizedBox(
          width: 111,
          height: 111,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/Images/profil/medecin/Avatar.png'),
              ),
              Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: FloatingActionButton(
                  // Utilisation de BoxDecoration au lieu de la couleur directe
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {},
                  child: SvgPicture.asset(
                    "assets/Icons/Camera.svg",
                    width: 22.0,
                    height: 22.0,
                    color: const Color(0xFF66DED4),
                  ),
                ),
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Amelia Renata',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCardiacInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCardiacItem('assets/Icons/Heartbeat.svg', 'Rythme cardiaque', '215bpm'),
        const VerticalDivider(color: Colors.white),
        _buildCardiacItem('assets/Icons/flamme.svg', 'Calories', '756cal'),
        const VerticalDivider(color: Colors.white),
        _buildCardiacItem('assets/Icons/poid.svg', 'Poids', '75.6Kg'),
      ],
    );
  }

  Widget _buildCardiacItem(String iconPath, String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ImageIcones(
          ImageIcone: iconPath,
          width: 32.0,
          height: 32.0,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileMenu() {
    return  Column(
        children: [
          ProfilMenu(
            icon: 'assets/Icons/coeur.svg',
            text: 'Ma sélection',
            press: () {},
          ),
          ProfilMenu(
            icon: 'assets/Icons/Document.svg',
            text: 'Rendez-vous',
            press: () {},
          ),
          ProfilMenu(
            icon: 'assets/Icons/Wallet.svg',
            text: 'Fiche de santé',
            press: () {},
          ),
          ProfilMenu(
            icon: 'assets/Icons/Message.svg',
            text: 'FAQs',
            press: () {},
          ),
          ProfilMenu(
            icon: 'assets/Icons/Danger_Circle.svg',
            text: 'Déconnexion',
            press: () {},
          ),
        ],
    );
  }
  Widget ProfilMenu({
    required String icon,
    required String text,
    required VoidCallback press,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity, // Prend toute la largeur disponible
        child: FloatingActionButton(
          heroTag:
          null, // Évite les conflits de balises s'il y a plusieurs instances
          onPressed: press,
          backgroundColor:
          Colors.white, // Couleur de fond du FloatingActionButton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white), // Bordure blanche
          ), // Fonction appelée lors du clic
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SvgPicture.asset(icon, width: 22), // Affiche l'icône SVG
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: text == 'Déconnexion'
                        ? const TextStyle(color: Colors.red)
                        : const TextStyle(color: Colors.black),
                  ), // Affiche le texte avec une couleur différente pour la déconnexion
                ),
                const Icon(
                    Icons.arrow_forward_ios), // Icône de flèche vers la droite
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}
