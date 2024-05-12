import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:table_calendar/table_calendar.dart';

import '../composants/image_icone/imageicone.dart';
import 'docteur_screen.dart';

class Detailsdocteurs extends StatefulWidget {
  const Detailsdocteurs({Key? key}) : super(key: key);

  @override
  _DetailsdocteursState createState() => _DetailsdocteursState();
}

class _DetailsdocteursState extends State<Detailsdocteurs> {
  DateTime? selectedDate;
  String? selectedTime;

  CalendarFormat _calendarFormat =
      CalendarFormat.week; // Réglage pour afficher uniquement la semaine
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    // Initialise les données de localisation pour la langue française
    initializeDateFormatting('fr_FR', null);
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Docteurs(),
              ),
            );
          },
        ),
      ),
      body: Column(
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
                        // code  pour l'image du médecin
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/Images/profil/medecin/medecin.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 111,
                          height: 111,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // code existant pour les informations du médecin
                            Text(
                              'Dr. Nom du Médecin',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Spécialisation du Médecin'),
                            Text('Note du Médecin'),
                            Text('Nom de l\'hôpital'),
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
                          setState(() {
                            _selectedDay = selectedDay;
                          });
                        },
                        calendarStyle: CalendarStyle(
                          defaultTextStyle: const TextStyle(color: Colors.black),
                          weekendTextStyle: const TextStyle(color: Colors.grey),
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            //color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          selectedDecoration: BoxDecoration(
                            color: const Color(
                                0xFF66DED4), // Arrière-plan vert pour la date sélectionnée
                            border: Border.all(
                                width: 2,
                                color: const Color(0xFF66DED4)), // Bordure verte
                            borderRadius: BorderRadius.circular(8),
                          ),
                          todayTextStyle: const TextStyle(
                              color: Colors.blue), // Style pour la date du jour
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                              color: Colors.grey), // Couleur du week-end
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
    bool isSelected = _selectedTime != null && _selectedTime!.hour == hour;

    return InkWell(
      onTap: () {
        setState(() {
          // Met à jour l'heure sélectionnée
          _selectedTime = TimeOfDay(hour: hour, minute: 0);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? const Color(0xFF66DED4) : Colors.white,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Fonction pour effectuer la prise de rendez-vous
  void _takeAppointment(BuildContext context) {
    if (_selectedDay != null && _selectedTime != null) {
      //espâce des mesures pour enregistrer le rendez-vous
      DateTime selectedDateTime = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text:
        'Votre rendez-vous est fixé pour le ${DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime)}',
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Veuillez sélectionner une date et une heure de rendez-vous.',
      );
    }
  }
}
