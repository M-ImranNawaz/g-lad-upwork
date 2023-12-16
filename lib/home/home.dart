import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glad/settings/settings.dart';
import 'package:glad/today/today.dart';
import 'package:glad/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static  final List<Widget> _pages = <Widget>[
    TodayPage(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    SettingsPage()

  ];

  int _selectedIndex = 0; //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text("glad"),
        backgroundColor: AppColors.primaryColor,
      ),
      drawer:  Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),

      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: AppColors.lightPrimaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(


            icon: Icon(Icons.today),
            label: 'Today',

          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),

        ],
      ),
    );
  }
}