import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toubibplus/backend/firebase/Firestore/rdv/Enregistrement_rdv.dart';
import 'package:toubibplus/backend/firebase/authentification/AuthService_connexion.dart';
import 'package:toubibplus/frontend/composants/tableau_rdv.dart';
import '../animations/skeleton/skeleton_repres_docteurs_detailsdocteurs.dart';
import '../composants/image_icone/imageicone.dart';

class Detailsdocteurs extends StatefulWidget {
  final String doctorId;

  const Detailsdocteurs({required this.doctorId, Key? key}) : super(key: key);

  @override
  _DetailsdocteursState createState() => _DetailsdocteursState();
}

class _DetailsdocteursState extends State<Detailsdocteurs> {
  DateTime? selectedDate;
  String? selectedTime;
  CalendarFormat _calendarFormat = CalendarFormat.week; // Réglage pour afficher uniquement la semaine
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay? _selectedTime;

  Map<String, dynamic>? doctorDetails;

  @override
  void initState() {
    super.initState();
    // Initialise les données de localisation pour la langue française
    initializeDateFormatting('fr_FR', null);
    // Récupère les détails du docteur
    _getDoctorDetails();
  }

  Future<void> _getDoctorDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('docteurs').doc(widget.doctorId).get();
      if (doc.exists) {
        setState(() {
          doctorDetails = doc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails sur le médecin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigue vers la page précédente (Docteurs) en cliquant sur la flèche de retour
            Navigator.pop(context);
          },
        ),
      ),
      body: doctorDetails == null
          ? const SkeletonLoader() // Utiliser le SkeletonLoader pendant le chargement
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Section pour afficher les détails du médecin
                    Row(
                      children: [
                        // Code pour l'image du médecin
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(doctorDetails!['profileURL'] ?? 'assets/Images/profil/medecin/medecin.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 111,
                          height: 111,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Code existant pour les informations du médecin
                            Text(
                              'Dr. ${doctorDetails!['noms'] ?? 'Nom du Médecin'}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              doctorDetails!['specialisation'] ?? 'Spécialisation du Médecin',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              color: const Color(0xFFE8F3F1),
                              child: Row(
                                children: [
                                  const ImageIcones(
                                    ImageIcone: "assets/Icons/Star.svg",
                                    width: 12.0,
                                    height: 12.0,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${doctorDetails!['note'] ?? 'Note du Médecin'}'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const ImageIcones(
                                  ImageIcone: "assets/Icons/location.svg",
                                  width: 12.0,
                                  height: 12.0,
                                ),
                                const SizedBox(width: 4),
                                Text(doctorDetails!['hopital'] ?? 'Nom de l\'hôpital'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'À propos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Text('${doctorDetails!['Description'] ?? 'Aucune description'}'),

                          Text(
                            LoremIpsumGenerator.generate(paragraphs: 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Calendrier pour choisir la date de rendez-vous
                    SingleChildScrollView(
                      child: TableCalendar(
                        locale: 'fr_FR',
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2090, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (selectedDay.isBefore(DateTime.now())) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: 'Zone inclicable',
                            );
                          } else {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        },
                        calendarStyle: CalendarStyle(
                          defaultTextStyle: const TextStyle(color: Colors.black),
                          weekendTextStyle: const TextStyle(color: Colors.grey),
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          selectedDecoration: BoxDecoration(
                            color: const Color(0xFF66DED4), // Arrière-plan vert pour la date sélectionnée
                            border: Border.all(
                                width: 2, color: const Color(0xFF66DED4)), // Bordure verte
                            borderRadius: BorderRadius.circular(8),
                          ),
                          todayTextStyle: const TextStyle(color: Colors.blue), // Style pour la date du jour
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekendStyle: TextStyle(color: Colors.grey), // Couleur du week-end
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
          // Ligne de séparation entre le calendrier et la section des heures de rendez-vous
          Container(
            height: 1, // Hauteur de la ligne de séparation
            color: const Color(0xFF66DED4),
          ),
          // Section pour choisir l'heure de rendez-vous
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choisir l\'heure de rendez-vous',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                // Affiche les boutons pour choisir l'heure
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 9; i <= 11; i++) _buildTimeButton(i),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 13; i <= 15; i++) _buildTimeButton(i),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 18; i <= 20; i++) _buildTimeButton(i),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ImageIcones(
                ImageIcone: 'assets/Icons/Message.svg',
                width: 21.0,
                height: 21.0,
              ),
              SizedBox(
                width: 266,
                height: 50,
                child: ElevatedButton(
                  onPressed: _selectedDay != null
                      ? () => _takeAppointment(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF66DED4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Prendre rendez-vous',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  // Fonction pour construire les boutons d'heure
  Widget _buildTimeButton(int hour) {
    String time = '${hour.toString().padLeft(2, '0')}:00';
    DateTime now = DateTime.now();
    bool isPast = _selectedDay.isAtSameMomentAs(DateTime.now()) && (hour < now.hour || (hour == now.hour && now.minute > 0));
    bool isSelected = _selectedTime != null && _selectedTime!.hour == hour;

    return InkWell(
      onTap: isPast ? () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Zone inclicable',
        );
      } : () {
        setState(() {
          // Met à jour l'heure sélectionnée
          _selectedTime = TimeOfDay(hour: hour, minute: 0);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isPast ? Colors.grey : Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? const Color(0xFF66DED4) : Colors.white,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isPast ? Colors.grey : isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Fonction pour effectuer la prise de rendez-vous
  void _takeAppointment(BuildContext context) async {
    if (_selectedDay != null && _selectedTime != null) {
      // Prépare les données pour enregistrer le rendez-vous
      DateTime selectedDateTime = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      AuthService authService = AuthService();
      String? userId = await authService.getCurrentUserID();

      if (userId != null) {
        try {
          await DatabaseService().addAppointment(
            doctorName: doctorDetails!['noms'] ?? 'Nom du Médecin',
            specialization: doctorDetails!['specialisation'] ?? 'Spécialisation du Médecin',
            hospital: doctorDetails!['hopital'] ?? 'Independant',
            type : doctorDetails!['type'] ?? 'non-affilié',
            prolileDocteur: doctorDetails!['profileURL'] ?? 'assets/Images/profil/medecin/medecin.png',
            userId: userId,
            appointmentDateTime: selectedDateTime,
          );

          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Votre rendez-vous est fixé pour le ${DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime)}',
          );
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Une erreur est survenue lors de la prise de rendez-vous.',
          );
        }
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Vous n\'êtes pas connecté. Veuillez vous connecter pour prendre un rendez-vous.',
        );
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Veuillez sélectionner une date et une heure de rendez-vous.',
      );
    }
  }
}
