import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toubibplus/backend/firebase/authentification/deconnexion_service.dart';
import 'package:toubibplus/frontend/messages/toast.dart';
import 'package:toubibplus/frontend/pages/user_connecter.dart';
import '../blocks/profil_menu/profil_menu.dart';
import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'connexion.dart';
import 'maps_screen.dart';
import 'message_screen.dart';
import 'rdv_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;
  String? userName;
  String? userSurname;
  String? userProfileUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (globalUserID != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(globalUserID).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

        setState(() {
          userName = userData?['nom'] as String?;
          userSurname = userData?['prenom'] as String?;
          userProfileUrl = userData?['profile'] as String?;
        });

        _checkAndShowNameInputDialog();
      }
    }
  }


  void _checkAndShowNameInputDialog() {
    if (userName == null || userSurname == null || userName!.isEmpty || userSurname!.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final TextEditingController nameController = TextEditingController();
            final TextEditingController surnameController = TextEditingController();

            return AlertDialog(
              title: Text('Veuillez saisir votre nom et prénom'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nom'),
                  ),
                  TextField(
                    controller: surnameController,
                    decoration: InputDecoration(labelText: 'Prénom'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty && surnameController.text.isNotEmpty) {
                      await FirebaseFirestore.instance.collection('users').doc(globalUserID).update({
                        'nom': nameController.text,
                        'prenom': surnameController.text,
                      });

                      setState(() {
                        userName = nameController.text;
                        userSurname = surnameController.text;
                      });

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            );
          },
        );
      });
    }
  }


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
              CircleAvatar(
                backgroundImage: userProfileUrl != null
                    ? NetworkImage(userProfileUrl!)
                    : const AssetImage('assets/squelettons/avatar-man-b_w.png') as ImageProvider,
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
        Text(
          userName != null && userSurname != null ? '$userName $userSurname' : '',
          textAlign: TextAlign.center,
          style: const TextStyle(
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
    return Column(
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
          press: () {
            signOutAndNavigate(context, showToast);
            // Navigation vers l'écran de connexion
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Connexion(),
              ),
            );
          },
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
      type: BottomNavigationBarType.fixed, // Type de la barre de navigation (fixe)
      showSelectedLabels: false, // Ne pas afficher les labels des éléments sélectionnés
      showUnselectedLabels: false, // Ne pas afficher les labels des éléments non sélectionnés
      currentIndex: _selectedIndex, // Index de l'élément actuellement sélectionné
      onTap: _onItemTapped, // Fonction appelée lorsque l'utilisateur sélectionne un élément
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

  Future<void> _showNameInputDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    bool isFormValid = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: false, // Le popup ne peut pas être fermé en cliquant en dehors
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Veuillez saisir votre nom et prénom'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Nom'),
                      onChanged: (value) {
                        setState(() {
                          isFormValid = nameController.text.isNotEmpty && surnameController.text.isNotEmpty;
                        });
                      },
                    ),
                    TextField(
                      controller: surnameController,
                      decoration: const InputDecoration(hintText: 'Prénom'),
                      onChanged: (value) {
                        setState(() {
                          isFormValid = nameController.text.isNotEmpty && surnameController.text.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Enregistrer'),
                  onPressed: isFormValid
                      ? () {
                    _saveUserNameAndSurname(nameController.text, surnameController.text);
                    Navigator.of(context).pop();
                  }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveUserNameAndSurname(String name, String surname) async {
    if (globalUserID != null) {
      await FirebaseFirestore.instance.collection('users').doc(globalUserID).update({
        'nom': name,
        'prenom': surname,
      });
      setState(() {
        userName = name;
        userSurname = surname;
      });
    }
  }
}
