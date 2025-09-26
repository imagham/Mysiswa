import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dasar/login_page/inbox.dart';

class homepage1 extends StatefulWidget {
  final String username;
  const homepage1({super.key, required this.username});

  @override
  State<homepage1> createState() => _homepage1State();
}

class _homepage1State extends State<homepage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inbox()),
              );
            },
            icon: const Icon(Icons.notifications, color: Color(0xFFD2C1B6)),
          ),
        ],
        backgroundColor: const Color(0xFF1B3C53),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 Greeting Card
            Card(
              color: const Color(0xFF234C6A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assalamualaikum, ${widget.username} 👋",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD2C1B6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Semoga harimu penuh semangat dan produktif!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Quick Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickMenu(Icons.edit_note, "Catatan", '/catatan'),
                _buildQuickMenu(Icons.event, "Jadwal", '/jadwal'),
                _buildQuickMenu(Icons.assignment, "Tugas", '/tugas'),
                _buildQuickMenu(Icons.calendar_month, "Kalender", '/calendar'),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Info Card / Motivasi
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.lightbulb, color: Color(0xFF234C6A)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Tips hari ini: Jangan tunda pekerjaanmu, selesaikan sedikit demi sedikit ✨",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: const Color(0xFF234C6A),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 🔹 Bottom Navbar
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1B3C53),
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              color: const Color(0xFFD2C1B6),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              color: const Color(0xFFD2C1B6),
              onPressed: () {
                Navigator.pushNamed(context, '/school');
              },
              icon: const Icon(Icons.school),
            ),
            const SizedBox(width: 50),
            IconButton(
              color: const Color(0xFFD2C1B6),
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              icon: const Icon(Icons.calendar_month),
            ),
            IconButton(
              color: const Color(0xFFD2C1B6),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),

      backgroundColor: const Color(0xFFD2C1B6),
    );
  }

  // 🔹 Widget untuk Quick Menu
  Widget _buildQuickMenu(IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF1B3C53),
            radius: 28,
            child: Icon(icon, color: Color(0xFFD2C1B6), size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
