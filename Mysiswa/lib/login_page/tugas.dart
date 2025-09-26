import 'package:flutter/material.dart';

class Tugas extends StatefulWidget {
  const Tugas({super.key});

  @override
  State<Tugas> createState() => _TugasState();
}

class _TugasState extends State<Tugas> {
  final List<Map<String, dynamic>> _tugasList = [];

  void _tambahTugas(String judul) {
    setState(() {
      _tugasList.add({
        "judul": judul,
        "selesai": false,
        "waktu": DateTime.now(),
      });
    });
  }

  void _hapusTugas(int index) {
    setState(() {
      _tugasList.removeAt(index);
    });
  }

  void _toggleSelesai(int index) {
    setState(() {
      _tugasList[index]["selesai"] = !_tugasList[index]["selesai"];
    });
  }

  void _showTambahDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Tugas"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Masukkan tugas..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                _tambahTugas(controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text("Tambah"),
          )
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
            Icon(Icons.assignment, color: Color(0xFFD2C1B6)),
            SizedBox(width: 8),
            Text("Tugas",
                style: TextStyle(color: Color(0xFFD2C1B6), fontSize: 18)),
          ],
        ),
        backgroundColor: const Color(0xFF1B3C53),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _tugasList.isEmpty
            ? const Center(
                child: Text("Belum ada tugas",
                    style: TextStyle(fontSize: 16, color: Colors.black54)),
              )
            : ListView.builder(
                itemCount: _tugasList.length,
                itemBuilder: (context, index) {
                  final tugas = _tugasList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Checkbox(
                        value: tugas["selesai"],
                        activeColor: const Color(0xFF234C6A),
                        onChanged: (_) => _toggleSelesai(index),
                      ),
                      title: Text(
                        tugas["judul"],
                        style: TextStyle(
                          fontSize: 16,
                          decoration: tugas["selesai"]
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(
                        "Ditambahkan: ${tugas["waktu"]}",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _hapusTugas(index),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTambahDialog,
        backgroundColor: const Color(0xFF234C6A),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: const Color(0xFFD2C1B6),
    );
  }
}
