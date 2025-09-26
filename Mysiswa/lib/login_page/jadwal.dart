import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  // Data jadwal mingguan
  Map<String, List<Map<String, String>>> _jadwalMingguan = {
    "Senin": [
      {"matkul": "Matematika", "waktu": "07:00 - 08:30"},
      {"matkul": "Bahasa Inggris", "waktu": "09:00 - 10:30"},
    ],
    "Selasa": [
      {"matkul": "IPA", "waktu": "07:00 - 08:30"},
      {"matkul": "IPS", "waktu": "09:00 - 10:30"},
    ],
    "Rabu": [
      {"matkul": "Sejarah", "waktu": "07:00 - 08:30"},
    ],
    "Kamis": [
      {"matkul": "Olahraga", "waktu": "08:00 - 09:30"},
    ],
    "Jumat": [
      {"matkul": "Agama", "waktu": "07:00 - 08:30"},
    ],
    "Sabtu": [],
    "Minggu": [],
  };

  @override
  void initState() {
    super.initState();
    _loadJadwal();
  }

  // 🔹 Simpan jadwal ke local storage
  Future<void> _saveJadwal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("jadwal", jsonEncode(_jadwalMingguan));
  }

  // 🔹 Ambil jadwal dari local storage
  Future<void> _loadJadwal() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("jadwal");
    if (data != null) {
      setState(() {
        _jadwalMingguan = (jsonDecode(data) as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            List<Map<String, String>>.from(
              (value as List).map((e) => Map<String, String>.from(e)),
            ),
          ),
        );
      });
    }
  }

  // 🔹 Tambah jadwal baru
  void _tambahJadwal() {
    String? selectedHari;
    TextEditingController matkulController = TextEditingController();
    TextEditingController waktuController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Jadwal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Pilih Hari"),
              items: _jadwalMingguan.keys.map((hari) {
                return DropdownMenuItem(
                  value: hari,
                  child: Text(hari),
                );
              }).toList(),
              onChanged: (val) {
                selectedHari = val;
              },
            ),
            TextField(
              controller: matkulController,
              decoration: const InputDecoration(labelText: "Mata Pelajaran"),
            ),
            TextField(
              controller: waktuController,
              decoration:
                  const InputDecoration(labelText: "Waktu (contoh: 07:00 - 08:30)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedHari != null &&
                  matkulController.text.isNotEmpty &&
                  waktuController.text.isNotEmpty) {
                setState(() {
                  _jadwalMingguan[selectedHari]!.add({
                    "matkul": matkulController.text,
                    "waktu": waktuController.text,
                  });
                });
                _saveJadwal(); // simpan setelah tambah
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.event, color: Color(0xFFD2C1B6)),
            SizedBox(width: 8),
            Text(
              "Jadwal ",
              style: TextStyle(color: Color(0xFFD2C1B6), fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1B3C53),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _jadwalMingguan.keys.map((hari) {
          final kegiatan = _jadwalMingguan[hari]!;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: ExpansionTile(
              title: Text(
                hari,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1B3C53),
                ),
              ),
              children: kegiatan.isEmpty
                  ? [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Tidak ada jadwal",
                            style: TextStyle(color: Colors.black54)),
                      )
                    ]
                  : kegiatan.map((mapel) {
                      return ListTile(
                        title: Text(mapel["matkul"]!),
                        subtitle: Text(mapel["waktu"]!),
                        leading:
                            const Icon(Icons.book, color: Color(0xFF234C6A)),
                      );
                    }).toList(),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwal,
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFD2C1B6),
    );
  }
}
