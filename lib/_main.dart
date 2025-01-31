import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Data Siswa',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
      home: const MyHomePage(title: 'Aplikasi Data Siswa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final List<String> _classes = ['X', 'XI', 'XII'];
  final List<String> _majors = ['PPLG', 'MPLB', 'DKV', 'HR', 'TJKT', 'TM', 'TKR', 'TSM'];

  String? _selectedClass;
  String? _selectedMajor;

  List<Map<String, String>> _students = [];

  void _addStudent() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _selectedClass == null ||
        _selectedMajor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua form sebelum mengirim!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _students.add({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'class': _selectedClass!,
        'major': _selectedMajor!,
      });
      _firstNameController.clear();
      _lastNameController.clear();
      _selectedClass = null;
      _selectedMajor = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil ditambahkan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _editStudent(int index) {
    final student = _students[index];
    _firstNameController.text = student['firstName']!;
    _lastNameController.text = student['lastName']!;
    _selectedClass = student['class'];
    _selectedMajor = student['major'];

    setState(() {
      _students.removeAt(index);
    });
  }

  void _deleteStudent(int index) {
    setState(() {
      _students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil dihapus!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: "First Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: "Last Name"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedClass,
                items: _classes
                    .map((classItem) =>
                        DropdownMenuItem(value: classItem, child: Text(classItem)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClass = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Class"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedMajor,
                items: _majors
                    .map((majorItem) =>
                        DropdownMenuItem(value: majorItem, child: Text(majorItem)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMajor = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Major"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addStudent,
                child: const Text('Kirim'),
              ),
              const SizedBox(height: 20),
              ..._students.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> student = entry.value;

                return Card(
                  color: Colors.blue.shade50,
                  child: ListTile(
                    title: Text(
                      "${student['firstName']} ${student['lastName']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Class: ${student['class']}, Major: ${student['major']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editStudent(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(index),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
