import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:toubibplus/frontend/composants/tableau_rdv.dart';
import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'connexion.dart';
import 'maps_screen.dart';
import 'message_screen.dart';
import 'profil_screen.dart';

class RdvPage extends StatefulWidget {
  const RdvPage({super.key});

  @override
  State<RdvPage> createState() => _RdvPageState();
}

class _RdvPageState extends State<RdvPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        title: const Text(
          "Rendez-vous",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(
            Icons.notifications_none,
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          User? user = snapshot.data;

          if (user == null) {
            // L'utilisateur n'est pas connecté
            // Afficher une alerte ou une snackbar pour informer l'utilisateur
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Erreur'),
                  content: const Text('Une erreur est survenue. Veuillez vous connecter pour accéder à cette page.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Connexion(),
                          ),
                        );
                      },
                      child: const Text('Se connecter'),
                    ),
                  ],
                ),
              );
            });

            return const SizedBox.shrink(); // Retourne un widget vide
          }

          // L'utilisateur est connecté, afficher le tableau des rendez-vous
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(child: TableauRDV(userId: user.uid)), // Encapsuler dans un Expanded
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF66DED4),
        unselectedItemColor: Colors.grey.shade700,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
