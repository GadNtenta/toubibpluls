import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toubibplus/frontend/composants/tableau_rdv.dart';
import '../composants/image_icone/imageicone.dart';
import 'Home.dart';
import 'connexion.dart';
import 'maps_screen.dart';
import 'message_screen.dart';
import 'profil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import du package Firestore

class RdvPage extends StatefulWidget {
  const RdvPage({super.key});

  @override
  State<RdvPage> createState() => _RdvPageState();
}

class _RdvPageState extends State<RdvPage> {
  String? _userId; // Variable pour stocker l'ID de l'utilisateur

  @override
  void initState() {
    super.initState();
    // Appel de la méthode pour récupérer l'ID de l'utilisateur
    _getCurrentUserId();
  }

  // Méthode pour récupérer l'ID de l'utilisateur actuellement connecté
  void _getCurrentUserId() {
    // Utilisation de FirebaseAuth pour obtenir l'utilisateur actuellement connecté
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid; // Stockage de l'ID de l'utilisateur dans la variable _userId
      });
      _fetchUserAgendas(user.uid); // Appel de la méthode pour récupérer les données de la collection "agendas"
    } else {
      // L'utilisateur n'est pas connecté
      // Gérer le cas où l'utilisateur n'est pas connecté selon les besoins de votre application
    }
  }

  // Méthode pour récupérer les données de la collection "agendas" pour l'utilisateur actuel
  void _fetchUserAgendas(String userId) {
    FirebaseFirestore.instance
        .collection('agenda')
        .where('userId', isEqualTo: userId) // Filtrer les agendas par l'ID utilisateur
        .get()
        .then((QuerySnapshot querySnapshot) {
      // Traiter les données récupérées ici
      if (querySnapshot.docs.isNotEmpty) {
        // Il y a des documents dans la collection "agendas" pour cet utilisateur
        // Vous pouvez les traiter ici
        // Par exemple, vous pouvez les stocker dans une liste pour une utilisation ultérieure
        List<Map<String, dynamic>> userAgendas = [];
        querySnapshot.docs.forEach((doc) {
          userAgendas.add(doc.data() as Map<String, dynamic>);
        });
        // Vous pouvez utiliser ces données dans votre widget ici si nécessaire
      } else {
        // Aucun document dans la collection "agendas" pour cet utilisateur
        // Gérer le cas où aucun agenda n'est trouvé pour cet utilisateur
        print(' Aucun document dans la collection "agendas" pour cet utilisateur');
      }
    }).catchError((error) {
      // Gérer les erreurs de récupération des données de Firestore
      print('Error fetching user agendas: $error');
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: TableauRDV(), // Encapsuler dans un Expanded
            ),
          ],
        ),
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
