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
    {"name": "Mobile App Dev", "instructor": "Emmanuel Botchway"},
    {"name": "Web Dev", "instructor": "Prof. Owusu"},
    {"name": "AI & ML", "instructor": "Dr. Agyeman"},
    {"name": "Databases", "instructor": "Mr. Boateng"},
    {"name": "Networking", "instructor": "Ms. Adjei"},
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
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
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
        return Center( // ✅ Center everything
          child: Column(
            mainAxisSize: MainAxisSize.min, // keeps it centered
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage("data:image/jpeg;base64,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"),
              ),
              SizedBox(height: 12),
              Text("Calvin Akiweley",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Student", style: TextStyle(color: Colors.black54)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: _showLogoutDialog,
                icon: Icon(Icons.logout),
                label: Text("Logout"),
              ),
            ],
          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


      // b. Bottom Navigation Tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // ✅ fix: keeps icon + label together
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Courses", // ✅ now works as one with icon
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),


    );
  }
}
