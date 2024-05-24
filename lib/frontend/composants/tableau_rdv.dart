import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toubibplus/backend/firebase/Firestore/rdv/data_tableau.dart';
import '../animations/skeleton/skeleton_tableau_agendas.dart';

class TableauRDV extends StatefulWidget {
  final String userId;

  const TableauRDV({required this.userId, super.key});

  @override
  _TableauRDVState createState() => _TableauRDVState();
}

class _TableauRDVState extends State<TableauRDV> {
  late Future<List<Map<String, dynamic>>> _appointmentsFuture;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = _firebaseService.getAppointments(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _appointmentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonLoader(); // Display the skeleton loader
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
      DateTime appointmentDateTime = (appointment['appointmentDateTime'] as Timestamp).toDate();
      String doctorName = appointment['doctorName'] ?? 'Docteur';
      String profileURL = '';

      // Fetch the doctor's profile URL
      _firebaseService.getDoctorProfileURL(doctorName).then((url) {
        setState(() {
          profileURL = url;
        });
      });

      return DataRow(cells: <DataCell>[
        DataCell(Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(CircleAvatar(backgroundImage: NetworkImage(profileURL))),
        DataCell(Text(doctorName, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(appointment['specialization'] ?? 'Spécialisation', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(appointment['type'] ?? 'Type', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(appointment['hospital'] ?? 'Hôpital', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(DateFormat('HH:mm').format(appointmentDateTime), style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(DateFormat('dd/MM/yyyy').format(appointmentDateTime), style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(
          appointment['status'] ? 'Confirmé' : 'En attente',
          style: TextStyle(fontWeight: FontWeight.bold, color: appointment['status'] ? Colors.green : Colors.red),
        )),
      ]);
    });
  }
}
