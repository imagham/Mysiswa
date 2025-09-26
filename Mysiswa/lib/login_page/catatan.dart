import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Catatan extends StatefulWidget {
  const Catatan({super.key});

  @override
  State<Catatan> createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> {
  List<Map<String, String>> _catatanList = [];

  @override
  void initState() {
    super.initState();
    _loadCatatan();
  }

  // ✅ Load catatan dari local storage
  Future<void> _loadCatatan() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('catatanList');
    if (data != null) {
      setState(() {
        _catatanList = List<Map<String, String>>.from(json.decode(data));
      });
    }
  }

  // ✅ Save catatan ke local storage
  Future<void> _saveCatatan() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('catatanList', json.encode(_catatanList));
  }

  // Tambah catatan
  void _addCatatan() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Catatan"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Tulis catatan di sini..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _catatanList.add({
                    "text": controller.text,
                    "time": DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now()),
                  });
                });
                _saveCatatan(); // ✅ simpan setelah tambah
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  // Edit catatan
  void _editCatatan(int index) {
    TextEditingController controller =
        TextEditingController(text: _catatanList[index]["text"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Catatan"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Edit catatan..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _catatanList[index]["text"] = controller.text;
                  _catatanList[index]["time"] =
                      DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now());
                });
                _saveCatatan(); // ✅ simpan setelah edit
                Navigator.pop(context);
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  // Hapus catatan
  void _deleteCatatan(int index) {
    setState(() {
      _catatanList.removeAt(index);
    });
    _saveCatatan(); // ✅ simpan setelah hapus
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.edit_note, color: Color(0xFFD2C1B6)),
            SizedBox(width: 8),
            Text(
              "Catatan",
              style: TextStyle(
                color: Color(0xFFD2C1B6),
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1B3C53),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: _catatanList.isEmpty
            ? const Center(
                child: Text(
                  "Belum ada catatan",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : ListView.builder(
                itemCount: _catatanList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_catatanList[index]["time"].toString()),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) => _deleteCatatan(index),
                    child: GestureDetector(
                      onTap: () => _editCatatan(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1B3C53).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(_catatanList[index]["text"].toString()),
                          subtitle: Text(
                            _catatanList[index]["time"].toString(),
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCatatan,
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFD2C1B6),
    );
  }
}
