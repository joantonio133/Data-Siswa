import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siswa_app/view/history_view.dart';
import 'package:siswa_app/view/profile_view.dart';
import 'package:siswa_app/view/home_view.dart';


void main() => runApp(const Home());

class Home  extends StatelessWidget {
  const Home ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PPLG App",
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  int _currentindex = 0;
  final tabs  = [
    const HomeView(),
    const HistoryView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text("PPLG App"),
        backgroundColor: Color(0xff40A2D8),
        titleTextStyle: GoogleFonts.roboto(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: 27,
        fontWeight: FontWeight.w700,
        
      ),
            
        
      ),
      body: tabs[_currentindex],
      bottomNavigationBar: 
      BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: (index) {
          setState(() => _currentindex = index);
        },
        items: [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}