import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import du package Firestore
import 'package:firebase_auth/firebase_auth.dart';

// Service pour récupérer les rendez-vous depuis Firestore
class AppointmentService {
  Future<List<Map<String, dynamic>>> getAppointments(String userId) async {
    try {
      // Récupérer les documents de la collection "agenda" filtrés par l'ID utilisateur
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('agenda')
          .where('userId', isEqualTo: userId)
          .get();

      // Mapper les données des documents en List<Map<String, dynamic>>
      List<Map<String, dynamic>> appointments = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()!;
        // Convertir le champ 'appointmentDateTime' de type Timestamp en DateTime
        data['appointmentDateTime'] = (data['appointmentDateTime'] as Timestamp).toDate();
        return data;
      }).toList();
      return appointments;
    } catch (error) {
      // Gérer les erreurs de récupération des données
      print('Error fetching appointments: $error');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

  Future<String> getDoctorProfileURL(String doctorName) async {
    // Simulated profile URL fetch
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
    return 'assets/squelettons/avatar-man-b_w.png';
  }
}

class TableauRDV extends StatefulWidget {
  const TableauRDV({Key? key}) : super(key: key);

  @override
  _TableauRDVState createState() => _TableauRDVState();
}

class _TableauRDVState extends State<TableauRDV> {
  late Future<List<Map<String, dynamic>>> _appointmentsFuture;
  final AppointmentService _appointmentService = AppointmentService();

  @override
  void initState() {
    super.initState();
    // Récupérer l'ID de l'utilisateur actuellement connecté
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    // Appeler la méthode getAppointments() en passant l'ID utilisateur
    _appointmentsFuture = _appointmentService.getAppointments(userId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildShimmer();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No appointments found.'));
          }

          List<Map<String, dynamic>> appointments = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: _buildDataColumns(),
                rows: _buildDataRows(context, appointments),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 16.0,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  List<DataColumn> _buildDataColumns() {
    return const <DataColumn>[
      DataColumn(label: Text('Numéro', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Profile du docteur', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Docteur', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Spécialisation', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Hôpital', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Heure', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Statut', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }

  List<DataRow> _buildDataRows(BuildContext context, List<Map<String, dynamic>> appointments) {
    return List<DataRow>.generate(appointments.length, (index) {
      Map<String, dynamic> appointment = appointments[index];
      DateTime appointmentDateTime = appointment['appointmentDateTime'] as DateTime;
      String doctorName = appointment['doctorName'] ?? 'Docteur';

      return DataRow(cells: <DataCell>[
      DataCell(Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold))),
    DataCell(
    FutureBuilder<String>(
    future: _appointmentService.getDoctorProfileURL(doctorName),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircleAvatar(
    backgroundColor: Colors.grey,
    child: Icon(Icons.person, color: Colors.white),
    );
    } else if (snapshot.hasError) {
    return CircleAvatar(
    backgroundColor: Colors.grey,
    child: Icon(Icons.error, color: Colors.white),
    );
    } else {
    String profileURL = snapshot.data!;
    return CircleAvatar(backgroundImage: AssetImage(profileURL));
    }
    },
    ),
    ),
    DataCell(Text(doctorName, style: const TextStyle(fontWeight: FontWeight.bold))),
    DataCell(Text(appointment['specialization'] ?? 'Spécialisation', style: const TextStyle(fontWeight: FontWeight.bold))),
    DataCell(Text(appointment['type'] ?? 'Type', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(appointment['hospital'] ?? 'Hôpital', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(DateFormat('HH:mm').format(appointmentDateTime), style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(DateFormat('dd/MM/yyyy').format(appointmentDateTime), style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(
          Text(
            appointment['status'] == 'confirmé' ? 'Confirmé' : 'En attente',
            style: TextStyle(fontWeight: FontWeight.bold, color: appointment['status'] == 'confirmé' ? Colors.green : Colors.red),
          ),
        ),

      ]);
    });
  }
}
