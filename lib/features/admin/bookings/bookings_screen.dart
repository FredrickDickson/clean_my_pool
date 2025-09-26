import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  List<Map<String, String>> bookings = List.generate(10, (i) {
    return {
      'id': '#B${1000 + i}',
      'customer': 'Customer ${i + 1}',
      'cleaner': 'Cleaner ${i + 1}',
      'date': '2025-09-${10 + i}',
      'status': i % 4 == 0 ? 'Upcoming' : (i % 3 == 0 ? 'In Progress' : 'Completed'),
    };
  });
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _sortBookings(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      bookings.sort((a, b) {
        var aValue = a.values.elementAt(columnIndex);
        var bValue = b.values.elementAt(columnIndex);
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bookings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: const Text('Booking ID'),
                  onSort: (index, ascending) => _sortBookings(index, ascending),
                ),
                DataColumn(
                  label: const Text('Customer'),
                  onSort: (index, ascending) => _sortBookings(index, ascending),
                ),
                DataColumn(
                  label: const Text('Cleaner'),
                  onSort: (index, ascending) => _sortBookings(index, ascending),
                ),
                DataColumn(
                  label: const Text('Date'),
                  onSort: (index, ascending) => _sortBookings(index, ascending),
                ),
                DataColumn(
                  label: const Text('Status'),
                  onSort: (index, ascending) => _sortBookings(index, ascending),
                ),
              ],
              rows: bookings.map((booking) {
                return DataRow(cells: [
                  DataCell(Text(booking['id']!)),
                  DataCell(Text(booking['customer']!)),
                  DataCell(Text(booking['cleaner']!)),
                  DataCell(Text(booking['date']!)),
                  DataCell(Text(booking['status']!)),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}