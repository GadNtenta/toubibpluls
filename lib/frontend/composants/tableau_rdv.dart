import 'package:flutter/material.dart';

class TableauRDV extends StatelessWidget {
  const TableauRDV({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: _buildDataColumns(),
          rows: _buildDataRows(context),
        ),
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

  List<DataRow> _buildDataRows(BuildContext context) {
    return <DataRow>[
      DataRow(cells: <DataCell>[
        const DataCell(Text('1', style: TextStyle(fontWeight: FontWeight.bold))),
        _buildProfileCell(),
        const DataCell(Text('Docteur', style: TextStyle(fontWeight: FontWeight.bold))),
        const DataCell(Text('Spécialisation', style: TextStyle(fontWeight: FontWeight.bold))),
        const DataCell(Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
        const DataCell(Text('Hôpital', style: TextStyle(fontWeight: FontWeight.bold))),
        _buildTimeCell(context),
        _buildDateCell(context),
        _buildStatusCell(true),
      ]),
      // Ajoutez d'autres DataRow ici si nécessaire
    ];
  }

  DataCell _buildProfileCell() {
    return const DataCell(
      CircleAvatar(
        backgroundColor: Colors.blue,
      ),
    );
  }

  DataCell _buildTimeCell(BuildContext context) {
    return DataCell(
      Row(
        children: [
          const Text('Heure', style: TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showPopup(context),
          ),
        ],
      ),
    );
  }

  DataCell _buildDateCell(BuildContext context) {
    return DataCell(
      Row(
        children: [
          const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showPopup(context),
          ),
        ],
      ),
    );
  }

  DataCell _buildStatusCell(bool status) {
    return DataCell(
      Text(
        'Statut',
        style: TextStyle(fontWeight: FontWeight.bold, color: status ? Colors.green : Colors.red),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifier'),
          content: const Text('Contenu de la fenêtre pop-up.'),
          actions: [
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
