import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecode_2021/src/jobs_screen/favourite_job_screen.dart';
import 'package:wecode_2021/src/jobs_screen/jobs_board_screen.dart';
import 'package:wecode_2021/src/jobs_screen/list_of_jobs_screen.dart';
import 'package:wecode_2021/src/profile_screens/create_profile_screen.dart';
import 'package:wecode_2021/src/student_screen/news_student_screen.dart';
import 'package:wecode_2021/src/student_screen/student_linktree_view.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {

 int _currentIndex = 0;

  List<Widget> _screens = [
   
    ListOfJobsScreen(),
    FavouriteJobScreen(),
    //Todo: listOfNewsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        centerTitle: true,
           backgroundColor: Theme.of(context).primaryColor,
         actions: <Widget>[
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: IconButton(onPressed: () {
             Get.isDarkMode 
             ? Get.changeTheme(ThemeData.light()) : Get.changeTheme(ThemeData.dark());
           }, icon: Icon(Get.isDarkMode? Icons.mode_night: Icons.brightness_7), color: Colors.white,),
         ),
         ]
      ),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: new CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1551847812-f815b31ae67c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80"),
            ),
            accountName: Text("Student Name"),
            accountEmail: Text("Student@gmail.com"),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {},
          ),
          ListTile(
            title: Text("Edit Profile"),
            leading: Icon(Icons.edit),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () {},
          )
        ]),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobScreen(),
                  ),
                );
              },
              child: Text('to the jobs board'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsStudentScreen(
                      generalUser: null,
                    ),
                  ),
                );
              },
              child: Text('Student News'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
          ]),
      bottomNavigationBar: BottomNavigationBar(
       onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fav',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'News',
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
