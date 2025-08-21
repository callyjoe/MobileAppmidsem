import 'package:flutter/material.dart';

void main() {
  runApp(CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Course Dashboard",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CourseDashboard(),
    );
  }
}

class CourseDashboard extends StatefulWidget {
  @override
  _CourseDashboardState createState() => _CourseDashboardState();
}

class _CourseDashboardState extends State<CourseDashboard> {
  int _selectedIndex = 0;
  String selectedCategory = "Science";
  double buttonSize = 60;

  final List<Map<String, dynamic>> courses = [
    {"name": "Mobile App Dev", "instructor": "Emmanuel Botchway", "icon": Icons.phone_android},
    {"name": "Web Dev", "instructor": "Prof. Owusu", "icon": Icons.web},
    {"name": "AI & ML", "instructor": "Dr. Agyeman", "icon": Icons.memory},
    {"name": "Databases", "instructor": "Mr. Boateng", "icon": Icons.storage},
    {"name": "Networking", "instructor": "Ms. Adjei", "icon": Icons.wifi},
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0: // Home
        return Center(
          child: Text(
            "Welcome to the Course Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
        );

      case 1: // Courses
        return Column(
          children: [
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              items: ["Science", "Arts", "Technology"]
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            Text("Selected Category: $selectedCategory",
                style: TextStyle(color: Colors.black87)),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(course["icon"], color: Colors.blueAccent),
                      title: Text(course["name"],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Instructor: ${course["instructor"]}"),
                    ),
                  );
                },
              ),
            ),
          ],
        );

      case 2: // Profile
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            SizedBox(height: 10),
            Text("Calvin Rizzler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Student", style: TextStyle(color: Colors.black54)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _showLogoutDialog,
              icon: Icon(Icons.logout),
              label: Text("Logout"),
            ),
          ],
        );

      default:
        return Center(child: Text("Unknown Tab"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ["Home", "Courses", "Profile"][_selectedIndex],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: _buildBody(),

      // d. Animated Action Button
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            buttonSize = buttonSize == 60 ? 90 : 60;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Icon(Icons.school, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // b. Bottom Navigation Tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
