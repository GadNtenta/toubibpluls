import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAppointments(String userId) async {
    List<Map<String, dynamic>> appointments = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('agendas')
          .where('userId', isEqualTo: userId)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> appointmentData = doc.data() as Map<String, dynamic>;
        // Add the document ID to the data
        appointmentData['id'] = doc.id;
        appointments.add(appointmentData);
      }
    } catch (e) {
      print('Error getting appointments: $e');
    }
    return appointments;
  }

  Future<String> getDoctorProfileURL(String doctorName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('docteurs')
          .where('noms', isEqualTo: doctorName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['profileURL'];
      } else {
        return 'default_image_path'; // Path to a default image
      }
    } catch (e) {
      print('Error getting doctor profile URL: $e');
      return 'default_image_path';
    }
  }
}
