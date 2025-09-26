import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 🔹 Data catatan
  final Map<DateTime, List<String>> _events = {};

  // 🔹 Ambil catatan untuk hari tertentu
  List<String> _getEventsForDay(DateTime day) {
    final tanggal = DateTime(day.year, day.month, day.day);
    return _events[tanggal] ?? [];
  }

  // 🔹 Tambah catatan
  void _tambahCatatan(DateTime day) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Catatan"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Masukkan catatan..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  final tanggal = DateTime(day.year, day.month, day.day);
                  _events.putIfAbsent(tanggal, () => []);
                  _events[tanggal]!.add(controller.text.trim());
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          )
        ],
      ),
    );
  }

  // 🔹 Hapus catatan
  void _hapusCatatan(DateTime day, String catatan) {
    final tanggal = DateTime(day.year, day.month, day.day);
    setState(() {
      _events[tanggal]?.remove(catatan);
      if (_events[tanggal]?.isEmpty ?? false) {
        _events.remove(tanggal); // hapus key kalau kosong
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.calendar_month, color: Color(0xFFD2C1B6)),
            SizedBox(width: 8),
            Text(
              "Calendar",
              style: TextStyle(color: Color(0xFFD2C1B6), fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1B3C53),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0xFF234C6A),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFFD2C1B6),
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _selectedDay == null
                ? const Center(child: Text("Pilih tanggal untuk melihat catatan"))
                : ListView(
                    children: _getEventsForDay(_selectedDay!).map((event) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(event),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _hapusCatatan(_selectedDay!, event),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          )
        ],
      ),
      floatingActionButton: _selectedDay == null
          ? null
          : FloatingActionButton(
              backgroundColor: const Color(0xFF234C6A),
              onPressed: () => _tambahCatatan(_selectedDay!),
              child: const Icon(Icons.add, color: Colors.white),
            ),
      backgroundColor: const Color(0xFFD2C1B6),
    );
  }
}
