import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../frontend/pages/user_connecter.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAppointment({
    required String doctorName,
    required String specialization,
    required String hospital,
    required String userId,
    required DateTime appointmentDateTime, required prolileDocteur, required type,
  }) async {
    try {
      await _firestore.collection('agenda').add({
        'prolileDocteur': prolileDocteur,
        'type': type,
        'doctorName': doctorName,
        'specialization': specialization,
        'hospital': hospital,
        'userId': userId,
        'appointmentDateTime': appointmentDateTime,
        'status': 'avenir',
      });
      globalUserID = userId;
    } catch (e) {
      // Gérer les erreurs éventuelles ici
      print(e.toString());
    }
  }
}
