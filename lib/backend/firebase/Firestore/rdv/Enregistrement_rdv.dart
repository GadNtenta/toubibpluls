import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAppointment({
    required String doctorName,
    required String specialization,
    required String hospital,
    required String userId,
    required DateTime appointmentDateTime,
  }) async {
    try {
      await _firestore.collection('agenda').add({
        'doctorName': doctorName,
        'specialization': specialization,
        'hospital': hospital,
        'userId': userId,
        'appointmentDateTime': appointmentDateTime,
        'status': 'avenir',
      });
    } catch (e) {
      // Gérer les erreurs éventuelles ici
      print(e.toString());
    }
  }
}
